//
//  DeviceConfigVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/23.
//

#import "DeviceConfigVC.h"
#import "PersonalCenterCell.h"
#import "BluetoochMatchVC.h"
#import <PrinterSDK/PrinterSDK.h>
@interface DeviceConfigVC () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *source;
@end

@implementation DeviceConfigVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"设备配置";
    self.source = @[@"蓝牙打印配置"];
    [self customerUI];
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
        [_tableView registerClass:PersonalCenterCell.class forCellReuseIdentifier:NSStringFromClass(PersonalCenterCell.class)];
    }
    return _tableView;
}

- (UIView *)headView
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
    return 54;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.source.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BluetoochMatchVC *bluetoochMatchVC = [BluetoochMatchVC new];
    [self.navigationController pushViewController:bluetoochMatchVC animated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalCenterCell *cell = [PersonalCenterCell cellWithCollectionView:tableView];
    cell.titleLb.text = self.source[indexPath.row];
    return cell;
}

@end
