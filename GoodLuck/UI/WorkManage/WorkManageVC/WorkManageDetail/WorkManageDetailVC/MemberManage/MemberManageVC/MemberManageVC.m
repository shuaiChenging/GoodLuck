//
//  MemberManageVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/6.
//

#import "MemberManageVC.h"
#import "MemberManageCell.h"
#import "MemberManageHeaderView.h"
#import "MemberManageFooterView.h"
#import "ChangeMemberVC.h"
#import "MemberManageResponse.h"
@interface MemberManageVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *sources;
@end

@implementation MemberManageVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"人员管理";
    [self dataInit];
    [self customerUI];
    [self getData];
}

- (void)dataInit
{
    ManageResponse *admi = [ManageResponse new];
    admi.header = [[MemberHeaderResponse alloc] initWithName:@"工地管理员" describe:@"负责登记泥头车进出工地"];
    admi.content = @[];
    
    ManageResponse *boss = [ManageResponse new];
    boss.header = [[MemberHeaderResponse alloc] initWithName:@"泥头车老板" describe:@"负责提供拉土车辆的老板"];
    boss.content = @[];
    
    self.sources = @[admi, boss];
}

- (void)getData
{
    WeakSelf(self)
    RACSignal *bossSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        GetRequest *request = [[GetRequest alloc] initWithRequestUrl:listboss argument:@{@"projectId":self.projectId}];
        [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
            if (success)
            {
                NSArray *array = [MemberManageResponse mj_objectArrayWithKeyValuesArray:result[@"data"]];
                ManageResponse *resonse = weakself.sources[1];
                resonse.content = array;
            }
            [subscriber sendNext:@"1"];
            [subscriber sendCompleted];
        } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
            [subscriber sendNext:@"1"];
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"结束了");
        }];
    }];
    
    RACSignal *adminSingal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        GetRequest *request = [[GetRequest alloc] initWithRequestUrl:listAdmin argument:@{@"projectId":self.projectId}];
        [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
            if (success)
            {
                NSArray *array = [MemberManageResponse mj_objectArrayWithKeyValuesArray:result[@"data"]];
                ManageResponse *resonse = weakself.sources[0];
                resonse.content = array;
            }
            [subscriber sendNext:@"1"];
            [subscriber sendCompleted];
        } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
            [subscriber sendNext:@"1"];
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"结束了");
        }];
    }];
    
    [[RACSignal combineLatest:@[bossSignal,adminSingal]] subscribeNext:^(RACTuple * _Nullable x) {
        [weakself.tableView reloadData];
    }];
}

- (void)customerUI
{
    [self.view addSubview:self.tableView];
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
        _tableView.tableHeaderView = [self hearderView];
        _tableView.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:MemberManageCell.class forCellReuseIdentifier:NSStringFromClass(MemberManageCell.class)];
    }
    return _tableView;
}

- (UIView *)hearderView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    view.frame = CGRectMake(0, 0, kScreenWidth, 20);
    return view;
}

- (void)addAdmin
{
    WeakSelf(self)
    PostRequest *request = [[PostRequest alloc] initWithRequestUrl:projectaddadmin argument:@{@"projectId":self.projectId,@"phone":@"徐志成"}];
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
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MemberManageHeaderView *hearderView = [MemberManageHeaderView new];
    ManageResponse *response = self.sources[section];
    [hearderView setName:response.header.name describe:response.header.describe];
    return hearderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    MemberManageFooterView *footerView = [MemberManageFooterView new];
    WeakSelf(self)
    [footerView.addView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        if (section == 0)
        {
            [weakself addAdmin];
        }
        else
        {
            
        }
    }];
    [footerView.inviteView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        if (section == 0)
        {
            
        }
        else
        {
            
        }
    }];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 70;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ManageResponse *response = self.sources[section];
    return response.content.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChangeMemberVC *changeMemberVC = [ChangeMemberVC new];
    [self.navigationController pushViewController:changeMemberVC animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MemberManageCell *cell = [MemberManageCell cellWithCollectionView:tableView];
    ManageResponse *response = self.sources[indexPath.section];
    MemberManageResponse *model = response.content[indexPath.row];
    [cell setImageName:@"" name:model.name];
    return cell;
}

@end
