//
//  WorkManageDetailNewVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/9/5.
//

#import "WorkManageDetailNewVC.h"
#import "WorkMainScrollView.h"
#import "WorkContentScrollView.h"
#import "UIDevice+StateHeight.h"
#import "WorkManageDetailHeaderView.h"
#import "LoginInfoManage.h"
#import "AddWorkPlaceVC.h"
#import "DateSeletedVC.h"
#import "MemberManageVC.h"
#import "RoleApproveVC.h"
#import "WorkOrderApproveVC.h"
#import "CameraViewController.h"
#import "BluetoochMatchVC.h"

#import "WorkManageCarCell.h"
#import "WorkDetailResponse.h"
#import "WorkConfigVC.h"
#import "OnWorkLilstResponse.h"
#import "WorkOrderResponse.h"
#import "WorkManageCardCell.h"
#import "WorkManageCardHeaderView.h"
#import "WorkManageSoilCell.h"
#import "EchartCell.h"
#import "WorkOrderDetailVC.h"
#import "CreateWorkOrderVC.h"
#import "DischargedModelVC.h"
#import "CarstatisticsResponse.h"
#import "WorkManageCarTeamCell.h"
#import "WorkDetailSoilResponse.h"
#import "WorkDetailCardResponse.h"
#import "WorkDetailCardTeamResponse.h"
#import "WorkManageReleaseCell.h"
#import "WorkDetailReleaseResponse.h"
#import "WorkDetailZTResponse.h"
#import "WorkManageEmptyCell.h"
#import "WorkConfigResponse.h"
#import "WorkManageCarTeamHeaderView.h"
#import "UIViewController+CYLTabBarControllerExtention.h"
#import "DatePointManage.h"
#import "WorkManageDetailFooterView.h"
#import "WorkManageZDHeaderView.h"
#import "WorkManageCarHeaderView.h"
#import "WorkManageSoilHeaderView.h"

@interface WorkManageDetailNewVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) WorkMainScrollView *mainScroollView;
@property (nonatomic, assign) BOOL canMove;
@property (nonatomic, assign) BOOL contentCanMove;
@property (nonatomic, strong) WorkManageDetailHeaderView *hearderView;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, assign) WorkDataType dataType;
@property (nonatomic, assign) WorkDataType seletedType;
@property (nonatomic, assign) int scrollIndex;

@property (nonatomic, assign) CGFloat floatHeight;
@property (nonatomic, assign) CGFloat topViewHeight;

@property (nonatomic, copy) NSString *carRequestDate;
@property (nonatomic, copy) NSString *cardRequestDate;

@property (nonatomic, strong) NSMutableArray<CarstatisticsResponse *> *carSource;
@property (nonatomic, strong) NSArray<WorkDetailSoilResponse *> *soilSource;
@property (nonatomic, strong) NSMutableArray<WorkDetailCardResponse *> *cardSource;
@property (nonatomic, strong) NSArray<WorkDetailCardTeamListResponse *> *carTeamSource;
@property (nonatomic, strong) NSArray<WorkDetailReleaseResponse *> *releaseSource;

@property (nonatomic, strong) WorkDetailZTResponse *detailZTResponse;
@property (nonatomic, strong) WorkDetailZTResponse *detailZDResponse;

//@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIBarButtonItem *configBt; /// 配置
@property (nonatomic, strong) UIBarButtonItem *offBt; /// 下班

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray<OnWorkLilstResponse *> *manageArr;
@property (nonatomic, strong) WorkDetailCardTeamResponse *carTeamResponse;

@property (nonatomic, strong) WorkContentScrollView *contentScrollView;
@end

@implementation WorkManageDetailNewVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.response.name;
    self.scrollIndex = 0;
    self.carRequestDate = [Tools getCurrentDate];
    self.cardRequestDate = [Tools getCurrentDate];
    self.carSource = [NSMutableArray arrayWithCapacity:0];
    self.cardSource = [NSMutableArray arrayWithCapacity:0];
    [[DatePointManage shareInstance] getPointDate:self.response.projectId];
    self.topViewHeight = [LoginInfoManage shareInstance].isBoss ? 553 : 571;
    self.floatHeight = 46;
    
    self.canMove = YES;
    self.contentCanMove = NO;
    self.startTime = [NSString stringWithFormat:@"%@ 00:00:00",[Tools dateToString:[NSDate date] withDateFormat:@"yyyy-MM-dd"]];
    self.endTime = [NSString stringWithFormat:@"%@ 23:59:59",[Tools dateToString:[NSDate date] withDateFormat:@"yyyy-MM-dd"]];
    if(![LoginInfoManage shareInstance].isBoss)
    {
        [self addCustomerItem];
        [self getConfigDetails];
    }
    [self customerUI];
    [self getData];
    [self getCarRequest];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.hearderView.admiView.printerStateLb.text = [LoginInfoManage shareInstance].isConnect ? @"已连接" : @"未连接";
    self.hearderView.admiView.printerStateLb.textColor = [LoginInfoManage shareInstance].isConnect ? [UIColor jk_colorWithHexString:COLOR_BLUE] : [UIColor redColor];
}

