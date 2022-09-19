//
//  PersonalCenterVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/5/31.
//

#import "PersonalCenterVC.h"
#import "PersonalCenterCell.h"
#import "PersonalCenterHeaderView.h"
#import "LoginInfoManage.h"
#import "DeviceConfigVC.h"
#import "AccountAndSafeVC.h"
#import "AboutVC.h"
#import <PrinterSDK/PrinterSDK.h>
@interface PersonalCenterVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *source;
@property (nonatomic, strong) PersonalCenterHeaderView *personalCenterHeaderView;
@end

@implementation PersonalCenterVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"个人中心";
    self.source = @[@[@"账号与安全"],
                    @[@"设备配置",@"清除缓存"],
                    @[@"关于好运来"]];
    [self customerUI];
}

- (void)customerUI
{
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.personalCenterHeaderView.nameLb.text = [LoginInfoManage shareInstance].personalResponse.name;
    self.personalCenterHeaderView.phoneLb.text = [LoginInfoManage shareInstance].personalResponse.phone;
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [self headView];
        _tableView.tableFooterView = [self footerView];
        _tableView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:PersonalCenterCell.class forCellReuseIdentifier:NSStringFromClass(PersonalCenterCell.class)];
    }
    return _tableView;
}

- (UIView *)headView
{
    self.personalCenterHeaderView = [PersonalCenterHeaderView new];
    self.personalCenterHeaderView.frame = CGRectMake(0, 0, kScreenWidth, 100);
    return self.personalCenterHeaderView;
}

- (UIView *)footerView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 54)];
    WeakSelf(self)
    [view jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself logOut];
    }];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *logoutLb = [UILabel labelWithText:@"退出登录"
                                          font:[UIFont systemFontOfSize:font_14]
                                     textColor:[UIColor jk_colorWithHexString:COLOR_BLUE]
                                     alignment:NSTextAlignmentLeft];
    [view addSubview:logoutLb];
    [logoutLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
    }];
    return view;
}

- (void)logOut
{
    [Tools showAlertWithTitle:@"温馨提示" content:@"退出登录" left:@"取消" right:@"确定" block:^{
        [LoginInfoManage shareInstance].token = @"";
        [Tools logout];
    }];
}

- (void)requestOut
{
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:logouturl argument:@{}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.source.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            AccountAndSafeVC *accountAndSafeVC = [AccountAndSafeVC new];
            accountAndSafeVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:accountAndSafeVC animated:YES];
            break;
        }
        case 1:
        {
            if (indexPath.row == 0)
            {
                DeviceConfigVC *deviceConfigVC = [DeviceConfigVC new];
                deviceConfigVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:deviceConfigVC animated:YES];
            }
            else
            {
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"清除成功"];
            }
            break;
        }
        case 2:
        {
            AboutVC *aboutVC = [AboutVC new];
            aboutVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:aboutVC animated:YES];
            break;
        }
        default:
            break;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.source[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalCenterCell *cell = [PersonalCenterCell cellWithCollectionView:tableView];
    cell.titleLb.text = self.source[indexPath.section][indexPath.row];
    return cell;
}

@end
