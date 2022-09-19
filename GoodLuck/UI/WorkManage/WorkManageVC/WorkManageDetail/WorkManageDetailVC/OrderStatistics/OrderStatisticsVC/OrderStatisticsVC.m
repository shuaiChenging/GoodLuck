//
//  OrderStatisticsVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/18.
//

#import "OrderStatisticsVC.h"
#import "OrderStatisticsNomalCell.h"
#import "SeletedItemCompent.h"
#import "OrderStatisticsErrorCell.h"
#import "OrderStatisticsDeleteCell.h"
#import "WorkOrderDetailResponse.h"
#import "DateSeletedVC.h"
#import "WorkOrderDetailVC.h"
#import "OnWorkLilstResponse.h"
#import "WorkConfigManageResponse.h"
#import "TableSeletedCompent.h"
#import "SeletedComponent.h"
#import "OrderStatisticsErrorDeleteCell.h"
@interface OrderStatisticsVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) GLTableView *tableView;
@property (nonatomic, strong) UILabel *timeLb;
@property (nonatomic, strong) GLTextField *searchBar;
@property (nonatomic, assign) StatisticsType type;
@property (nonatomic, strong) NSArray<WorkOrderDetailResponse *> *source;

@property (nonatomic, copy) NSString *deleteFlag;
@property (nonatomic, copy) NSString *isException;
@property (nonatomic, copy) NSString *isZd;
@property (nonatomic, copy) NSString *plateNumber;

@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;

@property (nonatomic, strong) UILabel *countLb;

@property (nonatomic, copy) NSString *tenantId;

@property (nonatomic, strong) UIButton *rightNavBt;

@property (nonatomic, strong) NSMutableArray<OnWorkLilstResponse *> *manageArr;

@property (nonatomic, strong) NSArray *manageSeletedArr;

@property (nonatomic, strong) SeletedComponent *seletedComponent;

@property (nonatomic, copy) NSString *ztcId;
 
@property (nonatomic, strong) NSMutableArray<WorkConfigManageResponse *> *workConfigs;

@property (nonatomic, strong) NSArray *workConfigSeleteds;
@end

@implementation OrderStatisticsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"工单统计流水";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightNavBt];
    self.startTime = [NSString stringWithFormat:@"%@ 00:00:00",[Tools dateToString:[NSDate date] withDateFormat:@"yyyy-MM-dd"]];
    self.endTime = [NSString stringWithFormat:@"%@ 23:59:59",[Tools dateToString:[NSDate date] withDateFormat:@"yyyy-MM-dd"]];
    self.deleteFlag = @"";
    self.isException = @"";
    self.isZd = @"";
    self.tenantId = @"";
    self.plateNumber = @"";
    self.manageArr = [NSMutableArray arrayWithCapacity:0];
    self.workConfigs = [NSMutableArray arrayWithCapacity:0];
    [self customerUI];
    [self getManageData];
    [self getZTCData];
}

- (void)getZTCData
{
    WeakSelf(self)
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:ztcquery argument:@{@"projectId":self.projectId}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            NSArray *array = [WorkConfigManageResponse mj_objectArrayWithKeyValuesArray:result[@"data"]];
            [weakself.workConfigs addObjectsFromArray:array];
            
            WorkConfigManageResponse *allConfig = [WorkConfigManageResponse new];
            allConfig.workId = @"";
            allConfig.name = @"全部";
            [weakself.workConfigs insertObject:allConfig atIndex:0];
            weakself.workConfigSeleteds = [[weakself.workConfigs.rac_sequence map:^id _Nullable(WorkConfigManageResponse * _Nullable value) {
                return value.name;
            }] array];
        }
        
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

