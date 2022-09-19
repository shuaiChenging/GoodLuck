//
//  OrderDeleteVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/19.
//

#import "OrderDeleteVC.h"
#import "OrderDeleteCellNormal.h"
#import "SeletedItemCompent.h"
#import "OrderDeleteCellDeleted.h"
#import "WorkOrderDetailResponse.h"
#import "DateSeletedVC.h"
@interface OrderDeleteVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) GLTableView *tableView;
@property (nonatomic, strong) UILabel *timeLb;
@property (nonatomic, strong) GLTextField *searchBar;
@property (nonatomic, assign) OrderDeleteType type;
@property (nonatomic, copy) NSString *deleteFlag;
@property (nonatomic, copy) NSString *plateNumber;
@property (nonatomic, strong) NSArray<WorkOrderDetailResponse *> *source;

@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;

@property (nonatomic, strong) UILabel *countLb;
@end

@implementation OrderDeleteVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"工单统计流水";
    self.startTime = [NSString stringWithFormat:@"%@ 00:00:00",[Tools dateToString:[NSDate date] withDateFormat:@"yyyy-MM-dd"]];
    self.endTime = [NSString stringWithFormat:@"%@ 23:59:59",[Tools dateToString:[NSDate date] withDateFormat:@"yyyy-MM-dd"]];
    self.deleteFlag = @"";
    self.plateNumber = @"";
    [self customerUI];
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[GLTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [self headerView];
        _tableView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:OrderDeleteCellNormal.class forCellReuseIdentifier:NSStringFromClass(OrderDeleteCellNormal.class)];
        [_tableView registerClass:OrderDeleteCellDeleted.class forCellReuseIdentifier:NSStringFromClass(OrderDeleteCellDeleted.class)];
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
                                    font:[UIFont systemFontOfSize:14]
                               textColor:[UIColor blackColor]
                               alignment:NSTextAlignmentCenter];
    }
    return _timeLb;
}

- (void)requestData
{
    WeakSelf(self)
    [SVProgressHUD show];
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:workerorderquery argument:@{@"startTime":self.startTime,
                                                                                             @"endTime":self.endTime,
                                                                                             @"deleteFlag":self.deleteFlag,
                                                                                             @"isException":@"",
                                                                                             @"projectId":self.projectId,
                                                                                             @"isZd":@"",
                                                                                             @"tenantId":@"",
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
    
    SeletedItemCompent *itemCompent = [[SeletedItemCompent alloc] initWithArray:@[@"全部",@"已删除"]];
    [itemCompent.subject subscribeNext:^(id  _Nullable x) {
        weakself.type = [x intValue];
        weakself.deleteFlag = weakself.type == AllType ? @"" : @"DELETED";
        [weakself requestData];
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
    
    [searchBack addSubview:self.searchBar];
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

- (UIView *)headerView
{
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, kScreenWidth, 50);
    [view addSubview:self.countLb];
    [_countLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(16);
        make.centerY.equalTo(view);
    }];
    return view;
}

- (void)alertDeletedView:(NSString *)time carNo:(NSString *)carNo admin:(NSString *)admin orderId:(NSString *)orderId
{
    WeakSelf(self)
    [Tools showCancelAlert:time carNo:carNo admin:admin block:^(NSString * _Nonnull reason) {
        [weakself deleteRequest:reason orderId:orderId];
    }];
}

- (void)deleteRequest:(NSString *)reson orderId:(NSString *)orderId
{
    WeakSelf(self)
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:orderdelete argument:@{@"id":orderId,@"reason":reson}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"删除成功"];
            [weakself requestData];
        }
        [SVProgressHUD dismiss];
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    switch (self.type) {
        case AllType:
        {
            height = 142;
            break;
        }
        case DeletedType:
        {
            height = 162;
            break;
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
    switch (self.type) {
        case AllType:
        {
            cell = [OrderDeleteCellNormal cellWithCollectionView:tableView];
            [(OrderDeleteCellNormal *)cell loadViewWithModel:self.source[indexPath.row]];
            WeakSelf(self)
            [((OrderDeleteCellNormal *)cell).deleteLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
                [weakself alertDeletedView:self.source[indexPath.row].outReleaserTime
                                     carNo:self.source[indexPath.row].plateNumber
                                     admin:self.source[indexPath.row].updater
                                   orderId:self.source[indexPath.row].orderId];
            }];
            break;
        }
        case DeletedType:
        {
            cell = [OrderDeleteCellDeleted cellWithCollectionView:tableView];
            [(OrderDeleteCellDeleted *)cell loadViewWithModel:self.source[indexPath.row]];
            break;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
