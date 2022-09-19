//
//  WorkOrderDetailVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/16.
//

#import "WorkOrderDetailVC.h"
#import "WorkOrderDetailCell.h"
#import "WorkOrderDetailChangeVC.h"
#import "OrderDetailResponse.h"
#import <PrinterSDK/PrinterSDK.h>
#import "BluetoochMatchVC.h"
#import "LoginInfoManage.h"
#import "ConfigModel.h"
@interface WorkOrderDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<OrderDetailResponse *> *source;
@property (nonatomic, strong) ConfigModel *workConfigModel;
@property (nonatomic, assign) BOOL isDeleted;
@end

@implementation WorkOrderDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"工单详情";
    [self customerUI];
    [self getConfig];
    [self loadData];
}

- (void)getConfig
{
    WeakSelf(self)
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:pcdetails argument:@{@"projectId":self.projectId}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            weakself.workConfigModel = [ConfigModel mj_objectWithKeyValues:result[@"data"][@"content"]];
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

- (void)loadData
{
    if (![Tools isEmpty:self.plateNumber])
    {
        [self queryCarData];
    }
    else
    {
        [self requestData];
    }
}

- (RACSubject *)subject
{
    if (!_subject)
    {
        _subject = [RACSubject new];
    }
    return _subject;
}

- (void)queryCarData
{
    WeakSelf(self)
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:workerorderquery argument:@{@"startTime":self.startTime,
                                                                                             @"endTime":self.endTime,
                                                                                             @"deleteFlag":@"",
                                                                                             @"isException":@"",
                                                                                             @"isZd":@"",
                                                                                             @"workType":self.workType,
                                                                                             @"projectId":self.projectId,
                                                                                             @"plateNumber":self.plateNumber}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            weakself.source = [OrderDetailResponse mj_objectArrayWithKeyValuesArray:result[@"data"]];
            for (int i = 0; i < weakself.source.count;i++)
            {
                OrderDetailResponse *response = weakself.source[i];
                response.name = [NSString stringWithFormat:@"%@第%ld车",[response.created substringToIndex:10],weakself.source.count - i];
            }
            [weakself.tableView reloadData];
           
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

- (void)requestData
{
    WeakSelf(self)
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:orderdetailsbyorderno argument:@{@"orderNo":self.orderId}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            OrderDetailResponse *response = [OrderDetailResponse mj_objectWithKeyValues:result[@"data"]];
            self.isDeleted = [response.deleteFlag isEqualToString:@"DELETED"];
            response.name = [NSString stringWithFormat:@"%@第1车",[response.created substringToIndex:10]];
            weakself.source = @[response];
            [weakself.tableView reloadData];
        }
        
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
       
    }];
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [self headerView];
        _tableView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:WorkOrderDetailCell.class forCellReuseIdentifier:NSStringFromClass(WorkOrderDetailCell.class)];
    }
    return _tableView;
}

- (UIView *)headerView
{
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, kScreenWidth, 16);
    return view;
}

- (void)customerUI
{
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ([LoginInfoManage shareInstance].isBoss || self.isDeleted) ? 940 : 1060;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.source.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorkOrderDetailCell *cell = [WorkOrderDetailCell cellWithCollectionView:tableView];
    WeakSelf(self)
    [cell loadViewWithModel:self.source[indexPath.row] change:^(NSString *result) {
        if ([result isEqualToString:@"1"]) /// 修改
        {
            [weakself gotoWorkOrderDetail:weakself.projectId response:weakself.source[indexPath.row]];
        }
        else /// 打印
        {
            if ([PTDispatcher share].printerConnected == nil)
            {
                [SVProgressHUD showInfoWithStatus:@"打印机未连接，请先连接"];
                BluetoochMatchVC *bluetoochMatchVC = [BluetoochMatchVC new];
                [self.navigationController pushViewController:bluetoochMatchVC animated:YES];
            }
            else
            {
                [self printOrder:weakself.source[indexPath.row]];
            }
        }
    } isDelete:self.isDeleted];
    return cell;
}

- (void)printOrder:(OrderDetailResponse *)response
{
    NSString *classNoStr = [response.workType isEqualToString:@"NIGHT_WORK"] ? @"晚班" : @"白班";
    for (int i = 0; i < [LoginInfoManage shareInstance].workConfigResponse.pointCount; i++)
    {
        [Tools printWithProjectName:response.projectName
                         codeString:response.orderNo
                              carNo:response.plateNumber
                            company:response.companyName
                            orderNo:response.orderNo
                            soilWay:response.ztcName
                              ztWay:response.tlxName
                        carTeamName:response.fleetName
                          outPeople:response.outReleaser
                            classNo:[NSString stringWithFormat:@"%@(%@)",classNoStr,[response.created substringToIndex:10]]
                            outTime:response.outReleaserTime
                          printTime:[Tools getCurrentTime]
                              count:i+1
                              price:response.price
                        isShowPrice:self.workConfigModel.printWithPrice];
    }
    
    
}

- (void)gotoWorkOrderDetail:(NSString *)projectId response:(OrderDetailResponse *)response
{
    WorkOrderDetailChangeVC *detailChangeVC = [WorkOrderDetailChangeVC new];
    detailChangeVC.projectId = projectId;
    detailChangeVC.orderDetailResponse = response;
    WeakSelf(self)
    [detailChangeVC.subject subscribeNext:^(id  _Nullable x) {
        [weakself.subject sendNext:@"1"];
        [weakself loadData];
    }];
    [self.navigationController pushViewController:detailChangeVC animated:YES];
}

@end