- (void)manage
{
    if (self.manageSeletedArr.count == 0)
    {
        return;
    }
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor clearColor];
    [window addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(window);
    }];
    
    TableSeletedCompent *tableSeletedCompent = [[TableSeletedCompent alloc] initWithArray:self.manageSeletedArr];
    WeakSelf(self)
    [tableSeletedCompent.subject subscribeNext:^(id  _Nullable x) {
        weakself.tenantId = weakself.manageArr[[x intValue]].tenantId;
        [weakself.rightNavBt setTitle:weakself.manageArr[[x intValue]].name forState:UIControlStateNormal];
        [weakself requestData];
        [backView removeFromSuperview];
    }];
    [window addSubview:tableSeletedCompent];
    [tableSeletedCompent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-16);
        make.top.equalTo(self.view);
        make.width.equalTo(100);
        make.height.equalTo(40 * self.manageSeletedArr.count);
    }];
    WeakSelf(backView)
    [backView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakbackView removeFromSuperview];
        [tableSeletedCompent removeFromSuperview];
    }];
    
}

- (UIButton *)rightNavBt
{
    if (!_rightNavBt)
    {
        _rightNavBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightNavBt setTitle:@"全部" forState:UIControlStateNormal];
        _rightNavBt.frame = CGRectMake(0, 0, 60, 44);
        [_rightNavBt.titleLabel setFont:[UIFont systemFontOfSize:font_14]];
        [_rightNavBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_rightNavBt addTarget:self action:@selector(manage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightNavBt;
}

- (SeletedComponent *)seletedComponent
{
    if (!_seletedComponent)
    {
        _seletedComponent = [SeletedComponent new];
        _seletedComponent.hidden = YES;
        WeakSelf(self)
        [_seletedComponent jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [weakself seletedZTC];
        }];
    }
    return _seletedComponent;
}

- (void)seletedZTC
{
    if (self.workConfigSeleteds.count == 0)
    {
        return;
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor clearColor];
    [window addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(window);
    }];
    
    TableSeletedCompent *tableSeletedCompent = [[TableSeletedCompent alloc] initWithArray:self.workConfigSeleteds];
    WeakSelf(self)
    [tableSeletedCompent.subject subscribeNext:^(id  _Nullable x) {
        weakself.ztcId = weakself.workConfigs[[x intValue]].workId;
        weakself.seletedComponent.label.text = weakself.workConfigs[[x intValue]].name;
        [weakself requestData];
    }];
    [window addSubview:tableSeletedCompent];
    [tableSeletedCompent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-16);
        make.top.equalTo(self.seletedComponent.mas_bottom);
        make.width.equalTo(100);
        make.height.equalTo(40 * self.workConfigSeleteds.count);
    }];
    WeakSelf(backView)
    [backView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakbackView removeFromSuperview];
        [tableSeletedCompent removeFromSuperview];
    }];
}

- (void)getManageData
{
    WeakSelf(self)
    GetRequest *manageRequest = [[GetRequest alloc] initWithRequestUrl:listadmin argument:@{@"projectId":self.projectId}];
    [manageRequest startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            weakself.manageArr = [OnWorkLilstResponse mj_objectArrayWithKeyValuesArray:result[@"data"]];
            OnWorkLilstResponse *allResponse = [OnWorkLilstResponse new];
            allResponse.name = @"全部";
            allResponse.tenantId = @"";
            [weakself.manageArr insertObject:allResponse atIndex:0];
            weakself.manageSeletedArr = [[self.manageArr.rac_sequence map:^id _Nullable(OnWorkLilstResponse * _Nullable value) {
                return value.name;
            }] array];
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {

    }];
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
        [_tableView registerClass:OrderStatisticsNomalCell.class forCellReuseIdentifier:NSStringFromClass(OrderStatisticsNomalCell.class)];
        [_tableView registerClass:OrderStatisticsErrorCell.class forCellReuseIdentifier:NSStringFromClass(OrderStatisticsErrorCell.class)];
        [_tableView registerClass:OrderStatisticsDeleteCell.class forCellReuseIdentifier:NSStringFromClass(OrderStatisticsDeleteCell.class)];
        [_tableView registerClass:OrderStatisticsErrorDeleteCell.class forCellReuseIdentifier:NSStringFromClass(OrderStatisticsErrorDeleteCell.class)];
    }
    return _tableView;
}

- (UILabel *)countLb
{
    if (!_countLb)
    {
        _countLb = [UILabel labelWithText:@"共计：0"
                                     font:[UIFont systemFontOfSize:font_14]
                                textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                alignment:NSTextAlignmentLeft];
    }
    return _countLb;
}

