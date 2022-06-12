//
//  PersonalCenterVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/5/31.
//

#import "PersonalCenterVC.h"
#import "PersonalCenterCell.h"
#import "PersonalCenterHeaderView.h"
@interface PersonalCenterVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *source;
@end

@implementation PersonalCenterVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"个人中心";
    self.source = @[@[@"账号与安全"],
                    @[@"设备配置",@"清除缓存"],
                    @[@"版本更新",@"推荐给朋友",@"关于好运来"]];
    [self customerUI];
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
        _tableView.tableHeaderView = [self headView];
        _tableView.tableFooterView = [self footerView];
        _tableView.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:PersonalCenterCell.class forCellReuseIdentifier:NSStringFromClass(PersonalCenterCell.class)];
    }
    return _tableView;
}

- (UIView *)headView
{
    PersonalCenterHeaderView *view = [PersonalCenterHeaderView new];
    view.frame = CGRectMake(0, 0, kScreenWidth, 100);
    return view;
}

- (UIView *)footerView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    [view jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        NSLog(@"来了，老弟");
    }];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *logoutLb = [UILabel labelWithText:@"退出登录"
                                          font:[UIFont systemFontOfSize:16]
                                     textColor:[UIColor blueColor]
                                     alignment:NSTextAlignmentLeft];
    [view addSubview:logoutLb];
    [logoutLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
    }];
    return view;
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.source.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