/// 获取配置
- (void)getConfigDetails
{
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:configdetails argument:@{@"projectId":self.response.projectId}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            NSString *resultContent = result[@"data"][@"content"];
            WorkConfigResponse *response = [WorkConfigResponse mj_objectWithKeyValues:resultContent];
            [LoginInfoManage shareInstance].workConfigResponse = response;
            
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

- (RACSubject *)subject
{
    if (!_subject)
    {
        _subject = [RACSubject new];
    }
    return _subject;
}

- (UIView *)getCarHeaderView:(CarstatisticsResponse *)response section:(NSInteger)section tableView:(UITableView *)tableView
{
    WorkManageCarHeaderView *view = [WorkManageCarHeaderView cellWithTableViewHeaderFooterView:tableView];
    [view loadViewWithModel:response];
    WeakSelf(self)
    [view jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        response.isSeleted = !response.isSeleted;
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:section];
        [UIView setAnimationsEnabled:NO];
        [weakself.contentScrollView.carTab reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        [UIView setAnimationsEnabled:YES];
    }];
    return view;
}

- (UIView *)getzdHeaderView:(UITableView *)tableView name:(NSString *)name number:(NSString *)number
{
    WorkManageZDHeaderView *workManageZDHeaderView = [WorkManageZDHeaderView cellWithTableViewHeaderFooterView:tableView];
    [workManageZDHeaderView loadViewWithName:name number:number];
    return workManageZDHeaderView;
}

- (UIView *)getSoilHeaderView:(WorkDetailSoilResponse *)response tableView:(UITableView *)tableView
{
    WorkManageSoilHeaderView *view = [WorkManageSoilHeaderView cellWithTableViewHeaderFooterView:tableView];
    [view loadViewWithModel:response];
    return view;
}

- (UIView *)getCardHeaderView:(WorkDetailCardResponse *)response tableView:(UITableView *)tableView
{
    WorkManageCardHeaderView *view = [WorkManageCardHeaderView cellWithTableViewHeaderFooterView:tableView];
    [view loadViewWithModel:response];
    return view;
}

- (UIView *)getCarTeamHeaderView:(WorkDetailCardTeamListResponse *)response indexRow:(NSInteger)row tableView:(UITableView *)tableView
{
    WorkManageCarTeamHeaderView *view = [WorkManageCarTeamHeaderView cellWithTableViewHeaderFooterView:tableView];
    [view loadViewWithModel:response indexRow:row response:self.carTeamResponse];
    return view;
}

- (void)getData
{
    WeakSelf(self)
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:projectdetails argument:@{@"id":self.response.projectId}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            WorkDetailResponse *response = [WorkDetailResponse mj_objectWithKeyValues:result[@"data"]];
            [weakself loadMap:response];
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
    
    GetRequest *manageRequest = [[GetRequest alloc] initWithRequestUrl:onworklist argument:@{@"projectId":self.response.projectId}];
    [manageRequest startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            weakself.manageArr = [OnWorkLilstResponse mj_objectArrayWithKeyValuesArray:result[@"data"]];
            [weakself manageHandle:weakself.manageArr];
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
    
    [self getOrderData];
}

- (void)getOrderData
{
    WeakSelf(self)
    GetRequest *orderRequest = [[GetRequest alloc] initWithRequestUrl:orderstatistics argument:@{@"startTime":self.startTime,
                                                                                                 @"endTime":self.endTime,
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

- (void)loadMap:(WorkDetailResponse *)response
{
    [self.hearderView loadMapInfo:response];
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
    self.name = name;
    self.hearderView.currentPeople.text = [NSString stringWithFormat:@"当前上班管理员：%@",name];
    
}

- (UIBarButtonItem *)configBt
{
    if (!_configBt)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"配置" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:[UIColor jk_colorWithHexString:COLOR_BLUE] forState:UIControlStateNormal];
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
        [btn setTitleColor:[UIColor jk_colorWithHexString:COLOR_BLUE] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(offClick) forControlEvents:UIControlEventTouchUpInside];
        _offBt = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
    return _offBt;
}

- (void)offClick
{
    WeakSelf(self)
    [Tools showAlertWithTitle:@"下班提示" content:@"您确定下班吗？" left:@"取消" right:@"确认" block:^{
        [weakself requestOff];
    }];
}

- (void)requestOff
{
    WeakSelf(self)
    GetRequest *offRequest = [[GetRequest alloc] initWithRequestUrl:workoff
                                                           argument:@{@"projectId":self.response.projectId}];
    [offRequest startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            [weakself.subject sendNext:@"1"];
            [weakself.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
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

- (UIView *)customerHearderView
{
    self.hearderView = [WorkManageDetailHeaderView new];
    self.hearderView.projectId = self.response.projectId;
    _hearderView.frame = CGRectMake(0, 0, kScreenWidth, self.topViewHeight);
    WeakSelf(self)
    if (![LoginInfoManage shareInstance].isBoss)
    {
        [_hearderView.admiView changeState:[self.response.workType isEqualToString:@"DAY_WORK"]];
    }
    [_hearderView.workOrderView.timeShowView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        DateSeletedVC *dateSeletedVC = [DateSeletedVC new];
        [dateSeletedVC.subject subscribeNext:^(id  _Nullable x) {
            weakself.startTime = x[@"startTime"];
            weakself.endTime = x[@"endTime"];
            weakself.hearderView.workOrderView.timeShowView.timeLb.text = x[@"timeName"];
            [weakself getOrderData];
            weakself.dataType = weakself.seletedType;
            if (weakself.dataType != Car || weakself.dataType != Card)
            {
                [weakself getCurrentData];
            }
        }];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dateSeletedVC];
        [weakself presentViewController:nav animated:YES completion:nil];
    }];
    [_hearderView.handleView.infoView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        AddWorkPlaceVC *addWorkPlace = [AddWorkPlaceVC new];
        addWorkPlace.title = @"工地信息详情";
        [addWorkPlace.subject subscribeNext:^(id  _Nullable x) {
            [weakself.subject sendNext:x];
        }];
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
        workOrderApproveVC.projectId = weakself.response.projectId;
        [weakself.navigationController pushViewController:workOrderApproveVC animated:YES];
    }];
    [_hearderView.scanView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        CameraViewController *video = [CameraViewController new];
        video.resultCB = ^(NSString* text, UIImage* image) {
            [weakself requestLastTime:text image:image];
        };
        [weakself.navigationController pushViewController:video animated:YES];
        
    }];
    
    [_hearderView.carNumberView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself changeCarNumber];
    }];
    
    [_hearderView.admiView.printerStateLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        BluetoochMatchVC *bluetoochMatchVC = [BluetoochMatchVC new];
        [weakself.navigationController pushViewController:bluetoochMatchVC animated:YES];
    }];
    [_hearderView.subject subscribeNext:^(id  _Nullable x) {
        
        
        if (weakself.dataType == [weakself getTypeWithIndex:[x intValue]])
        {
            return;
        }

        weakself.dataType = [weakself getTypeWithIndex:[x intValue]];
        weakself.seletedType = weakself.dataType;
        [weakself.contentScrollView setContentOffset:CGPointMake([x intValue] * kScreenWidth, 0) animated:YES];
        [weakself loadData];
    }];
    return _hearderView;
}