- (void)getData:(NSString *)deleteFlag
    isException:(NSString *)isException
           isZd:(NSString *)isZd
{
    self.deleteFlag = deleteFlag;
    self.isException = isException;
    self.isZd = isZd;
    [self requestData];
}

- (void)requestData
{
    WeakSelf(self)
    [SVProgressHUD show];
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:workerorderquery argument:@{@"startTime":self.startTime,
                                                                                             @"endTime":self.endTime,
                                                                                             @"deleteFlag":self.deleteFlag,
                                                                                             @"isException":self.isException,
                                                                                             @"isZd":self.isZd,
                                                                                             @"ztcId":self.type == ZCField ? self.ztcId : @"",
                                                                                             @"tenantId":self.tenantId,
                                                                                             @"projectId":self.projectId,
                                                                                             @"plateNumber":self.plateNumber}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            weakself.source = [WorkOrderDetailResponse mj_objectArrayWithKeyValuesArray:result[@"data"]];
            weakself.tableView.emptyLb.hidden = weakself.source.count > 0;
            weakself.countLb.text = [NSString stringWithFormat:@"共计：%ld",weakself.source.count];
            weakself.countLb.hidden = weakself.source.count == 0;
            [weakself.tableView reloadData];
        }
        [SVProgressHUD dismiss];
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        [SVProgressHUD dismiss];
    }];
}

- (GLTextField *)searchBar
{
    if (!_searchBar)
    {
        _searchBar = [GLTextField new];
        [_searchBar customerPlaceholder:@"请输入车牌搜索"];
        _searchBar.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
    }
    return _searchBar;
}

- (UILabel *)timeLb
{
    if (!_timeLb)
    {
        _timeLb = [UILabel labelWithText:[NSString stringWithFormat:@"%@(24小时)",[Tools dateToString:[NSDate date] withDateFormat:@"yyyy-MM-dd"]]
                                    font:[UIFont systemFontOfSize:13]
                               textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                               alignment:NSTextAlignmentCenter];
    }
    return _timeLb;
}

- (void)customerUI
{
    UIView *firstGray = [UIView new];
    firstGray.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
    [self.view addSubview:firstGray];
    [firstGray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(10);
    }];
    
    UIView *dateBack = [UIView new];
    dateBack.userInteractionEnabled = YES;
    WeakSelf(self)
    [dateBack jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        DateSeletedVC *dateSeletedVC = [DateSeletedVC new];
        [dateSeletedVC.subject subscribeNext:^(id  _Nullable x) {
            weakself.startTime = x[@"startTime"];
            weakself.endTime = x[@"endTime"];
            weakself.timeLb.text = x[@"timeName"];
            [weakself requestData];
        }];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dateSeletedVC];
        [weakself presentViewController:nav animated:YES completion:nil];
    }];
    dateBack.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:dateBack];
    [dateBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(40);
        make.top.equalTo(firstGray.mas_bottom);
    }];
    
    [dateBack addSubview:self.timeLb];
    [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(dateBack);
    }];
    
    UIImageView *leftImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"manage_detail_time_left"]];
    [dateBack addSubview:leftImg];
    [leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(dateBack);
        make.right.equalTo(self.timeLb.mas_left).offset(-6);
        make.width.height.equalTo(14);
    }];
    
    UIImageView *downImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"manage_detail_time_select"]];
    [dateBack addSubview:downImg];
    [downImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(dateBack);
        make.left.equalTo(self.timeLb.mas_right).offset(6);
        make.width.equalTo(9);
        make.height.equalTo(9.0/13 * 9);
    }];
    
    UIView *secondGray = [UIView new];
    secondGray.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
    [self.view addSubview:secondGray];
    [secondGray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(10);
        make.top.equalTo(dateBack.mas_bottom);
    }];
    
    UIView *selectView = [UIView new];
    selectView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:selectView];
    [selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(110);
        make.left.right.equalTo(self.view);
        make.top.equalTo(secondGray.mas_bottom);
    }];
    
    SeletedItemCompent *itemCompent = [[SeletedItemCompent alloc] initWithArray:@[@"全部",@"渣土场",@"自倒",@"异常",@"已删除"]];
    [itemCompent.subject subscribeNext:^(id  _Nullable x) {
        weakself.type = [x intValue];
        [weakself reloadData:weakself.type];
        weakself.seletedComponent.hidden = weakself.type != ZCField;
    }];
    [selectView addSubview:itemCompent];
    [itemCompent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(selectView);
        make.height.equalTo(44);
    }];
    
    UIView *searchBack = [UIView new];
    searchBack.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
    [selectView addSubview:searchBack];
    [searchBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(itemCompent.mas_bottom).offset(12);
        make.left.equalTo(selectView).offset(16);
        make.right.equalTo(selectView).offset(-16);
        make.bottom.equalTo(selectView.mas_bottom).offset(-12);
    }];
    
    [selectView addSubview:self.searchBar];
    [_searchBar.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        weakself.plateNumber = (NSString *)x;
        [weakself requestData];
    }];
    [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(searchBack);
        make.left.equalTo(searchBack).offset(16);
        make.right.equalTo(searchBack).offset(-16);
    }];
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selectView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)reloadData:(StatisticsType)type
{
    switch (type) {
        case All:
        {
            [self getData:@"" isException:@"" isZd:@""];
            break;
        }
        case ZCField:
        {
            [self getData:@"" isException:@"" isZd:@"FALSE"];
            break;
        }
        case ZFall:
        {
            [self getData:@"" isException:@"" isZd:@"TRUE"];
            break;
        }
        case Error:
        {
            [self getData:@"" isException:@"TRUE" isZd:@""];
            break;
        }
        case Deleted:
        {
            [self getData:@"DELETED" isException:@"" isZd:@""];
            break;
        }
        default:
            break;
    }
}

