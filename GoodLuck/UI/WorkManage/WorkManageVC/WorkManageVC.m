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
#import "WorkManageDetailNewVC.h"
#import "ApplyWorkPlaceVC.h"
#import "AddWorkPlaceVC.h"
#import "WorkManageLeftItemView.h"
#import "WorkListResponse.h"
#import "LoginInfoManage.h"
#import "WorkDataDetailVC.h"
#import <PrinterSDK/PrinterSDK.h>
#import "LoginInfoManage.h"
#import "MyNoticeVC.h"
#import "WorkNumberResponse.h"
@interface WorkManageVC ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>
@property (nonatomic, strong) GLTableView *tableView;
@property (nonatomic, strong) NSArray *source;
@property (nonatomic, strong) WorkListResponse *response;
@property (nonatomic, assign) BOOL hasWork;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, copy) NSString *bossStartTime;
@property (nonatomic, copy) NSString *bossEndTime;
@property (nonatomic, copy) NSString *dateSeleted;
@property (nonatomic, copy) NSString *dateSeletedBoss;
@property (nonatomic, strong) NSCalendar *gregorian;
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) ProjectListResponse *seletedResponse;

@property (nonatomic, strong) UILabel *badgeLb;
@end

@implementation WorkManageVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"工地管理";
    self.hasWork = NO;
    self.dateSeleted = @"今天";
    self.dateSeletedBoss = @"今天";
    [self monitorBluetooth];
    [[PTDispatcher share] getBluetoothStatus]; /// 首页触发一下蓝牙
    [self customerUI];
    NSString *roleType = [DDDataStorageManage userDefaultsGetObjectWithKey:ROLETYPE];
    self.startTime = [NSString stringWithFormat:@"%@ 00:00:00",[Tools dateToString:[NSDate date] withDateFormat:@"yyyy-MM-dd"]];
    self.endTime = [NSString stringWithFormat:@"%@ 23:59:59",[Tools dateToString:[NSDate date] withDateFormat:@"yyyy-MM-dd"]];
    self.bossStartTime = [NSString stringWithFormat:@"%@ 00:00:00",[Tools dateToString:[NSDate date] withDateFormat:@"yyyy-MM-dd"]];
    self.bossEndTime = [NSString stringWithFormat:@"%@ 23:59:59",[Tools dateToString:[NSDate date] withDateFormat:@"yyyy-MM-dd"]];
    [self configLeftBarInfo];
    [self configRightBar];
    [self loadData];
    if ([Tools isEmpty:roleType])
    {
        [self showRoleVC:NO];
    }
}

- (UILabel *)badgeLb
{
    if (!_badgeLb)
    {
        _badgeLb = [UILabel labelWithText:@"10"
                                     font:[UIFont systemFontOfSize:font_10]
                                textColor:[UIColor whiteColor]
                                alignment:NSTextAlignmentCenter];
        _badgeLb.backgroundColor = [UIColor redColor];
        _badgeLb.layer.masksToBounds = YES;
        _badgeLb.layer.cornerRadius = 8;
        _badgeLb.hidden = YES;
    }
    return _badgeLb;
}

- (CLLocationManager *)locationManager
{
    if (!_locationManager)
    {
        _locationManager = [CLLocationManager new];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 10.0;
        _locationManager.delegate = self;
        if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
        {
            [_locationManager requestWhenInUseAuthorization];
        }
    }
    return _locationManager;
}

- (NSCalendar *)gregorian
{
    if (!_gregorian)
    {
        _gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }
    return _gregorian;
}

- (void)monitorBluetooth
{
    [[PTDispatcher share] whenUnconnect:^(BOOL isActive) {
        [LoginInfoManage shareInstance].isConnect = NO;
    }];
    
    [[PTDispatcher share] whenConnectSuccess:^{
        [LoginInfoManage shareInstance].isConnect = YES;
    }];
}

