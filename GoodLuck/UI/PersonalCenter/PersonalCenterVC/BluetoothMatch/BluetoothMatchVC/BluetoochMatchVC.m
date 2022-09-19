//
//  BluetoochMatchVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/23.
//

#import "BluetoochMatchVC.h"
#import <PrinterSDK/PrinterSDK.h>
#import "BluetoothMatchCell.h"
#import "LoginInfoManage.h"
@interface BluetoochMatchVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UILabel *searchLb;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<PTPrinter *> *devices;
@end

@implementation BluetoochMatchVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"蓝牙配对";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(refresh)];
    [self customerUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self searchBluetooch];
}

- (void)refresh
{
    self.searchLb.text = @"正在搜索蓝牙设备...";
    [self searchBluetooch];
}

- (UILabel *)searchLb
{
    if (!_searchLb)
    {
        _searchLb = [UILabel labelWithText:@"正在搜索蓝牙设备..."
                                      font:[UIFont systemFontOfSize:font_14]
                                 textColor:[UIColor jk_colorWithHexString:COLOR_BLUE]
                                 alignment:NSTextAlignmentCenter];
    }
    return _searchLb;
}

- (NSArray *)devices
{
    if (!_devices)
    {
        _devices = [[NSArray alloc] init];
    }
    return _devices;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:BluetoothMatchCell.class forCellReuseIdentifier:NSStringFromClass(BluetoothMatchCell.class)];
    }
    return _tableView;
}

- (void)searchBluetooch
{
    [PTDispatcher share].unconnectBlock = nil;
    
    /// 判断手机蓝牙状态
    if ([[PTDispatcher share] getBluetoothStatus] == PTBluetoothStatePoweredOn)
    {
        
        [[PTDispatcher share] scanBluetooth];
        
        WeakSelf(self)
        [[PTDispatcher share] whenFindAllBluetooth:^(NSMutableArray<PTPrinter *> *printerArray) {
            weakself.searchLb.text = @"搜索完成";
            weakself.devices = [printerArray sortedArrayUsingComparator:^NSComparisonResult(PTPrinter*  _Nonnull obj1, PTPrinter*  _Nonnull obj2) {
                return obj1.distance.floatValue > obj2.distance.floatValue;
            }];
            [weakself.tableView reloadData];
        }];
        
    }
    else if ([[PTDispatcher share] getBluetoothStatus] == PTBluetoothStatePoweredOff)
    {
        [SVProgressHUD showInfoWithStatus:@"请打开蓝牙"];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:@"请前往系统设置中找到你的APP开启蓝牙权限"];
    }
}


- (void)customerUI
{
    UIView *headView = [UIView new];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(160);
    }];
    
    [headView addSubview:self.searchLb];
    [_searchLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView).offset(30);
        make.centerX.equalTo(headView);
    }];
    
    UILabel *describeLb = [UILabel labelWithText:@"配对码：0000 或者 1234"
                                            font:[UIFont systemFontOfSize:font_18]
                                       textColor:[UIColor whiteColor]
                                       alignment:NSTextAlignmentCenter];
    describeLb.layer.masksToBounds = YES;
    describeLb.layer.cornerRadius = 5;
    describeLb.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
    [headView addSubview:describeLb];
    [describeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headView).offset(60);
        make.right.equalTo(headView).offset(-60);
        make.top.equalTo(self.searchLb.mas_bottom).offset(20);
        make.height.equalTo(60);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.equalTo(headView.mas_bottom);
    }];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [SVProgressHUD showWithStatus:@"连接中，请稍等"];
    
    /// 异步回调
    WeakSelf(self)
    [[PTDispatcher share] whenConnectSuccess:^{
        [SVProgressHUD showSuccessWithStatus:@"连接成功"];
        [LoginInfoManage shareInstance].isConnect = YES;
        [weakself.navigationController popViewControllerAnimated:YES];
    }];
    
    /// 异步回调
    [[PTDispatcher share] whenConnectFailureWithErrorBlock:^(PTConnectError error) {
        NSString *errorString = @"";
        switch (error) {
        case PTConnectErrorBleSystem:
            errorString = @"系统错误";
            break;
        case PTConnectErrorBleTimeout:
            errorString = @"连接超时";
            break;
        case PTConnectErrorBleValidateFail:
            errorString = @"验证失败";
            break;
        case PTConnectErrorBleUnknownDevice:
            errorString = @"未知设备";
            break;
        case PTConnectErrorBleValidateTimeout:
            errorString = @"验证超时";
            break;
        case PTConnectErrorBleDisvocerServiceTimeout:
            errorString = @"连接失败";
            break;
        default:
            break;
        }
        [SVProgressHUD showErrorWithStatus:errorString];
    }];
    
    [[PTDispatcher share] connectPrinter:self.devices[indexPath.row]];
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60.0/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.devices.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BluetoothMatchCell *cell = [BluetoothMatchCell cellWithCollectionView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell loadViewWithName:self.devices[indexPath.row].name subName:self.devices[indexPath.row].mac];
    return cell;
}

@end
