//
//  WorkManageDetailVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/5.
//

#import "WorkManageDetailVC.h"
#import "WorkManageCarCell.h"
#import "WorkManageDetailHeaderView.h"
#import "AddWorkPlaceVC.h"
#import "MemberManageVC.h"
#import "LoginInfoManage.h"
#import "WorkDetailResponse.h"
#import "WorkConfigVC.h"
#import "OnWorkLilstResponse.h"
#import "RoleApproveVC.h"
#import "WorkOrderApproveVC.h"
#import "WorkManageCarHeaderView.h"
#import "WorkOrderResponse.h"
#import "WorkManageCardCell.h"
#import "WorkManageCardHeaderView.h"
#import "WorkManageSoilCell.h"
#import "EchartCell.h"
#import "WorkOrderDetailVC.h"
#import "CreateWorkOrderVC.h"
#import "BluetoochMatchVC.h"
#import "DischargedModelVC.h"
#import "CarstatisticsResponse.h"
#import "WorkManageCarTeamCell.h"
#import "WorkManageSoilHeaderView.h"
#import "WorkDetailSoilResponse.h"
#import "WorkDetailCardResponse.h"
#import "WorkDetailCardTeamResponse.h"
#import "WorkManageReleaseCell.h"
#import "WorkDetailReleaseResponse.h"
#import "DateSeletedVC.h"
#import "WorkDetailZTResponse.h"
#import "WorkManageEmptyCell.h"
#import "WorkConfigResponse.h"
#import "CameraViewController.h"
#import "WorkManageCarTeamHeaderView.h"
#import "UIViewController+CYLTabBarControllerExtention.h"
#import "DatePointManage.h"
#import "WorkManageDetailFooterView.h"
#import "WorkManageZDHeaderView.h"
#import "WorkManageCarHeaderView.h"
#import "WorkManageSoilHeaderView.h"
@interface WorkManageDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIBarButtonItem *configBt; /// 配置
@property (nonatomic, strong) UIBarButtonItem *offBt; /// 下班
@property (nonatomic, strong) WorkManageDetailHeaderView *hearderView;
@property (nonatomic, assign) WorkDataType dataType;
@property (nonatomic, assign) WorkDataType seletedType;

@property (nonatomic, strong) NSMutableArray<CarstatisticsResponse *> *carSource;
@property (nonatomic, strong) NSArray<WorkDetailSoilResponse *> *soilSource;
@property (nonatomic, strong) NSMutableArray<WorkDetailCardResponse *> *cardSource;
@property (nonatomic, strong) NSArray<WorkDetailCardTeamListResponse *> *carTeamSource;
@property (nonatomic, strong) NSArray<WorkDetailReleaseResponse *> *releaseSource;

@property (nonatomic, strong) WorkDetailZTResponse *detailZTResponse;
@property (nonatomic, strong) WorkDetailZTResponse *detailZDResponse;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, strong) NSArray<OnWorkLilstResponse *> *manageArr;
@property (nonatomic, strong) WorkDetailCardTeamResponse *carTeamResponse;

@property (nonatomic, copy) NSString *carRequestDate;
@property (nonatomic, copy) NSString *cardRequestDate;
@end

@implementation WorkManageDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.response.name;
    self.carRequestDate = [Tools getCurrentDate];
    self.cardRequestDate = [Tools getCurrentDate];
    self.carSource = [NSMutableArray arrayWithCapacity:0];
    self.cardSource = [NSMutableArray arrayWithCapacity:0];
    [[DatePointManage shareInstance] getPointDate:self.response.projectId];
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
        [weakself.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
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

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [self headerView];
        _tableView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:WorkManageCarCell.class forCellReuseIdentifier:NSStringFromClass(WorkManageCarCell.class)];
        [_tableView registerClass:WorkManageCardCell.class forCellReuseIdentifier:NSStringFromClass(WorkManageCardCell.class)];
        [_tableView registerClass:WorkManageSoilCell.class forCellReuseIdentifier:NSStringFromClass(WorkManageSoilCell.class)];
        [_tableView registerClass:EchartCell.class forCellReuseIdentifier:NSStringFromClass(EchartCell.class)];
        [_tableView registerClass:WorkManageCarTeamCell.class forCellReuseIdentifier:NSStringFromClass(WorkManageCarTeamCell.class)];
        [_tableView registerClass:WorkManageReleaseCell.class forCellReuseIdentifier:NSStringFromClass(WorkManageReleaseCell.class)];
        [_tableView registerClass:WorkManageEmptyCell.class forCellReuseIdentifier:NSStringFromClass(WorkManageEmptyCell.class)];
        
        [_tableView registerClass:WorkManageDetailFooterView.class forHeaderFooterViewReuseIdentifier:NSStringFromClass(WorkManageDetailFooterView.class)];
        [_tableView registerClass:WorkManageCarTeamHeaderView.class forHeaderFooterViewReuseIdentifier:NSStringFromClass(WorkManageCarTeamHeaderView.class)];
        [_tableView registerClass:WorkManageCardHeaderView.class forHeaderFooterViewReuseIdentifier:NSStringFromClass(WorkManageCardHeaderView.class)];
        [_tableView registerClass:WorkManageZDHeaderView.class forHeaderFooterViewReuseIdentifier:NSStringFromClass(WorkManageZDHeaderView.class)];
        [_tableView registerClass:WorkManageCarHeaderView.class forHeaderFooterViewReuseIdentifier:NSStringFromClass(WorkManageCarHeaderView.class)];
        [_tableView registerClass:WorkManageSoilHeaderView.class forHeaderFooterViewReuseIdentifier:NSStringFromClass(WorkManageSoilHeaderView.class)];
    }
    return _tableView;
}

