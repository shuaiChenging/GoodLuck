//
//  NoticeRoleView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/8/29.
//

#import "NoticeRoleView.h"
#import "RoleApproveCell.h"
#import "RoleApproveResponse.h"
#import "LoginInfoManage.h"
@interface NoticeRoleView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) GLTableView *tableView;
@property (nonatomic, strong) NSArray<RoleApproveResponse *> *source;
@end
@implementation NoticeRoleView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self customerUI];
        [self getData];
    }
    return self;
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
        [_tableView registerClass:RoleApproveCell.class forCellReuseIdentifier:NSStringFromClass(RoleApproveCell.class)];
    }
    return _tableView;
}

- (void)getData
{
    WeakSelf(self)
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:[LoginInfoManage shareInstance].isBoss ? listapply : listadminapply
                                                        argument:@{@"role":[LoginInfoManage shareInstance].isBoss ? @"BOSS" : @"ADMIN"}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            weakself.source = [RoleApproveResponse mj_objectArrayWithKeyValuesArray:result[@"data"]];
            weakself.tableView.emptyLb.hidden = weakself.source.count > 0;
            [weakself.tableView reloadData];
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

- (UIView *)headerView
{
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, kScreenWidth, 16);
    return view;
}

- (void)customerUI
{
    [self addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)approveRequest:(NSString *)itemId status:(NSString *)status
{
    WeakSelf(self)
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:applystatus argument:@{@"id":itemId,@"status":status}];
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
    return 250;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.source.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf(self)
    RoleApproveCell *cell = [RoleApproveCell cellWithCollectionView:tableView];
    [cell loadViewWithModel:self.source[indexPath.row]];
    [cell.subject subscribeNext:^(id  _Nullable x) {
        NSString *result = (NSString *)x;
        [weakself approveRequest:self.source[indexPath.row].itemId status:[result isEqualToString:@"1"] ? @"APPROVED":@"REJECT"];
    }];
    return cell;
}

@end