- (void)configLeftBarInfo
{
    NSString *roleType = [DDDataStorageManage userDefaultsGetObjectWithKey:ROLETYPE];
    if (![Tools isEmpty:roleType])
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self customerLeftView]];
    }
}

- (void)configRightBar
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self cutomerRightView]];
}

- (UIView *)cutomerRightView
{
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 36, 44)];
    rightView.userInteractionEnabled = YES;
    rightView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *notiImg = [UIImageView jk_imageViewWithImageNamed:@"home_notice"];
    notiImg.frame = CGRectMake(0, 13, 18, 18);
    [rightView addSubview:notiImg];
    
    [rightView addSubview:self.badgeLb];
    _badgeLb.frame = CGRectMake(16, 4, 16, 16);
    WeakSelf(self)
    [rightView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself gotoMyNoticeVC];
    }];
    
    return rightView;
}

- (WorkManageLeftItemView *)customerLeftView
{
    WorkManageLeftItemView *view = [WorkManageLeftItemView new];
    view.frame = CGRectMake(0, 0, 130, 44);
    NSString *roleType = [DDDataStorageManage userDefaultsGetObjectWithKey:ROLETYPE];
    if (![Tools isEmpty:roleType])
    {
        [view setImageName:[roleType isEqualToString:@"1"] ? @"home_seleted_boss" : @"home_seleted_admin"
                      name:[roleType isEqualToString:@"1"] ? @"工地老板":@"工地管理员"];
    }
    WeakSelf(self)
    [view jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself showRoleVC:YES];
    }];
    return view;
}

- (void)gotoMyNoticeVC
{
    MyNoticeVC *myNoticeVC = [MyNoticeVC new];
    myNoticeVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myNoticeVC animated:YES];
}

- (void)loadData
{
    NSString *roleType = [DDDataStorageManage userDefaultsGetObjectWithKey:ROLETYPE];
    
    if (![Tools isEmpty:roleType])
    {
        WeakSelf(self)
        NSString *url = [roleType isEqualToString:@"1"] ? indexboss : indexadmin;
        [LoginInfoManage shareInstance].isBoss = [roleType isEqualToString:@"1"];
        GetRequest *request = [[GetRequest alloc] initWithRequestUrl:url argument:@{@"startTime":[LoginInfoManage shareInstance].isBoss ? self.bossStartTime : self.startTime,
                                                                                    @"endTime":[LoginInfoManage shareInstance].isBoss ? self.bossEndTime : self.endTime}];
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
    if (![LoginInfoManage shareInstance].isBoss)
    {
        [self loadHasWork];
    }
    self.tableView.emptyLb.hidden = self.source.count > 0;
    [self.tableView reloadData];
}

- (void)loadHasWork
{
    WeakSelf(self)
    self.hasWork = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (ProjectListResponse *response in weakself.source)
        {
            if (![response.workType isEqualToString:@"OFF_WORK"])
            {
                weakself.hasWork = YES;
                break;
            }
        }
    });
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getNoticeNumber];
    [LoginInfoManage shareInstance].errorWorkOrder = NO;
}

- (void)getNoticeNumber
{
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:applycount argument:@{}];
    WeakSelf(self)
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            WorkNumberResponse *response = [WorkNumberResponse mj_objectWithKeyValues:result[@"data"]];
            weakself.badgeLb.text = [NSString stringWithFormat:@"%ld",response.orderApplyCount + response.roleApplyCount];
            weakself.badgeLb.hidden = (response.orderApplyCount + response.roleApplyCount == 0) || ![LoginInfoManage shareInstance].isBoss;
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
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

