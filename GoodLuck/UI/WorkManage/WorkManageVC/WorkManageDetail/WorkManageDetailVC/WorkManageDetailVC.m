//
//  WorkManageDetailVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/5.
//

#import "WorkManageDetailVC.h"
#import "WorkManageCarCell.h"
#import "WorkManageDetailHeaderView.h"
#import "AddWorkPlaceVC.h"
#import "MemberManageVC.h"
#import "LoginInfoManage.h"
#import "WorkDetailResponse.h"
#import "WorkConfigVC.h"
#import "OnWorkLilstResponse.h"
#import "RoleApproveVC.h"
#import "WorkOrderApproveVC.h"
#import "WorkManageCarHeaderView.h"
#import "WorkOrderResponse.h"
#import "WorkManageCardCell.h"
#import "WorkManageCardHeaderView.h"
#import "WorkManageSoilCell.h"
#import "EchartCell.h"
#import "WorkOrderDetailVC.h"
@interface WorkManageDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIBarButtonItem *configBt; /// 配置
@property (nonatomic, strong) UIBarButtonItem *offBt; /// 下班
@property (nonatomic, strong) WorkManageDetailHeaderView *hearderView;
@property (nonatomic, assign) WorkDataType dataType;
@end

@implementation WorkManageDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.response.name;
    if(![LoginInfoManage shareInstance].isBoss)
    {
        [self addCustomerItem];
    }
    [self customerUI];
    [self getData];
    [self getCarRequest];
//    [self getCardRequest];
//    [self getEarthRequest];
//    [self getFleetRequest];
}

- (UIView *)getCarHeaderView
{
    WorkManageCarHeaderView *view = [WorkManageCarHeaderView new];
    return view;
}

- (UIView *)getCardHeaderView
{
    WorkManageCardHeaderView *view = [WorkManageCardHeaderView new];
    return view;
}

- (void)getData
{
    WeakSelf(self)
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:projectdetails argument:@{@"id":self.response.projectId}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            WorkDetailResponse *response = [WorkDetailResponse mj_objectWithKeyValues:result[@"data"]];
            NSLog(@"%@",response);
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
    
    GetRequest *manageRequest = [[GetRequest alloc] initWithRequestUrl:onworklist argument:@{@"projectId":self.response.projectId}];
    [manageRequest startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            NSArray *array = [OnWorkLilstResponse mj_objectArrayWithKeyValuesArray:result[@"data"]];
            [weakself manageHandle:array];
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
    
    GetRequest *orderRequest = [[GetRequest alloc] initWithRequestUrl:orderstatistics argument:@{@"startTime":[Tools getCurrentTime],
                                                                                                 @"endTime":[Tools getCurrentTime],
                                                                                                 @"projectId":self.response.projectId,
                                                                                                 @"role":[LoginInfoManage shareInstance].isBoss ? @"BOSS":@"ADMIN"
                                                                                               }];
    [orderRequest startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            WorkOrderResponse *response = [WorkOrderResponse mj_objectWithKeyValues:result[@"data"]];
            [weakself orderHandle:response];
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

- (void)orderHandle:(WorkOrderResponse *)response
{
    [self.hearderView loadOrderWithModel:response];
}

- (void)manageHandle:(NSArray *)array
{
    NSString *name = @"";
    for (OnWorkLilstResponse *response in array)
    {
        name = [name stringByAppendingString:response.name];
        name = [name stringByAppendingString:@";"];
    }
    self.hearderView.currentPeople.text = [NSString stringWithFormat:@"当前上班管理员：%@",name];
    
}

- (UIBarButtonItem *)configBt
{
    if (!_configBt)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"配置" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(configClick) forControlEvents:UIControlEventTouchUpInside];
        _configBt = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
    return _configBt;
}

- (UIBarButtonItem *)offBt
{
    if (!_offBt)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"下班" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(offClick) forControlEvents:UIControlEventTouchUpInside];
        _offBt = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
    return _offBt;
}

- (void)offClick
{
    NSLog(@"下班");
}

- (void)configClick
{
    WorkConfigVC *workConfigVC = [WorkConfigVC new];
    workConfigVC.projectId = self.response.projectId;
    [self.navigationController pushViewController:workConfigVC animated:YES];
}

- (void)addCustomerItem
{
    UIBarButtonItem *fixedSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpaceBarButtonItem.width = 20;
    self.navigationItem.rightBarButtonItems = @[self.offBt,fixedSpaceBarButtonItem,self.configBt];
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [self headerView];
        _tableView.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:WorkManageCarCell.class forCellReuseIdentifier:NSStringFromClass(WorkManageCarCell.class)];
        [_tableView registerClass:WorkManageCardCell.class forCellReuseIdentifier:NSStringFromClass(WorkManageCardCell.class)];
        [_tableView registerClass:WorkManageSoilCell.class forCellReuseIdentifier:NSStringFromClass(WorkManageSoilCell.class)];
        [_tableView registerClass:EchartCell.class forCellReuseIdentifier:NSStringFromClass(EchartCell.class)];
    }
    return _tableView;
}

