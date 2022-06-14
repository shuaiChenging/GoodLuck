//
//  WorkManageVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/5/31.
//

#import "WorkManageVC.h"
#import "WorkRoleSeletedVC.h"
#import "BaseNavigationVC.h"
#import "WorkListCell.h"
#import "WorkListHeaderView.h"
#import "WorkManageDetailVC.h"
#import "ApplyWorkPlaceVC.h"
#import "AddWorkPlaceVC.h"
#import "WorkManageLeftItemView.h"
#import "WorkListResponse.h"
#import "LoginInfoManage.h"
@interface WorkManageVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *source;
@property (nonatomic, strong) WorkListResponse *response;
@end

@implementation WorkManageVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"工地管理";
    [self customerUI];
    NSString *roleType = [DDDataStorageManage userDefaultsGetObjectWithKey:ROLETYPE];
    [self configLeftBarInfo];
    [self loadData];
    if ([Tools isEmpty:roleType])
    {
        [self showRoleVC:NO];
    }
    
}

- (void)configLeftBarInfo
{
    NSString *roleType = [DDDataStorageManage userDefaultsGetObjectWithKey:ROLETYPE];
    if (![Tools isEmpty:roleType])
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self customerLeftView]];
    }
}

- (WorkManageLeftItemView *)customerLeftView
{
    WorkManageLeftItemView *view = [WorkManageLeftItemView new];
    view.frame = CGRectMake(0, 0, 100, 44);
    view.backgroundColor = [UIColor redColor];
    NSString *roleType = [DDDataStorageManage userDefaultsGetObjectWithKey:ROLETYPE];
    if (![Tools isEmpty:roleType])
    {
        [view setImageName:@"" name:[roleType isEqualToString:@"1"] ? @"工地老板":@"工地管理员"];
    }
    WeakSelf(self)
    [view jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself showRoleVC:YES];
    }];
    return view;
}

- (void)loadData
{
    NSString *roleType = [DDDataStorageManage userDefaultsGetObjectWithKey:ROLETYPE];
    
    if (![Tools isEmpty:roleType])
    {
        WeakSelf(self)
        NSString *url = [roleType isEqualToString:@"1"] ? indexboss : indexadmin;
        [LoginInfoManage shareInstance].isBoss = [roleType isEqualToString:@"1"];
        GetRequest *request = [[GetRequest alloc] initWithRequestUrl:url argument:@{@"startTime":[Tools getCurrentTime],@"endTime":[Tools getCurrentTime]}];
        [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
            if (success)
            {
                WorkListResponse *response = [WorkListResponse mj_objectWithKeyValues:result[@"data"]];
                [weakself dataHandle:response];
            }
            [weakself.tableView.mj_header endRefreshing];
        } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
            [weakself.tableView.mj_header endRefreshing];
        }];
    }
}

- (void)dataHandle:(WorkListResponse *)response
{
    self.response = response;
    self.source = response.projectList;
    
    [self.tableView reloadData];
}

- (void)customerUI
{
    [self.view addSubview:self.tableView];
    WeakSelf(self)
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadData];
    }];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:WorkListCell.class forCellReuseIdentifier:NSStringFromClass(WorkListCell.class)];
    }
    return _tableView;
}

- (void)showRoleVC:(BOOL)animated
{
    WorkRoleSeletedVC *workRoleSeletedVC = [WorkRoleSeletedVC new];
    WeakSelf(self)
    [workRoleSeletedVC.subject subscribeNext:^(id  _Nullable x) {
        [weakself configLeftBarInfo];
        [weakself loadData];
    }];
    BaseNavigationVC *workRoleNavi = [[BaseNavigationVC alloc] initWithRootViewController:workRoleSeletedVC];
    workRoleNavi.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.navigationController presentViewController:workRoleNavi animated:animated completion:nil];
}

- (UIView *)headerView
{
    WeakSelf(self)
    WorkListHeaderView *workListHeaderView = [WorkListHeaderView new];
    [workListHeaderView loadViewWithModel:self.response];
    [workListHeaderView.workAddView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        if ([LoginInfoManage shareInstance].isBoss)
        {
            [weakself addworkPlace];
        }
        else
        {
            [weakself applyWorkPlace];
        }
    }];
    return workListHeaderView;
}

/// 增加工地
- (void)addworkPlace
{
    AddWorkPlaceVC *addWork = [AddWorkPlaceVC new];
    addWork.title = @"增加工地";
    [self.navigationController pushViewController:addWork animated:YES];
}

/// 申请新工地
- (void)applyWorkPlace
{
    ApplyWorkPlaceVC *applyWork = [ApplyWorkPlaceVC new];
    WeakSelf(self)
    [applyWork.subject subscribeNext:^(id  _Nullable x) {
        [weakself loadData];
    }];
    [self.navigationController pushViewController:applyWork animated:YES];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 196;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 224;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self headerView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.source.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorkListCell *cell = [WorkListCell cellWithCollectionView:tableView];
    [cell loadViewWithModel:self.source[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorkManageDetailVC *detailVC = [WorkManageDetailVC new];
    detailVC.response = self.source[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