- (GLTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[GLTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
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
    workListHeaderView.dateStr = [LoginInfoManage shareInstance].isBoss ? self.dateSeletedBoss : self.dateSeleted;
    [workListHeaderView loadViewWithModel:self.response];
    [workListHeaderView.detailLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        if (weakself.source.count == 0)
        {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"暂无工地"];
            return;
        }
        WorkDataDetailVC *workDataDetailVC = [WorkDataDetailVC new];
        workDataDetailVC.hidesBottomBarWhenPushed = YES;
        [weakself.navigationController pushViewController:workDataDetailVC animated:YES];
    }];
    [workListHeaderView.subject subscribeNext:^(id  _Nullable x) {
        if ([LoginInfoManage shareInstance].isBoss)
        {
            weakself.dateSeletedBoss = x;
            [weakself bossHandle:x];
        }
        else
        {
            weakself.dateSeleted = x;
            [weakself adminHandle:x];
        }
    }];
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

- (void)adminHandle:(NSString *)day
{
    if ([day isEqualToString:@"今天"])
    {
        self.startTime = [NSString stringWithFormat:@"%@ 00:00:00",[Tools dateToString:[NSDate date] withDateFormat:@"yyyy-MM-dd"]];
        self.endTime = [NSString stringWithFormat:@"%@ 23:59:59",[Tools dateToString:[NSDate date] withDateFormat:@"yyyy-MM-dd"]];
        
    }
    else if ([day isEqualToString:@"昨天"])
    {
        NSDate *yesterDay = [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:-1 toDate:[NSDate date] options:0];
        self.startTime = [NSString stringWithFormat:@"%@ 00:00:00",[Tools dateToString:yesterDay withDateFormat:@"yyyy-MM-dd"]];
        self.endTime = [NSString stringWithFormat:@"%@ 23:59:59",[Tools dateToString:yesterDay withDateFormat:@"yyyy-MM-dd"]];
    }
    else
    {
        NSDate *sevenDay = [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:-7 toDate:[NSDate date] options:0];
        self.startTime = [NSString stringWithFormat:@"%@ 00:00:00",[Tools dateToString:sevenDay withDateFormat:@"yyyy-MM-dd"]];
        self.endTime = [NSString stringWithFormat:@"%@ 23:59:59",[Tools dateToString:[NSDate date] withDateFormat:@"yyyy-MM-dd"]];
    }
    [self loadData];
}

- (void)bossHandle:(NSString *)day
{
    if ([day isEqualToString:@"今天"])
    {
        self.bossStartTime = [NSString stringWithFormat:@"%@ 00:00:00",[Tools dateToString:[NSDate date] withDateFormat:@"yyyy-MM-dd"]];
        self.bossEndTime = [NSString stringWithFormat:@"%@ 23:59:59",[Tools dateToString:[NSDate date] withDateFormat:@"yyyy-MM-dd"]];
    }
    else if ([day isEqualToString:@"昨天"])
    {
        NSDate *yesterDay = [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:-1 toDate:[NSDate date] options:0];
        self.bossStartTime = [NSString stringWithFormat:@"%@ 00:00:00",[Tools dateToString:yesterDay withDateFormat:@"yyyy-MM-dd"]];
        self.bossEndTime = [NSString stringWithFormat:@"%@ 23:59:59",[Tools dateToString:yesterDay withDateFormat:@"yyyy-MM-dd"]];
    }
    else
    {
        NSDate *sevenDay = [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:-7 toDate:[NSDate date] options:0];
        self.bossStartTime = [NSString stringWithFormat:@"%@ 00:00:00",[Tools dateToString:sevenDay withDateFormat:@"yyyy-MM-dd"]];
        self.bossEndTime = [NSString stringWithFormat:@"%@ 23:59:59",[Tools dateToString:[NSDate date] withDateFormat:@"yyyy-MM-dd"]];
    }
    [self loadData];
}

/// 增加工地
- (void)addworkPlace
{
    if (![[LoginInfoManage shareInstance].personalResponse.approveStatus isEqualToString:@"APPROVED"])
    {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请联系后台管理人员！400-9950-887"];
        return;
    }
    AddWorkPlaceVC *addWork = [AddWorkPlaceVC new];
    WeakSelf(self)
    [addWork.subject subscribeNext:^(id  _Nullable x) {
        [weakself loadData];
    }];
    addWork.title = @"增加工地";
    addWork.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addWork animated:YES];
}