- (void)loadData
{
    if (self.dataType == Car && self.carSource.count > 0)
    {
        return;
    }
    if (self.dataType == Card && self.cardSource.count > 0)
    {
        return;
    }
    [self getCurrentData];
}

- (WorkDataType)getTypeWithIndex:(int)index
{
    WorkDataType type = Car;
    if (![LoginInfoManage shareInstance].isBoss)
    {
        switch (index) {
            case 0:
            {
                type = Car;
                break;
            }
            case 1:
            {
                type = ZTC;
                break;
            }
            case 2:
            {
                type = Fall;
                break;
            }
            case 3:
            {
                type = Card;
                break;
            }
            case 4:
            {
                type = CarTeam;
                break;
            }
            case 5:
            {
                type = Soil;
                break;
            }
            case 6:
            {
                type = Discharged;
                break;
            }
            default:
                break;
        }
    }
    return [LoginInfoManage shareInstance].isBoss ? index : type;
}

- (WorkMainScrollView *)mainScroollView
{
    if (!_mainScroollView)
    {
        CGFloat height = kScreenHeight - [UIDevice navigationFullHeight];
        _mainScroollView = [[WorkMainScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,height)];
        _mainScroollView.delegate = self;
        _mainScroollView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        _mainScroollView.contentSize = CGSizeMake(0,  height + self.topViewHeight);
        if (@available(iOS 11.0, *))
        {
            _mainScroollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _mainScroollView;
}

- (void)customerUI
{
    [self.view addSubview:self.mainScroollView];
    WeakSelf(self);
    _mainScroollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakself.dataType = weakself.seletedType;
        [weakself reSetData];
        [weakself getCurrentData];
    }];
    [_mainScroollView addSubview:[self customerHearderView]];
    
    CGFloat height = kScreenHeight - [UIDevice navigationFullHeight];
    self.contentScrollView = [[WorkContentScrollView alloc] initWithFrame:CGRectMake(0, self.topViewHeight,kScreenWidth, height - self.floatHeight)];
    self.contentScrollView.delegate = self;
    self.contentScrollView.contentSize = CGSizeMake(([LoginInfoManage shareInstance].isBoss ? 6 : 7) * kScreenWidth, 0);
    
    self.contentScrollView.carTab.dataSource = self;
    self.contentScrollView.carTab.delegate = self;
    self.contentScrollView.carTab.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSDate *requestDate = [Tools stringTodate:self.carSource.lastObject.inReleaseDate];
        NSCalendar *gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
        NSDate *nextDate = [gregorian dateByAddingUnit:NSCalendarUnitDay value:-1 toDate:requestDate options:0];
        self.carRequestDate = [Tools dateToString:nextDate withDateFormat:@"yyyy-MM-dd"];
        [weakself getCurrentData];
    }];
    
    self.contentScrollView.ztcTab.delegate = self;
    self.contentScrollView.ztcTab.dataSource = self;

    self.contentScrollView.zdTab.delegate = self;
    self.contentScrollView.zdTab.dataSource = self;

    self.contentScrollView.cardTab.delegate = self;
    self.contentScrollView.cardTab.dataSource = self;
    self.contentScrollView.cardTab.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSDate *requestDate = [Tools stringTodate:[self.cardSource.lastObject.key substringToIndex:10]];
        NSCalendar *gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
        NSDate *nextDate = [gregorian dateByAddingUnit:NSCalendarUnitDay value:-1 toDate:requestDate options:0];
        self.cardRequestDate = [Tools dateToString:nextDate withDateFormat:@"yyyy-MM-dd"];
        [weakself getCurrentData];
    }];

    self.contentScrollView.carTeamTab.delegate = self;
    self.contentScrollView.carTeamTab.dataSource = self;

    self.contentScrollView.soilTab.delegate = self;
    self.contentScrollView.soilTab.dataSource = self;

    self.contentScrollView.historyTab.delegate = self;
    self.contentScrollView.historyTab.dataSource = self;
    
    [_mainScroollView addSubview:self.contentScrollView];
    
}