- (UIView *)headerView
{
    self.hearderView = [WorkManageDetailHeaderView new];
    _hearderView.frame = CGRectMake(0, 0, kScreenWidth, [LoginInfoManage shareInstance].isBoss ? 640 : 594);
    WeakSelf(self)
    [_hearderView.handleView.infoView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        AddWorkPlaceVC *addWorkPlace = [AddWorkPlaceVC new];
        addWorkPlace.title = @"工地信息详情";
        [addWorkPlace loadViewWithProjectId:weakself.response.projectId];
        [weakself.navigationController pushViewController:addWorkPlace animated:YES];
    }];
    [_hearderView.handleView.memberView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        MemberManageVC *memberManageVC = [MemberManageVC new];
        memberManageVC.projectId = weakself.response.projectId;
        [weakself.navigationController pushViewController:memberManageVC animated:YES];
    }];
    [_hearderView.handleView.roleView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        RoleApproveVC *roleApproveVC = [RoleApproveVC new];
        roleApproveVC.projectId = weakself.response.projectId;
        [weakself.navigationController pushViewController:roleApproveVC animated:YES];
    }];
    [_hearderView.handleView.workOrderView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        WorkOrderApproveVC *workOrderApproveVC = [WorkOrderApproveVC new];
        [weakself.navigationController pushViewController:workOrderApproveVC animated:YES];
    }];
    [_hearderView.subject subscribeNext:^(id  _Nullable x) {
        if (weakself.dataType == [x intValue])
        {
            return;
        }
        weakself.dataType = [x intValue];
        [weakself getCurrentData];
        
    }];
    return _hearderView;
}

- (void)getCurrentData
{
    switch (self.dataType)
    {
        case Car:
        {
            [self getCarRequest];
            break;
        }
        case Soil:
        {
            [self getEarthRequest];
            break;
        }
        case Card:
        {
            [self getCardRequest];
            break;
        }
        case ZTC:
        {
            break;
        }
        case Fall:
        {
            break;
        }
        case CarTeam:
        {
            [self getFleetRequest];
            break;
        }
        case Backhoe:
        {
            break;
        }
    }
    [self.tableView reloadData];
}