/// 获取配置
/// @param distance 距离
- (void)getConfigDetailswithDistance:(double)distance
{
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:configdetails argument:@{@"projectId":self.seletedResponse.projectId}];
    WeakSelf(self)
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            NSString *resultContent = result[@"data"][@"content"];
            WorkConfigResponse *response = [WorkConfigResponse mj_objectWithKeyValues:resultContent];
            if (response.inTwoOnWork)
            {
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"进错工地，无法上班！"];
            }
            else
            {
                [weakself gotoErrorWorkPlace:distance];
            }
            
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}


/// 申请新工地
- (void)applyWorkPlace
{
    ApplyWorkPlaceVC *applyWork = [ApplyWorkPlaceVC new];
    WeakSelf(self)
    [applyWork.subject subscribeNext:^(id  _Nullable x) {
        [weakself loadData];
    }];
    applyWork.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:applyWork animated:YES];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 214;
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
    ProjectListResponse *model = self.source[indexPath.row];
    self.seletedResponse = model;
    if ([LoginInfoManage shareInstance].isBoss)
    {
        [self gotoWorkManageDetail:model];
    }
    else
    {
        if (self.hasWork)
        {
            if ([model.workType isEqualToString:@"OFF_WORK"])
            {
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"您在其他工地上班，请先下班"];
                return;
            }
            [self gotoWorkManageDetail:model];
        }
        else
        {
            self.currentLocation = [[CLLocation alloc] initWithLatitude:[model.latitude doubleValue] longitude:[model.longitude doubleValue]];
            [self.locationManager startUpdatingLocation];
            
        }
    }
}

- (void)seleteWorkType:(ProjectListResponse *)response
{
    WeakSelf(self)
    [Tools showSeletedWokrType:^(NSString * _Nonnull type) {
        response.workType = type;
        [weakself requestWorkOn:response];
    }];
}

- (void)requestWorkOn:(ProjectListResponse *)response
{
    WeakSelf(self)
    PostRequest *request = [[PostRequest alloc] initWithRequestUrl:workon argument:@{@"projectId":response.projectId,@"type":response.workType}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            [weakself loadData];
            [weakself gotoWorkManageDetail:response];
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}


- (void)gotoWorkManageDetail:(ProjectListResponse *)response
{
    WorkManageDetailNewVC *detailVC = [WorkManageDetailNewVC new];
    WeakSelf(self)
    [detailVC.subject subscribeNext:^(id  _Nullable x) {
        [weakself loadData];
    }];
    detailVC.response = response;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [self.locationManager stopUpdatingLocation];
    CLLocation *location = locations.lastObject;
    double distance = [location distanceFromLocation:self.currentLocation];
    if (distance > 2000)
    {
        [self getConfigDetailswithDistance:distance];
    }
    else
    {
        [self seleteWorkType:self.seletedResponse];
    }
}

- (void)gotoErrorWorkPlace:(double)distance
{
    WeakSelf(self)
    [Tools showErrorWorkPlace:self.seletedResponse.name distance:[NSString stringWithFormat:@"%.2f公里",distance/1000] block:^(NSString * str) {
        if ([str isEqualToString:@"1"])
        {
            [weakself seleteWorkType:self.seletedResponse];
            [LoginInfoManage shareInstance].errorWorkOrder = YES;
        }
    }];
}

- (void)locationManager:(CLLocationManager*)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if(status ==kCLAuthorizationStatusNotDetermined)
    {
        NSLog(@"等待用户授权");
    }
    else if(status ==kCLAuthorizationStatusAuthorizedAlways|| status ==kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        [self.locationManager startUpdatingLocation];
    }
    else
    {
        NSLog(@"授权失败");
    }
}

@end