- (void)changeCarNumber
{
    WeakSelf(self)
    [Tools showCarNoChangeView:@"       " image:[UIImage imageNamed:@""] rescan:^{
        CameraViewController *video = [CameraViewController new];
        video.resultCB = ^(NSString* text, UIImage* image) {
            [weakself requestLastTime:text image:image];
        };
        [weakself.navigationController pushViewController:video animated:YES];
    } sure:^(NSString * _Nonnull result) {
        [weakself requestLastTime:result image:[UIImage imageNamed:@""]];
    }];
}

- (void)requestLastTime:(NSString *)text image:(UIImage *)image
{
    WeakSelf(self)
    GetRequest *offRequest = [[GetRequest alloc] initWithRequestUrl:detailsbyplatenumber
                                                           argument:@{@"plateNumber":text}];
    [offRequest startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            if ([result[@"data"] isKindOfClass:NSDictionary.class])
            {
                NSString *createTime = result[@"data"][@"created"];
                if (![Tools isEmpty:createTime])
                {
                    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                    [formatter setDateFormat:@"yyyy-MM-dd HH-mm-sss"];
                    NSDate *resDate = [formatter dateFromString:createTime];
                    
                    NSCalendar *calendar = [NSCalendar currentCalendar];
                    NSCalendarUnit unit = NSCalendarUnitMinute;
                    NSDateComponents *delta = [calendar components:unit fromDate:resDate toDate:[NSDate date] options:0];
                    if (delta.minute < 30) /// 小于30分钟弹框
                    {
                        [Tools showAlertWithTitle:@"提示" content:[NSString stringWithFormat:@"短时间内已经放行过一次，上一次放行时间%@，是否继续？",createTime] left:@"取消" right:@"确认" block:^{
                            [weakself pushToCreateWorkOrder:text image:image];
                        }];
                    }
                    else
                    {
                        [weakself pushToCreateWorkOrder:text image:image];
                    }
                }
                else
                {
                    [weakself pushToCreateWorkOrder:text image:image];
                }
            }
            else
            {
                [weakself pushToCreateWorkOrder:text image:image];
            }
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

- (void)pushToCreateWorkOrder:(NSString *)text image:(UIImage *)image
{
    CreateWorkOrderVC *createWorkOrderVC = [CreateWorkOrderVC new];
    createWorkOrderVC.title = self.response.name;
    createWorkOrderVC.projectId = self.response.projectId;
    createWorkOrderVC.carName = text;
    createWorkOrderVC.carImage = image;
    WeakSelf(self)
    [createWorkOrderVC.subject subscribeNext:^(id  _Nullable x) {
        weakself.dataType = weakself.seletedType;
        [[DatePointManage shareInstance] getPointDate:weakself.response.projectId];
        [weakself reSetData];
        [weakself getCurrentData];
    }];
    [weakself.navigationController pushViewController:createWorkOrderVC animated:NO];
}

- (void)getCurrentData
{
    switch (self.dataType)
    {
        case Car:
        {
            [self getCarRequest];
            break;
        }
        case Soil:
        {
            [self getEarthRequest];
            break;
        }
        case Card:
        {
            [self getCardRequest];
            break;
        }
        case ZTC:
        {
            [self getZTCReuest:NO];
            break;
        }
        case Fall:
        {
            [self getZTCReuest:YES];
            break;
        }
        case CarTeam:
        {
            [self getFleetRequest];
            break;
        }
        case Discharged:
        {
            [self getDischargedRequest];
            break;
        }
    }
}

- (void)reSetData
{
    if (self.dataType == Car)
    {
        self.carRequestDate = [Tools getCurrentDate];
        [self.carSource removeAllObjects];
    }
    else if (self.dataType == Card)
    {
        self.cardRequestDate = [Tools getCurrentDate];
        [self.cardSource removeAllObjects];
    }
}

/// 放行记录
- (void)getDischargedRequest
{
    WeakSelf(self)
    GetRequest *orderRequest = [[GetRequest alloc] initWithRequestUrl:accessstatistice
                                                             argument:@{@"startTime":self.startTime,
                                                                        @"endTime":self.endTime,
                                                                        @"projectId":self.response.projectId,
                                                                        @"role":[LoginInfoManage shareInstance].isBoss ? @"BOSS":@"ADMIN"
                                                                        }];
    [orderRequest startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            weakself.releaseSource = [WorkDetailReleaseResponse  mj_objectArrayWithKeyValuesArray:result[@"data"]];
            weakself.contentScrollView.historyTab.emptyLb.hidden = weakself.releaseSource.count != 0;
            [weakself.contentScrollView.historyTab reloadData];
        }
        [weakself.mainScroollView.mj_header endRefreshing];
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        [weakself.mainScroollView.mj_header endRefreshing];
    }];
}

