//
//  WorkDataDetailVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/18.
//

#import "WorkDataDetailVC.h"
#import "WorkDataDetailHeaderView.h"
#import "WorkDataDetailSectionHeaderView.h"
#import "StatisticsResponse.h"
#import "DateSeletedVC.h"
#import "WorkDataDetailContantCell.h"
#import "DatePointManage.h"
@interface WorkDataDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) StatisticsResponse *statisticsResponse;
@property (nonatomic, strong) WorkDataDetailHeaderView *workDataDetailHeaderView;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, assign) int currentIndex;
@property (nonatomic, strong) InnerMobileResponse *currentResponse;
@property (nonatomic, assign) BOOL isFirstLoad;
@end

@implementation WorkDataDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"项目统计详情";
    self.currentIndex = 0;
    self.isFirstLoad = YES;
    self.startTime = [NSString stringWithFormat:@"%@ 00:00:00",[Tools dateToString:[NSDate date] withDateFormat:@"yyyy-MM-dd"]];
    self.endTime = [NSString stringWithFormat:@"%@ 23:59:59",[Tools dateToString:[NSDate date] withDateFormat:@"yyyy-MM-dd"]];
    [self customerUI];
    [self getData];
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [self headerView];
        _tableView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:WorkDataDetailContantCell.class forCellReuseIdentifier:NSStringFromClass(WorkDataDetailContantCell.class)];
    }
    return _tableView;
}

- (void)getData
{
    @weakify(self);
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:reportprojectstatistics
                                                        argument:@{@"startTime":self.startTime,
                                                                     @"endTime":self.endTime}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        @strongify(self);
        if (success)
        {
            self.statisticsResponse = [StatisticsResponse mj_objectWithKeyValues:result[@"data"]];
            if (self.statisticsResponse.innerMobileProjectStatistics.count > 0)
            {
                self.currentResponse = self.statisticsResponse.innerMobileProjectStatistics[self.currentIndex];
                [[DatePointManage shareInstance] getPointDate:self.currentResponse.projectId];
            }
            [self.workDataDetailHeaderView loadViewWithModel:self.statisticsResponse isFirstLoad:self.isFirstLoad];
            [self.workDataDetailHeaderView loadViewWithInnerModel:self.currentResponse];
            self.isFirstLoad = NO;
            [self.tableView reloadData];
        }
        
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

- (void)customerUI
{
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (WorkDataDetailHeaderView *)workDataDetailHeaderView
{
    if (!_workDataDetailHeaderView)
    {
        _workDataDetailHeaderView = [WorkDataDetailHeaderView new];
    }
    return _workDataDetailHeaderView;
}

- (UIView *)headerView
{
    WeakSelf(self)
    [self.workDataDetailHeaderView.subject subscribeNext:^(id  _Nullable x) {
        weakself.currentIndex = [x intValue];
        weakself.currentResponse = weakself.statisticsResponse.innerMobileProjectStatistics[weakself.currentIndex];
        [[DatePointManage shareInstance] getPointDate:weakself.currentResponse.projectId];
        [weakself.workDataDetailHeaderView loadViewWithInnerModel:weakself.currentResponse];
        [weakself.tableView reloadData];
    }];
   
    
    self.workDataDetailHeaderView.frame = CGRectMake(0, 0, kScreenWidth, 312);
    [self.workDataDetailHeaderView.myDataLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        DateSeletedVC *dateSeletedVC = [DateSeletedVC new];
        [dateSeletedVC.subject subscribeNext:^(id  _Nullable x) {
            weakself.startTime = x[@"startTime"];
            weakself.endTime = x[@"endTime"];
            weakself.workDataDetailHeaderView.myDataLb.text = x[@"timeName"];
            [weakself getData];
        }];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dateSeletedVC];
        [weakself presentViewController:nav animated:YES completion:nil];
    }];
    return self.workDataDetailHeaderView;
}

- (UIView *)sectionHeaderView:(NSInteger)section
{
    WorkDataDetailSectionHeaderView *view = [WorkDataDetailSectionHeaderView new];
    [view loadViewWithCustomModel:self.currentResponse.customtcStatistics
                  workerTypeModel:self.currentResponse.workerTypeStatistics
                            isZTC:section == 0];
    return view;
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (self.currentResponse.customtcStatistics.details.count > 0)
        {
            return 40 * self.currentResponse.customtcStatistics.details.count;
        }
        return 200;
    }
    if (self.currentResponse.workerTypeStatistics.details.count > 0)
    {
        if (self.currentResponse.workerTypeStatistics.details.count == 1)
        {
            WorkerItemType *firstType = self.currentResponse.workerTypeStatistics.details.firstObject;
            return (firstType.details.count + 1) * 40 + 20;
        }
        else
        {
            WorkerItemType *firstType = self.currentResponse.workerTypeStatistics.details.firstObject;
            WorkerItemType *lastType = self.currentResponse.workerTypeStatistics.details.lastObject;
            return (firstType.details.count + lastType.details.count + 2) * 40 + 40;
        }
    }
    return 200;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 56;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self sectionHeaderView:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorkDataDetailContantCell *cell = [WorkDataDetailContantCell cellWithCollectionView:tableView];
    if (indexPath.section == 0)
    {
        [cell loadViewWithType:YES ztcArr:self.currentResponse.customtcStatistics.details classArr:[NSArray array]];
    }
    else
    {
        [cell loadViewWithType:NO ztcArr:[NSArray array] classArr:self.currentResponse.workerTypeStatistics.details];
    }
    return cell;
}

@end
