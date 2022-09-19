//
//  AccountAndSafeVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/4.
//

#import "AccountAndSafeVC.h"
#import "AccountAndSafeCell.h"
#import "LoginInfoManage.h"
#import "ForgetPasswordVC.h"
#import "ChangePhoneVC.h"
#import "AccountAndSafeModel.h"
@interface AccountAndSafeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<AccountAndSafeModel *> *source;
@end

@implementation AccountAndSafeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"账号与安全";
    self.source = @[[[AccountAndSafeModel alloc] initWithName:@"用户名" content:[LoginInfoManage shareInstance].personalResponse.name],
                    [[AccountAndSafeModel alloc] initWithName:@"手机号" content:[LoginInfoManage shareInstance].personalResponse.phone],
                    [[AccountAndSafeModel alloc] initWithName:@"修改密码" content:@""],
                    [[AccountAndSafeModel alloc] initWithName:@"注销账号" content:@""]];
    [self customerUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.source[1].content = [LoginInfoManage shareInstance].personalResponse.phone;
    [self.tableView reloadData];
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [self headView];
        _tableView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:AccountAndSafeCell.class forCellReuseIdentifier:NSStringFromClass(AccountAndSafeCell.class)];
    }
    return _tableView;
}


- (void)customerUI
{
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (UIView *)headView
{
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, kScreenWidth, 16);
    return view;
}

- (void)changeUserName:(NSString *)name
{
    WeakSelf(self)
    PostRequest *request = [[PostRequest alloc] initWithRequestUrl:changename argument:@{@"name":name,@"tenantId":[LoginInfoManage shareInstance].personalResponse.tenantId}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            weakself.source[0].content = name;
            [LoginInfoManage shareInstance].personalResponse.name = name;
            
            PersonalCenterResponse *respose = [LoginInfoManage shareInstance].personalResponse;
            [DDDataStorageManage userDefaultsSaveObject:@{@"name":respose.name,
                                                          @"phone":respose.phone,
                                                          @"approveStatus":respose.approveStatus,
                                                          @"tenantId":respose.tenantId} forKey:INFOKEY];
            [weakself.tableView reloadData];
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

- (void)sendCodeRequest
{
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:smscode argument:@{@"phone":[LoginInfoManage shareInstance].personalResponse.phone,@"type":@"RESET_PHONE"}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.source.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf(self)
    if (indexPath.row == 0)
    {
        [Tools addViewWithTitle:@"修改用户名" placeholder:@"请输入用户名" textback:^(NSString *name) {
            [weakself changeUserName:name];
        }];
    }
    else if (indexPath.row == 1)
    {
        [Tools showAlertWithTitle:@"修改提示" content:@"是否修改当前手机号？" left:@"取消" right:@"确认" block:^{
            [weakself sendCodeRequest];
            ChangePhoneVC *changePhoneVC = [ChangePhoneVC new];
            [weakself.navigationController pushViewController:changePhoneVC animated:YES];
        }];
    }
    else if (indexPath.row == 2)
    {
        ForgetPasswordVC *forgetPasswordVC = [ForgetPasswordVC new];
        [weakself.navigationController pushViewController:forgetPasswordVC animated:YES];
    }
    else
    {
        [Tools showAlertWithTitle:@"注销账号" content:@"确认注销，好运来将删除该账号下所有信息，再次登录需要注册一个新的账号" left:@"取消" right:@"确认注销" block:^{
            [weakself requestDelete];
        }];
    }
}

- (void)requestDelete
{
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:deleteaccount argument:@{}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"注销成功"];
            [LoginInfoManage shareInstance].token = @"";
            [Tools logout];
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AccountAndSafeCell *cell = [AccountAndSafeCell cellWithCollectionView:tableView];
    [cell loadViewWithName:self.source[indexPath.row].name content:self.source[indexPath.row].content];
    return cell;
}


@end