/// 渣土场和自倒
- (void)getZTCReuest:(BOOL)isZD
{
    WeakSelf(self)
    GetRequest *orderRequest = [[GetRequest alloc] initWithRequestUrl:zdztcstatistics
                                                             argument:@{@"startTime":self.startTime,
                                                                        @"endTime":self.endTime,
                                                                        @"projectId":self.response.projectId,
                                                                        @"role":[LoginInfoManage shareInstance].isBoss ? @"BOSS":@"ADMIN"
                                                                        }];
    [orderRequest startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            if (isZD)
            {
                weakself.detailZDResponse = [WorkDetailZTResponse mj_objectWithKeyValues:result[@"data"]];
                NSArray *resultArr = [Tools cutArry:2 array:result[@"data"][@"zdPlateNumberMap"]];
                weakself.detailZDResponse.plateNumberMap = resultArr;
                [weakself ZDDataHandle];
                weakself.contentScrollView.zdTab.emptyLb.hidden = resultArr.count != 0;
                [weakself.contentScrollView.zdTab reloadData];
            }
            else
            {
                weakself.detailZTResponse = [WorkDetailZTResponse mj_objectWithKeyValues:result[@"data"]];
                for (int i = 0; i < weakself.detailZTResponse.ztcPlateNumberMap.count; i++)
                {
                    WorkztcModel *model = weakself.detailZTResponse.ztcPlateNumberMap[i];
                    NSArray *resultArr = [Tools cutArry:2 array:result[@"data"][@"ztcPlateNumberMap"][i][@"array"]];
                    model.plateNumberMap = resultArr;
                }
                weakself.contentScrollView.ztcTab.emptyLb.hidden = weakself.detailZTResponse.ztcPlateNumberMap.count != 0;
                [weakself ZTDataHandle];
                [weakself.contentScrollView.ztcTab reloadData];
            }
        }
        [weakself.mainScroollView.mj_header endRefreshing];
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        [weakself.mainScroollView.mj_header endRefreshing];
    }];
}

- (void)ZDDataHandle
{
    long maxCount = 2;
    NSMutableArray *zdArr = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *ztcArr = [NSMutableArray arrayWithCapacity:0];
    for (WorkDetailZTItem *item in self.detailZDResponse.totalDetails)
    {
        [zdArr addObject:[NSNumber numberWithLong:item.zdCount]];
        [ztcArr addObject:[NSNumber numberWithLong:item.ztcCount]];
        if (item.zdCount > maxCount)
        {
            maxCount = item.zdCount;
        }
        
        if (item.ztcCount > maxCount)
        {
            maxCount = item.ztcCount;
        }
    }
    self.detailZDResponse.ztArr = ztcArr;
    self.detailZDResponse.zdArr = zdArr;
    self.detailZDResponse.maxCount = maxCount;
    self.detailZDResponse.name = self.name;
    int count = (int)maxCount;
    NSMutableArray *countArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i <= count; i++)
    {
        [countArr addObject:[NSString stringWithFormat:@"%d",i]];
    }
    self.detailZDResponse.yArr = countArr;
}

- (void)ZTDataHandle
{
    long maxCount = 2;
    NSMutableArray *zdArr = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *ztcArr = [NSMutableArray arrayWithCapacity:0];
    for (WorkDetailZTItem *item in self.detailZTResponse.totalDetails)
    {
        [zdArr addObject:[NSNumber numberWithLong:item.zdCount]];
        [ztcArr addObject:[NSNumber numberWithLong:item.ztcCount]];
        if (item.zdCount > maxCount)
        {
            maxCount = item.zdCount;
        }
        
        if (item.ztcCount > maxCount)
        {
            maxCount = item.ztcCount;
        }
    }
    self.detailZTResponse.ztArr = ztcArr;
    self.detailZTResponse.zdArr = zdArr;
    self.detailZTResponse.maxCount = maxCount;
    self.detailZTResponse.name = self.name;
    int count = (int)maxCount;
    NSMutableArray *countArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i <= count; i++)
    {
        [countArr addObject:[NSString stringWithFormat:@"%d",i]];
    }
    self.detailZTResponse.yArr = countArr;
}

/// 车辆请求
- (void)getCarRequest
{
    WeakSelf(self)
    GetRequest *orderRequest = [[GetRequest alloc] initWithRequestUrl:carstatistics
                                                             argument:@{@"startDate":self.carRequestDate,
                                                                        @"projectId":self.response.projectId,
                                                                        @"role":[LoginInfoManage shareInstance].isBoss ? @"BOSS":@"ADMIN"
                                                                        }];
    [orderRequest startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            NSArray *resultDate = [CarstatisticsResponse mj_objectArrayWithKeyValuesArray:result[@"data"]];
            
            if (resultDate.count > 0)
            {
                [weakself.carSource addObjectsFromArray:resultDate];
                [weakself.contentScrollView.carTab.mj_footer endRefreshing];
            }
            else
            {
                [weakself.contentScrollView.carTab.mj_footer endRefreshingWithNoMoreData];
            }
            
            weakself.contentScrollView.carTab.emptyLb.hidden = weakself.carSource.count != 0;
            [weakself.contentScrollView.carTab reloadData];
        }
        else
        {
            [weakself.contentScrollView.carTab.mj_footer endRefreshing];
        }
        [weakself.mainScroollView.mj_header endRefreshing];
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        [weakself.contentScrollView.carTab.mj_footer endRefreshing];
        [weakself.mainScroollView.mj_header endRefreshing];
    }];
}