- (UIView *)headerView
{
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, kScreenWidth, 50);
    [view addSubview:self.countLb];
    [_countLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(16);
        make.centerY.equalTo(view);
    }];
    
    [view addSubview:self.seletedComponent];
    [_seletedComponent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-16);
        make.height.equalTo(24);
        make.centerY.equalTo(self.countLb);
    }];
    return view;
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    WorkOrderDetailResponse *response = self.source[indexPath.row];
    if ([response.isException isEqualToString:@"TRUE"])
    {
        if ([response.deleteFlag isEqualToString:@"DELETED"])
        {
            height = 232;
        }
        else
        {
            height = 162;
        }
    }
    else
    {
        if ([response.deleteFlag isEqualToString:@"DELETED"])
        {
            height = 208;
        }
        else
        {
            height = 142;
        }
    }
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.source.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    WorkOrderDetailResponse *response = self.source[indexPath.row];
    if ([response.isException isEqualToString:@"TRUE"])
    {
        if ([response.deleteFlag isEqualToString:@"DELETED"])
        {
            cell = [OrderStatisticsErrorDeleteCell cellWithCollectionView:tableView];
            [(OrderStatisticsErrorDeleteCell *)cell loadViewWithModel:response];
        }
        else
        {
            cell = [OrderStatisticsErrorCell cellWithCollectionView:tableView];
            [(OrderStatisticsErrorCell *)cell loadViewWithModel:response];
        }
    }
    else
    {
        if ([response.deleteFlag isEqualToString:@"DELETED"])
        {
            cell = [OrderStatisticsDeleteCell cellWithCollectionView:tableView];
            [(OrderStatisticsDeleteCell *)cell loadViewWithModel:response];
        }
        else
        {
            cell = [OrderStatisticsNomalCell cellWithCollectionView:tableView];
            [(OrderStatisticsNomalCell *)cell loadViewWithModel:response];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorkOrderDetailResponse *response = self.source[indexPath.row];
    WorkOrderDetailVC *workOrderDetailVC = [WorkOrderDetailVC new];
    workOrderDetailVC.orderId = response.orderNo;
    workOrderDetailVC.projectId = self.projectId;
    WeakSelf(self)
    [workOrderDetailVC.subject subscribeNext:^(id  _Nullable x) {
        [weakself requestData];
    }];
    [self.navigationController pushViewController:workOrderDetailVC animated:YES];
}

@end
