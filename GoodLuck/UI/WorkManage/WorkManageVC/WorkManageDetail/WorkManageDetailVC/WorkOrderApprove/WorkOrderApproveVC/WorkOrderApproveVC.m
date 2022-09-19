//
//  WorkOrderApproveVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/14.
//

#import "WorkOrderApproveVC.h"
#import "WorkOrderApproveCell.h"
#import "ApplyDeleteResponse.h"
#import "WorkOrderDetailVC.h"
@interface WorkOrderApproveVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) GLTableView *tableView;
@property (nonatomic, strong) NSArray<ApplyDeleteResponse *> *source;
@end

@implementation WorkOrderApproveVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"工单审批";
    [self customerUI];
    [self getData];
}

- (void)getData
{
    WeakSelf(self)
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:listapplydelete argument:@{@"projectId":self.projectId}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            weakself.source = [ApplyDeleteResponse mj_objectArrayWithKeyValuesArray:result[@"data"]];
            weakself.tableView.emptyLb.hidden = weakself.source.count > 0;
            [weakself.tableView reloadData];
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

- (GLTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[GLTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [self headerView];
        _tableView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:WorkOrderApproveCell.class forCellReuseIdentifier:NSStringFromClass(WorkOrderApproveCell.class)];
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

- (void)approveRequest:(NSString *)orderNo projectId:(NSString *)projectId status:(NSString *)status
{
    WeakSelf(self)
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:applydeletestatus argument:@{@"orderNo":orderNo,
                                                                                              @"projectId":projectId,
                                                                                              @"status":status
                                                                                            }];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            [weakself getData];
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 260;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.source.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorkOrderApproveCell *cell = [WorkOrderApproveCell cellWithCollectionView:tableView];
    [cell loadViewWithModel:self.source[indexPath.row]];
    WeakSelf(self)
    [cell.detailLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        WorkOrderDetailVC *workOrderDetailVC = [WorkOrderDetailVC new];
        workOrderDetailVC.orderId = weakself.source[indexPath.row].orderNo;
        workOrderDetailVC.projectId = weakself.projectId;
        [weakself.navigationController pushViewController:workOrderDetailVC animated:YES];
    }];
    [cell.subject subscribeNext:^(id  _Nullable x) {
        NSString *result = (NSString *)x;
        [weakself approveRequest:weakself.source[indexPath.row].orderNo projectId:weakself.source[indexPath.row].projectId status:[result isEqualToString:@"1"] ? @"DELETE":@"REJECT"];
    }];
    return cell;
}


@end