/// 卡牌请求
- (void)getCardRequest
{
    WeakSelf(self)
    GetRequest *orderRequest = [[GetRequest alloc] initWithRequestUrl:cardstatistics
                                                             argument:@{@"startDate":self.cardRequestDate,
                                                                        @"projectId":self.response.projectId
                                                                        }];
    [orderRequest startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            NSArray<WorkDetailCardResponse *> *resquestArr = [WorkDetailCardResponse mj_objectArrayWithKeyValuesArray:result[@"data"]];
            if (resquestArr.count > 0)
            {
                for (int i = 0; i < resquestArr.count; i++)
                {
                    NSArray *resultArr = [Tools cutArry:2 array:result[@"data"][i][@"plateNumberMap"]];
                    resquestArr[i].plateNumberMap = resultArr;
                }
                [weakself.cardSource addObjectsFromArray:resquestArr];
                [weakself.contentScrollView.cardTab.mj_footer endRefreshing];
            }
            else
            {
                [weakself.contentScrollView.cardTab.mj_footer endRefreshingWithNoMoreData];
            }
            
            weakself.contentScrollView.cardTab.emptyLb.hidden = weakself.cardSource.count != 0;
            [weakself.contentScrollView.cardTab reloadData];
        }
        [weakself.mainScroollView.mj_header endRefreshing];
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        [weakself.mainScroollView.mj_header endRefreshing];
    }];
}
/// 土类型请求
- (void)getEarthRequest
{
    WeakSelf(self)
    GetRequest *orderRequest = [[GetRequest alloc] initWithRequestUrl:earthstatistics
                                                             argument:@{@"startTime":self.startTime,
                                                                        @"endTime":self.endTime,
                                                                        @"projectId":self.response.projectId,
                                                                        @"role":[LoginInfoManage shareInstance].isBoss ? @"BOSS":@"ADMIN"
                                                                        }];
    [orderRequest startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            weakself.soilSource = [WorkDetailSoilResponse mj_objectArrayWithKeyValuesArray:result[@"data"]];
            weakself.contentScrollView.soilTab.emptyLb.hidden = weakself.soilSource.count != 0;
            [weakself.contentScrollView.soilTab reloadData];
        }
        [weakself.mainScroollView.mj_header endRefreshing];
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        [weakself.mainScroollView.mj_header endRefreshing];
    }];
}