- (UIView *)headerView
{
    self.hearderView = [WorkManageDetailHeaderView new];
    self.hearderView.projectId = self.response.projectId;
    _hearderView.frame = CGRectMake(0, 0, kScreenWidth, [LoginInfoManage shareInstance].isBoss ? 564 : 584);
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
        
        WorkDataType type = Car;
        if (![LoginInfoManage shareInstance].isBoss)
        {
            switch ([x intValue]) {
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
        
        if (weakself.dataType == ([LoginInfoManage shareInstance].isBoss ? [x intValue] : type))
        {
            return;
        }
        [weakself.tableView.mj_footer resetNoMoreData];
        weakself.dataType = [LoginInfoManage shareInstance].isBoss ? [x intValue] : type;
        weakself.seletedType = weakself.dataType;
        [weakself getCurrentData];
    }];
    return _hearderView;
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
//        case Empty:
//        {
//            break;
//        }
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

- (void)customerUI
{
    [self.view addSubview:self.tableView];
    WeakSelf(self);
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakself.dataType = weakself.seletedType;
        [weakself reSetData];
        [weakself getCurrentData];
    }];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (weakself.dataType == Car)
        {
            NSDate *requestDate = [Tools stringTodate:self.carSource.lastObject.inReleaseDate];
            NSCalendar *gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
            NSDate *nextDate = [gregorian dateByAddingUnit:NSCalendarUnitDay value:-1 toDate:requestDate options:0];
            self.carRequestDate = [Tools dateToString:nextDate withDateFormat:@"yyyy-MM-dd"];
            [weakself getCurrentData];
        }
        else if (weakself.dataType == Card)
        {
            NSDate *requestDate = [Tools stringTodate:[self.cardSource.lastObject.key substringToIndex:10]];
            NSCalendar *gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
            NSDate *nextDate = [gregorian dateByAddingUnit:NSCalendarUnitDay value:-1 toDate:requestDate options:0];
            self.cardRequestDate = [Tools dateToString:nextDate withDateFormat:@"yyyy-MM-dd"];
            [weakself getCurrentData];
        }
        else
        {
            [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
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
//            if (weakself.releaseSource.count == 0)
//            {
//                weakself.dataType = Empty;
//            }
            [weakself.tableView reloadData];
        }
        [weakself.tableView.mj_header endRefreshing];
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        [weakself.tableView.mj_header endRefreshing];
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
                [weakself ZTDataHandle];
            }
            
            [weakself.tableView reloadData];
        }
        [weakself.tableView.mj_header endRefreshing];
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        [weakself.tableView.mj_header endRefreshing];
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
                [weakself.tableView.mj_footer endRefreshing];
            }
            else
            {
                [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
            }
//            if (weakself.carSource.count == 0)
//            {
//                weakself.dataType = Empty;
//            }
            [weakself.tableView reloadData];
        }
        else
        {
            [weakself.tableView.mj_footer endRefreshing];
        }
        [weakself.tableView.mj_header endRefreshing];
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        [weakself.tableView.mj_footer endRefreshing];
        [weakself.tableView.mj_header endRefreshing];
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
                [weakself.tableView.mj_footer endRefreshing];
            }
            else
            {
                [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
            }
//            if (weakself.cardSource.count == 0)
//            {
//                weakself.dataType = Empty;
//            }
            [weakself.tableView reloadData];
        }
        [weakself.tableView.mj_header endRefreshing];
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        [weakself.tableView.mj_header endRefreshing];
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
//            if (weakself.soilSource.count == 0)
//            {
//                weakself.dataType = Empty;
//            }
            [weakself.tableView reloadData];
        }
        [weakself.tableView.mj_header endRefreshing];
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        [weakself.tableView.mj_header endRefreshing];
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
//            if (weakself.carTeamSource.count == 0)
//            {
//                weakself.dataType = Empty;
//            }
            [weakself.tableView reloadData];
        }
        [weakself.tableView.mj_header endRefreshing];
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        [weakself.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    switch (self.dataType)
    {
        case Car:
        {
            if (self.carSource.count > section)
            {
                view = [self getCarHeaderView:self.carSource[section] section:section tableView:tableView];
            }
            break;
        }
        case Soil:
        {
            if (self.soilSource.count > section)
            {
                view = [self getSoilHeaderView:self.soilSource[section] tableView:tableView];
            }
            break;
        }
        case CarTeam:
        {
            if (self.carTeamSource.count > section)
            {
                view = [self getCarTeamHeaderView:self.carTeamSource[section] indexRow:section tableView:tableView];
            }
            break;
        }
        case Card:
        {
            if (self.cardSource.count > section)
            {
                view = [self getCardHeaderView:self.cardSource[section] tableView:tableView];
            }
            break;
        }
        case ZTC:
        {
            WorkztcModel *model = self.detailZTResponse.ztcPlateNumberMap[section - 1];
            view = [self getzdHeaderView:tableView name:model.name number:model.totalCount];
            break;
        }
        case Fall:
        {
            view = [self getzdHeaderView:tableView name:@"" number:self.detailZDResponse.zdCount];
            break;
        }
        case Discharged:
//        case Empty:
        {
            break;
        }
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height;
    switch (self.dataType)
    {
        case Car:
        {
            height = 80;
            break;
        }
        case Soil:
        {
            height = 80;
            break;
        }
        case Card:
        {
            height = 120;
            break;
        }
        case CarTeam:
        {
            height = section == 0 ? 210 : 120;
            break;
        }
        case ZTC:
        {
            height = section == 0 ? 0 : self.detailZTResponse.ztcPlateNumberMap.count > 0 ? 84 : 0;
            break;
        }
        case Fall:
        {
            height = section == 0 ? 0 : self.detailZDResponse.plateNumberMap.count > 0 ? 84 : 0;
            break;
        }
        case Discharged:
//        case Empty:
        {
            height = 0;
            break;
        }
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
    CGFloat height;
    switch (self.dataType)
    {
        case Car:
        case Card:
        case Soil:
        case ZTC:
        case Fall:
        case CarTeam:
        {
            height = 16;
            break;
        }
        case Discharged:
//        case Empty:
        {
            height = 0;
            break;
        }
    }
    return height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    CGFloat number;
    switch (self.dataType)
    {
        case Car:
        {
            number = self.carSource.count;
            break;
        }
        case Soil:
        {
            number = self.soilSource.count;
            break;
        }
        case Card:
        {
            number = self.cardSource.count;
            break;
        }
        case ZTC:
        {
            number = 1 + self.detailZTResponse.ztcPlateNumberMap.count > 0 ? self.detailZTResponse.ztcPlateNumberMap.count : 1;
        }
        case Fall:
        {
            number = 2;
            break;
        }
        case Discharged:
//        case Empty:
        {
            number = 1;
            break;
        }
        case CarTeam:
        {
            number = self.carTeamSource.count;
            break;
        }
    }
    return number;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    switch (self.dataType)
    {
        case Car:
        {
            height = 100;
            break;
        }
        case Soil:
        {
            height = 40;
            break;
        }
        case Card:
        case CarTeam:
        {
            height = 40;
            break;
        }
        case ZTC:
        {
            height = indexPath.section == 0 ? 300 : self.detailZTResponse.ztcPlateNumberMap.count > 0 ? 40 : 300;
            break;
        }
        case Fall:
        {
            height = indexPath.section == 0 ? 300 : self.detailZDResponse.plateNumberMap.count > 0 ? 40 : 300;
            break;
        }
//        case Empty:
//        {
//            height = 300;
//            break;
//        }
        case Discharged:
        {
            height = 100;
            break;
        }
    }
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CGFloat number = 0;
    switch (self.dataType)
    {
        case Car:
        {
            if (self.carSource.count > section)
            {
                CarstatisticsResponse *response = self.carSource[section];
                number = response.isSeleted ? 0 : response.plateNumberMap.count;
            }
            break;
        }
        case Soil:
        {
            if (self.soilSource.count > section)
            {
                number = self.soilSource[section].orderMap.count;
            }
            break;
        }
        case Card:
        {
            if (self.cardSource.count > section)
            {
                number = self.cardSource[section].plateNumberMap.count;
            }
            break;
        }
        case ZTC:
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
                    number = 1;
                }
            }
            break;
        }
        case Fall:
        {
            number = section == 0 ? 1 : self.detailZDResponse.plateNumberMap.count > 0 ? self.detailZDResponse.plateNumberMap.count : 1;
            break;
        }
//        case Empty:
//        {
//            number = 1;
//            break;
//        }
        case CarTeam:
        {
            if (self.carTeamSource.count > section)
            {
                number = self.carTeamSource[section].fleetDetails.count;
            }
            break;
        }
        case Discharged:
        {
            number = self.releaseSource.count;
            break;
        }
    }
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    WeakSelf(self)
    switch (self.dataType)
    {
        case Car:
        {
            cell = [WorkManageCarCell cellWithCollectionView:tableView];
            [(WorkManageCarCell *)cell loadViewWithModel:self.carSource[indexPath.section].plateNumberMap[indexPath.row]];
            break;
        }
        case Soil:
        {
            cell = [WorkManageSoilCell cellWithCollectionView:tableView];
            [(WorkManageSoilCell *)cell loadViewWithModel:self.soilSource[indexPath.section].orderMap[indexPath.row]];
            break;
        }
        case Card:
        {
            WorkManageCardCell *cardCell = [WorkManageCardCell cellWithCollectionView:tableView];
            cardCell.callback = ^(NSString *name) {
                NSString *startTime = [NSString stringWithFormat:@"%@ 00:00:00",self.cardSource[indexPath.section].inReleaseDate];
                NSString *endTime = [NSString stringWithFormat:@"%@ 23:59:59",self.cardSource[indexPath.section].inReleaseDate];
                [weakself gotoDetailVCWithPlateNumber:name startTime:startTime endTime:endTime workType:self.cardSource[indexPath.section].workType];
            };
            [cardCell loadViewWithArray:self.cardSource[indexPath.section].plateNumberMap[indexPath.row] indexRow:(int)indexPath.row];
            cell = cardCell;
            break;
        }
        case ZTC:
        {
            if (indexPath.section == 0)
            {
                cell = [EchartCell cellWithCollectionView:tableView];
                [(EchartCell *)cell loadViewWithModel:self.detailZTResponse];
            }
            else
            {
                if (self.detailZTResponse.ztcPlateNumberMap.count > 0)
                {
                    WorkztcModel *model = self.detailZTResponse.ztcPlateNumberMap[indexPath.section - 1];
                    WorkManageCardCell *cardCell = [WorkManageCardCell cellWithCollectionView:tableView];
                    cardCell.callback = ^(NSString *name) {
                        [weakself gotoDetailVCWithPlateNumber:name startTime:weakself.startTime endTime:weakself.endTime workType:@""];
                    };
                    [cardCell loadViewWithArray:model.plateNumberMap[indexPath.row] indexRow:(int)indexPath.row];
                    cell = cardCell;
                }
                else
                {
                    cell = [WorkManageEmptyCell cellWithCollectionView:tableView];
                }
                
            }
            break;
        }
        case Fall:
        {
            if (indexPath.section == 0)
            {
                cell = [EchartCell cellWithCollectionView:tableView];
                [(EchartCell *)cell loadViewWithModel:self.detailZDResponse];
            }
            else
            {
                if (self.detailZDResponse.plateNumberMap.count > 0)
                {
                    WorkManageCardCell *cardCell = [WorkManageCardCell cellWithCollectionView:tableView];
                    cardCell.callback = ^(NSString *name) {
                        [weakself gotoDetailVCWithPlateNumber:name startTime:weakself.startTime endTime:weakself.endTime workType:@""];
                    };
                    [cardCell loadViewWithArray:self.detailZDResponse.plateNumberMap[indexPath.row] indexRow:(int)indexPath.row];
                    cell = cardCell;
                }
                else
                {
                    cell = [WorkManageEmptyCell cellWithCollectionView:tableView];
                }
            }
            break;
        }
        case CarTeam:
        {
            WorkManageCardCell *cardCell = [WorkManageCardCell cellWithCollectionView:tableView];
            cardCell.callback = ^(NSString *name) {
                [weakself gotoDetailVCWithPlateNumber:name startTime:weakself.startTime endTime:weakself.endTime workType:@""];
            };
            [cardCell loadViewWithArray:self.carTeamSource[indexPath.section].fleetDetails[indexPath.row] indexRow:(int)indexPath.row];
            cell = cardCell;
            break;
        }
        case Discharged:
        {
            cell = [WorkManageReleaseCell cellWithCollectionView:tableView];
            [(WorkManageReleaseCell *)cell loadViewWithModel:self.releaseSource[indexPath.row]];
            break;
        }
//        case Empty:
//        {
//            cell = [WorkManageEmptyCell cellWithCollectionView:tableView];
//            break;
//        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataType == Car || self.dataType == Discharged)
    {
        if (self.dataType == Car)
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
@end
