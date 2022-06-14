//
//  WorkManageDetailVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/5.
//

#import "WorkManageDetailVC.h"
#import "WorkListCell.h"
#import "WorkManageDetailHeaderView.h"
#import "AddWorkPlaceVC.h"
#import "MemberManageVC.h"
#import "LoginInfoManage.h"
#import "WorkDetailResponse.h"
#import "WorkConfigVC.h"
#import "OnWorkLilstResponse.h"
#import "RoleApproveVC.h"
#import "WorkOrderApproveVC.h"
#import "WorkOrderResponse.h"
@interface WorkManageDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIBarButtonItem *configBt; /// 配置
@property (nonatomic, strong) UIBarButtonItem *offBt; /// 下班
@property (nonatomic, strong) WorkManageDetailHeaderView *hearderView;
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [self headerView];
        _tableView.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:WorkListCell.class forCellReuseIdentifier:NSStringFromClass(WorkListCell.class)];
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
    return _hearderView;
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
    return 196;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorkListCell *cell = [WorkListCell cellWithCollectionView:tableView];
    return cell;
}
@end