/// 获取车队请求
- (void)getFleetRequest
{
    WeakSelf(self)
    GetRequest *orderRequest = [[GetRequest alloc] initWithRequestUrl:fleetstatistics
                                                             argument:@{@"startTime":self.startTime,
                                                                        @"endTime":self.endTime,
                                                                        @"projectId":self.response.projectId,
                                                                        @"role":[LoginInfoManage shareInstance].isBoss ? @"BOSS":@"ADMIN"
                                                                        }];
    [orderRequest startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            weakself.carTeamResponse = [WorkDetailCardTeamResponse mj_objectWithKeyValues:result[@"data"]];
            weakself.carTeamSource = weakself.carTeamResponse.list;
            for (int i = 0; i < weakself.carTeamSource.count; i++)
            {
                NSArray *resultArr = [Tools cutArry:2 array:result[@"data"][@"list"][i][@"fleetDetails"]];
                weakself.carTeamSource[i].fleetDetails = resultArr;
            }
            weakself.contentScrollView.carTeamTab.emptyLb.hidden = weakself.carTeamSource.count != 0;
            [weakself.contentScrollView.carTeamTab reloadData];
        }
        [weakself.mainScroollView.mj_header endRefreshing];
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        [weakself.mainScroollView.mj_header endRefreshing];
    }];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    if (tableView == self.contentScrollView.carTab)
    {
        if (self.carSource.count > section)
        {
            view = [self getCarHeaderView:self.carSource[section] section:section tableView:tableView];
        }
    }
    else if (tableView == self.contentScrollView.soilTab)
    {
        if (self.soilSource.count > section)
        {
            view = [self getSoilHeaderView:self.soilSource[section] tableView:tableView];
        }
    }
    else if (tableView == self.contentScrollView.carTeamTab)
    {
        if (self.carTeamSource.count > section)
        {
            view = [self getCarTeamHeaderView:self.carTeamSource[section] indexRow:section tableView:tableView];
        }
    }
    else if (tableView == self.contentScrollView.cardTab)
    {
        if (self.cardSource.count > section)
        {
            view = [self getCardHeaderView:self.cardSource[section] tableView:tableView];
        }
    }
    else if (tableView == self.contentScrollView.ztcTab)
    {
        WorkztcModel *model = self.detailZTResponse.ztcPlateNumberMap[section - 1];
        view = [self getzdHeaderView:tableView name:model.name number:model.totalCount];
    }
    else if (tableView == self.contentScrollView.zdTab)
    {
        view = [self getzdHeaderView:tableView name:@"" number:self.detailZDResponse.zdCount];
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 0;
    if (tableView == self.contentScrollView.carTab)
    {
        height = 80;
    }
    else if (tableView == self.contentScrollView.soilTab)
    {
        height = 80;
    }
    else if (tableView == self.contentScrollView.carTeamTab)
    {
        height = section == 0 ? 210 : 120;
    }
    else if (tableView == self.contentScrollView.cardTab)
    {
        height = 120;
    }
    else if (tableView == self.contentScrollView.ztcTab)
    {
        height = section == 0 ? 0 : 84;
    }
    else if (tableView == self.contentScrollView.zdTab)
    {
        height = section == 0 ? 0 : 84;
    }
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    WorkManageDetailFooterView *footerView = [WorkManageDetailFooterView cellWithTableViewHeaderFooterView:tableView];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat height = 16;
    if (tableView == self.contentScrollView.historyTab)
    {
        height = 0;
    }
    return height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    CGFloat number;
    if (tableView == self.contentScrollView.carTab)
    {
        number = self.carSource.count;
    }
    else if (tableView == self.contentScrollView.soilTab)
    {
        number = self.soilSource.count;
    }
    else if (tableView == self.contentScrollView.carTeamTab)
    {
        number = self.carTeamSource.count;
    }
    else if (tableView == self.contentScrollView.cardTab)
    {
        number = self.cardSource.count;
    }
    else if (tableView == self.contentScrollView.ztcTab)
    {
        number = 1 + self.detailZTResponse.ztcPlateNumberMap.count;
    }
    else if (tableView == self.contentScrollView.zdTab)
    {
        number = 1 + (self.detailZDResponse.plateNumberMap.count > 0 ? 1 : 0);
    }
    else
    {
        number = 1;
    }
    return number;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    if (tableView == self.contentScrollView.carTab)
    {
        height = 100;
    }
    else if (tableView == self.contentScrollView.soilTab)
    {
        height = 40;
    }
    else if (tableView == self.contentScrollView.carTeamTab)
    {
        height = 40;
    }
    else if (tableView == self.contentScrollView.cardTab)
    {
        height = 40;
    }
    else if (tableView == self.contentScrollView.ztcTab)
    {
        height = indexPath.section == 0 ? 300 : 40;
    }
    else if (tableView == self.contentScrollView.zdTab)
    {
        height = indexPath.section == 0 ? 300 : 40;
    }
    else
    {
        height = 100;
    }
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CGFloat number = 0;
    if (tableView == self.contentScrollView.carTab)
    {
        if (self.carSource.count > section)
        {
            CarstatisticsResponse *response = self.carSource[section];
            number = response.isSeleted ? 0 : response.plateNumberMap.count;
        }
    }
    else if (tableView == self.contentScrollView.soilTab)
    {
        if (self.soilSource.count > section)
        {
            number = self.soilSource[section].orderMap.count;
        }
    }
    else if (tableView == self.contentScrollView.carTeamTab)
    {
        if (self.carTeamSource.count > section)
        {
            number = self.carTeamSource[section].fleetDetails.count;
        }
    }
    else if (tableView == self.contentScrollView.cardTab)
    {
        if (self.cardSource.count > section)
        {
            number = self.cardSource[section].plateNumberMap.count;
        }
    }
    else if (tableView == self.contentScrollView.ztcTab)
    {
        if (section == 0)
        {
            number = 1;
        }
        else
        {
            if (self.detailZTResponse.ztcPlateNumberMap.count > 0)
            {
                WorkztcModel *model = self.detailZTResponse.ztcPlateNumberMap[section - 1];
                number = model.plateNumberMap.count;
            }
            else
            {
                number = 0;
            }
        }
    }
    else if (tableView == self.contentScrollView.zdTab)
    {
        number = section == 0 ? 1 : self.detailZDResponse.plateNumberMap.count;
    }
    else
    {
        number = self.releaseSource.count;
    }
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    WeakSelf(self)
    if (tableView == self.contentScrollView.carTab)
    {
        cell = [WorkManageCarCell cellWithCollectionView:tableView];
        if (self.carSource.count > 0 &&
            self.carSource[indexPath.section].plateNumberMap.count > 0)
        {
            [(WorkManageCarCell *)cell loadViewWithModel:self.carSource[indexPath.section].plateNumberMap[indexPath.row]];
        }
    }
    else if (tableView == self.contentScrollView.soilTab)
    {
        cell = [WorkManageSoilCell cellWithCollectionView:tableView];
        if (self.soilSource.count > 0 &&
            self.soilSource[indexPath.section].orderMap.count > 0)
        {
            [(WorkManageSoilCell *)cell loadViewWithModel:self.soilSource[indexPath.section].orderMap[indexPath.row]];
        }
    }
    else if (tableView == self.contentScrollView.carTeamTab)
    {
        WorkManageCardCell *cardCell = [WorkManageCardCell cellWithCollectionView:tableView];
        cardCell.callback = ^(NSString *name) {
            [weakself gotoDetailVCWithPlateNumber:name startTime:weakself.startTime endTime:weakself.endTime workType:@""];
        };
        if (self.carTeamSource.count > 0 &&
            self.carTeamSource[indexPath.section].fleetDetails.count > 0)
        {
            [cardCell loadViewWithArray:self.carTeamSource[indexPath.section].fleetDetails[indexPath.row] indexRow:(int)indexPath.row];
        }
        cell = cardCell;
    }
    else if (tableView == self.contentScrollView.cardTab)
    {
        WorkManageCardCell *cardCell = [WorkManageCardCell cellWithCollectionView:tableView];
        cardCell.callback = ^(NSString *name) {
            NSString *startTime = [NSString stringWithFormat:@"%@ 00:00:00",self.cardSource[indexPath.section].inReleaseDate];
            NSString *endTime = [NSString stringWithFormat:@"%@ 23:59:59",self.cardSource[indexPath.section].inReleaseDate];
            [weakself gotoDetailVCWithPlateNumber:name startTime:startTime endTime:endTime workType:self.cardSource[indexPath.section].workType];
        };
        if (self.cardSource.count > 0 &&
            self.cardSource[indexPath.section].plateNumberMap.count > 0)
        {
            [cardCell loadViewWithArray:self.cardSource[indexPath.section].plateNumberMap[indexPath.row] indexRow:(int)indexPath.row];
        }
        cell = cardCell;
    }
    else if (tableView == self.contentScrollView.ztcTab)
    {
        if (indexPath.section == 0)
        {
            cell = [EchartCell cellWithCollectionView:tableView];
            if (self.detailZTResponse)
            {
                [(EchartCell *)cell loadViewWithModel:self.detailZTResponse];
            }
        }
        else
        {
            WorkManageCardCell *cardCell = [WorkManageCardCell cellWithCollectionView:tableView];
            cardCell.callback = ^(NSString *name) {
                [weakself gotoDetailVCWithPlateNumber:name startTime:weakself.startTime endTime:weakself.endTime workType:@""];
            };
            if (self.detailZTResponse.ztcPlateNumberMap.count > 0)
            {
                WorkztcModel *model = self.detailZTResponse.ztcPlateNumberMap[indexPath.section - 1];
                if (model.plateNumberMap.count > 0)
                {
                    [cardCell loadViewWithArray:model.plateNumberMap[indexPath.row] indexRow:(int)indexPath.row];
                }
            }
            cell = cardCell;
        }
    }
    else if (tableView == self.contentScrollView.zdTab)
    {
        if (indexPath.section == 0)
        {
            cell = [EchartCell cellWithCollectionView:tableView];
            if (self.detailZDResponse)
            {
                [(EchartCell *)cell loadViewWithModel:self.detailZDResponse];
            }
        }
        else
        {
            WorkManageCardCell *cardCell = [WorkManageCardCell cellWithCollectionView:tableView];
            cardCell.callback = ^(NSString *name) {
                [weakself gotoDetailVCWithPlateNumber:name startTime:weakself.startTime endTime:weakself.endTime workType:@""];
            };
            if (self.detailZDResponse.plateNumberMap.count > 0)
            {
                [cardCell loadViewWithArray:self.detailZDResponse.plateNumberMap[indexPath.row] indexRow:(int)indexPath.row];
            }
            cell = cardCell;
        }
    }
    else
    {
        cell = [WorkManageReleaseCell cellWithCollectionView:tableView];
        if (self.releaseSource.count > 0)
        {
            [(WorkManageReleaseCell *)cell loadViewWithModel:self.releaseSource[indexPath.row]];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.contentScrollView.carTab || tableView == self.contentScrollView.historyTab)
    {
        if (tableView == self.contentScrollView.carTab)
        {
            CarstatisticsItemResponse *response = self.carSource[indexPath.section].plateNumberMap[indexPath.row];
            NSString *startDate = [NSString stringWithFormat:@"%@ 00:00:00",self.carSource[indexPath.section].inReleaseDate];
            NSString *endDate = [NSString stringWithFormat:@"%@ 23:59:59",self.carSource[indexPath.section].inReleaseDate];
            [self gotoDetailVCWithPlateNumber:response.plateNumber startTime:startDate endTime:endDate workType:@""];
        }
        else
        {
            WorkDetailReleaseResponse *response = self.releaseSource[indexPath.row];
            [self gotoDetailVCWithPlateNumber:response.plateNumber startTime:self.startTime endTime:self.endTime workType:@""];
        }
        
    }
}

- (void)gotoDetailVCWithPlateNumber:(NSString *)plateNumber
                          startTime:(NSString *)startTime
                            endTime:(NSString *)endTime
                           workType:(NSString *)workType
{
    WorkOrderDetailVC *workOrderDetailVC = [WorkOrderDetailVC new];
    workOrderDetailVC.plateNumber = plateNumber;
    workOrderDetailVC.projectId = self.response.projectId;
    workOrderDetailVC.startTime = startTime;
    workOrderDetailVC.endTime = endTime;
    workOrderDetailVC.workType = workType;
    WeakSelf(self)
    [workOrderDetailVC.subject subscribeNext:^(id  _Nullable x) {
        weakself.dataType = weakself.seletedType;
        [weakself reSetData];
        [weakself getCurrentData];
    }];
    [self.navigationController cyl_pushViewController:workOrderDetailVC animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.mainScroollView)
    {
        CGFloat contentOffsetY = scrollView.contentOffset.y;
        CGFloat maxOffsetY = self.topViewHeight - self.floatHeight;
        if (contentOffsetY >= maxOffsetY)
        {
            self.contentCanMove = YES;
            self.canMove = NO;   // 自己不能滑动了
        }
        if (!self.canMove)
        {
            [scrollView setContentOffset:CGPointMake(0, maxOffsetY)];
        }
    }
    else if ([scrollView isKindOfClass:UITableView.class])
    {
        if (!self.contentCanMove)
        {
            [scrollView setContentOffset:CGPointMake(0, 0)];
            for (UITableView *table in self.contentScrollView.subviews)
            {
                [table setContentOffset:CGPointMake(0, 0)];
            }
        }
        
        CGFloat offsetY = scrollView.contentOffset.y;
        if (offsetY <= 0)
        {
            self.canMove = YES;
            self.contentCanMove = NO;
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.contentScrollView)
    {
        int number = scrollView.contentOffset.x / kScreenWidth;
        if (self.scrollIndex != number)
        {
            self.scrollIndex = number;
            [self.hearderView.workStatisicsView.itemCompent seletedHandle:number];
            self.dataType = [self getTypeWithIndex:number];
            self.seletedType = self.dataType;
            [self loadData];
        }
    }
}

@end