- (void)customerUI
{
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

/// 车辆请求
- (void)getCarRequest
{
    GetRequest *orderRequest = [[GetRequest alloc] initWithRequestUrl:carstatistics
                                                             argument:@{@"startTime":[Tools getCurrentTime],
                                                                        @"endTime":[Tools getCurrentTime],
                                                                        @"projectId":self.response.projectId,
                                                                        @"role":[LoginInfoManage shareInstance].isBoss ? @"BOSS":@"ADMIN"
                                                                        }];
    [orderRequest startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

/// 卡牌请求
- (void)getCardRequest
{
    GetRequest *orderRequest = [[GetRequest alloc] initWithRequestUrl:cardstatistics
                                                             argument:@{@"startTime":[Tools getCurrentTime],
                                                                        @"endTime":[Tools getCurrentTime],
                                                                        @"projectId":self.response.projectId,
                                                                        @"role":[LoginInfoManage shareInstance].isBoss ? @"BOSS":@"ADMIN"
                                                                        }];
    [orderRequest startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}
/// 土类型请求
- (void)getEarthRequest
{
    GetRequest *orderRequest = [[GetRequest alloc] initWithRequestUrl:earthstatistics
                                                             argument:@{@"startTime":[Tools getCurrentTime],
                                                                        @"endTime":[Tools getCurrentTime],
                                                                        @"projectId":self.response.projectId,
                                                                        @"role":[LoginInfoManage shareInstance].isBoss ? @"BOSS":@"ADMIN"
                                                                        }];
    [orderRequest startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

/// 获取车队请求
- (void)getFleetRequest
{
    GetRequest *orderRequest = [[GetRequest alloc] initWithRequestUrl:fleetstatistics
                                                             argument:@{@"startTime":[Tools getCurrentTime],
                                                                        @"endTime":[Tools getCurrentTime],
                                                                        @"projectId":self.response.projectId,
                                                                        @"role":[LoginInfoManage shareInstance].isBoss ? @"BOSS":@"ADMIN"
                                                                        }];
    [orderRequest startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    switch (self.dataType)
    {
        case Car:
        {
            view = [self getCarHeaderView];
            break;
        }
        case CarTeam:
        case Soil:
        {
            break;
        }
        case Card:
        {
            view = [self getCardHeaderView];
            break;
        }
        case ZTC:
        {
            break;
        }
        case Fall:
        {
            break;
        }
        case Backhoe:
        {
            break;
        }
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height;
    switch (self.dataType)
    {
        case Car:
        {
            height = 80;
            break;
        }
        case CarTeam:
        case Soil:
        {
            height = 0;
            break;
        }
        case Card:
        {
            height = 120;
            break;
        }
        case ZTC:
        {
            height = 0;
            break;
        }
        case Fall:
        {
            height = 0;
            break;
        }
        case Backhoe:
        {
            height = 0;
            break;
        }
    }
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat height;
    switch (self.dataType)
    {
        case Car:
        {
            height = 16;
            break;
        }
        case CarTeam:
        case Soil:
        {
            height = 0;
            break;
        }
        case Card:
        {
            height = 16;
            break;
        }
        case ZTC:
        {
            height = 0;
            break;
        }
        case Fall:
        {
            height = 0;
            break;
        }
        case Backhoe:
        {
            height = 0;
            break;
        }
    }
    return height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    CGFloat number;
    switch (self.dataType)
    {
        case Car:
        {
            number = 1;
            break;
        }
        case Soil:
        {
            number = 1;
            break;
        }
        case Card:
        {
            number = 1;
            break;
        }
        case ZTC:
        {
            number = 1;
            break;
        }
        case Fall:
        {
            number = 1;
            break;
        }
        case CarTeam:
        {
            number = 1;
            break;
        }
        case Backhoe:
        {
            number = 1;
            break;
        }
    }
    return number;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    switch (self.dataType)
    {
        case Car:
        {
            height = 100;
            break;
        }
        case Soil:
        {
            height = 56;
            break;
        }
        case Card:
        {
            height = 40;
            break;
        }
        case ZTC:
        {
            height = 200;
            break;
        }
        case Fall:
        {
            height = 200;
            break;
        }
        case CarTeam:
        {
            height = 56;
            break;
        }
        case Backhoe:
        {
            height = 56;
            break;
        }
    }
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    switch (self.dataType)
    {
        case Car:
        {
            cell = [WorkManageCarCell cellWithCollectionView:tableView];
            break;
        }
        case Soil:
        {
            cell = [WorkManageSoilCell cellWithCollectionView:tableView];
            break;
        }
        case Card:
        {
            cell = [WorkManageCardCell cellWithCollectionView:tableView];
            break;
        }
        case ZTC:
        {
            cell = [EchartCell cellWithCollectionView:tableView];
            break;
        }
        case Fall:
        {
            cell = [EchartCell cellWithCollectionView:tableView];
            break;
        }
        case CarTeam:
        {
            cell = [WorkManageSoilCell cellWithCollectionView:tableView];
            break;
        }
        case Backhoe:
        {
            cell = [WorkManageSoilCell cellWithCollectionView:tableView];
            break;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorkOrderDetailVC *workOrderDetailVC = [WorkOrderDetailVC new];
    [self.navigationController pushViewController:workOrderDetailVC animated:YES];
}
@end
