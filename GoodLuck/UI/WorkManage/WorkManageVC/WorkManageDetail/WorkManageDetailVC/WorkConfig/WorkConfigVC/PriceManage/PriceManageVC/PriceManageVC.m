//
//  PriceManageVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/27.
//

#import "PriceManageVC.h"
#import "PriceManageCell.h"
#import "PriceManageHeaderView.h"
#import "PriceManageFooterView.h"
#import "WorkDetailPriceResponse.h"
#import "CarSizeModel.h"
#import "WorkConfigManageResponse.h"
@interface PriceManageVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<WorkDetailPrceHeaderResponse *> *source;
@property (nonatomic, strong) NSMutableArray<CarSizeModel *> *carSizeArr;
@property (nonatomic, strong) NSArray<WorkConfigManageResponse *> *ztcArr;
@property (nonatomic, strong) NSArray<WorkConfigManageResponse *> *soilTypeArr;
@end

@implementation PriceManageVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"价格配置";
    self.view.backgroundColor = [UIColor whiteColor];
    self.carSizeArr = [NSMutableArray arrayWithCapacity:0];
    WorkDetailPrceHeaderResponse *ztcResponse = [WorkDetailPrceHeaderResponse new];
    ztcResponse.headerName = @"渣土场价格添加";
    ztcResponse.footerName = @"请选择渣土场车斗方(m3)";
    ztcResponse.soilType = @"渣土场";
    ztcResponse.contentDatas = [NSMutableArray arrayWithCapacity:0];
    
    WorkDetailPrceHeaderResponse *zdResponse = [WorkDetailPrceHeaderResponse new];
    zdResponse.headerName = @"自倒价格添加";
    zdResponse.footerName = @"请选择自倒车斗方(m3)";
    zdResponse.soilType = @"土类型";
    zdResponse.contentDatas = [NSMutableArray arrayWithCapacity:0];
    
    self.source = @[ztcResponse,zdResponse];
    [self customerUI];
    [self getData];
    /// 获取所有价格
    [self getAllPrice];
    /// 获取所有土类型
    [self getSoilType];
    /// 获取所有渣土场
    [self getZTCData];
}

- (void)getAllPrice
{
    WeakSelf(self)
    GetRequest *carManageRequest = [[GetRequest alloc] initWithRequestUrl:bodysizeall argument:@{}];
    [carManageRequest startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            NSArray *arry = result[@"data"];
            for (int i = 0; i < arry.count; i++)
            {
                NSString *name = [NSString stringWithFormat:@"%@",arry[i]];
                CarSizeModel *model = [[CarSizeModel alloc] initWithName:name isSeleted:NO size:name];
                [weakself.carSizeArr addObject:model];
            }
        }
        
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

- (void)getSoilType
{
    WeakSelf(self)
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:tlxquery argument:@{@"projectId":self.projectId}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            weakself.soilTypeArr = [WorkConfigManageResponse mj_objectArrayWithKeyValuesArray:result[@"data"]];
        }
        
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

- (void)getZTCData
{
    WeakSelf(self)
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:ztcquery argument:@{@"projectId":self.projectId}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            weakself.ztcArr = [WorkConfigManageResponse mj_objectArrayWithKeyValuesArray:result[@"data"]];
        }
        
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

- (void)getData
{
    WeakSelf(self)
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:pricequery argument:@{@"isZd":@"FALSE",@"projectId":self.projectId}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            NSMutableArray *prices = [WorkDetailPriceResponse mj_objectArrayWithKeyValuesArray:result[@"data"]];
            weakself.source.firstObject.contentDatas = prices;
            [weakself.tableView reloadData];
        }
        
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
    
    GetRequest *zdRequest = [[GetRequest alloc] initWithRequestUrl:pricequery argument:@{@"isZd":@"TRUE",@"projectId":self.projectId}];
    [zdRequest startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            NSMutableArray *prices = [WorkDetailPriceResponse mj_objectArrayWithKeyValuesArray:result[@"data"]];
            weakself.source.lastObject.contentDatas = prices;
            [weakself.tableView reloadData];
        }
        
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:PriceManageCell.class forCellReuseIdentifier:NSStringFromClass(PriceManageCell.class)];
    }
    return _tableView;
}


- (void)customerUI
{
    UIView *footView = [UIView new];
    footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footView];
    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(60);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
    
    UILabel *saveLb = [UILabel labelWithText:@"保存"
                                        font:[UIFont systemFontOfSize:font_14]
                                   textColor:[UIColor whiteColor]
                                   alignment:NSTextAlignmentCenter];
    saveLb.userInteractionEnabled = YES;
    WeakSelf(self)
    [saveLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself saveData];
    }];
    saveLb.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
    saveLb.layer.cornerRadius = 22;
    saveLb.layer.masksToBounds = YES;
    [footView addSubview:saveLb];
    [saveLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(footView);
        make.left.equalTo(footView).offset(30);
        make.right.equalTo(footView).offset(-30);
        make.height.equalTo(44);
    }];
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(footView.mas_top);
    }];
}

- (void)saveData
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    for (WorkDetailPrceHeaderResponse *response in self.source)
    {
        for (WorkDetailPriceResponse *priceResponse in response.contentDatas)
        {
            NSDictionary *dic = @{@"bodySize":priceResponse.bodySize,
                                  @"price":priceResponse.price,
                                  @"projectId":self.projectId,
                                  @"tlxId":[Tools isEmpty:priceResponse.tlxId] ? @"" : priceResponse.tlxId,
                                  @"ztcId":[Tools isEmpty:priceResponse.ztcId] ? @"-1" : priceResponse.ztcId
            };
            [array addObject:dic];
        }
    }
    WeakSelf(self)
    PostRequest *zdRequest = [[PostRequest alloc] initWithRequestUrl:pricesavebatch argument:array];
    [zdRequest startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"添加成功"];
            [weakself.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

- (void)handleZTCPrcie:(NSString *)bodySize
{
    if (self.ztcArr.count == 0)
    {
        return;
    }
    NSMutableArray *prices = self.source.firstObject.contentDatas;
    BOOL hasPrice = NO;
    for (WorkDetailPriceResponse *response in prices)
    {
        if ([response.bodySize isEqualToString:bodySize])
        {
            hasPrice = YES;
            break;
        }
    }
    
    if (hasPrice)
    {
        return;
    }
    
    for (WorkConfigManageResponse *work in self.ztcArr)
    {
        WorkDetailPriceResponse *response = [WorkDetailPriceResponse new];
        response.ztcName = work.name;
        response.ztcId = work.workId;
        response.price = @"0";
        response.bodySize = bodySize;
        [prices addObject:response];
    }
    [self.tableView reloadData];
    
}

- (void)handleZDPrice:(NSString *)bodySize
{
    if (self.soilTypeArr.count == 0)
    {
        return;
    }
    NSMutableArray *prices = self.source.lastObject.contentDatas;
    BOOL hasPrice = NO;
    for (WorkDetailPriceResponse *response in prices)
    {
        if ([response.bodySize isEqualToString:bodySize])
        {
            hasPrice = YES;
            break;
        }
    }
    
    if (hasPrice)
    {
        return;
    }
    
    for (WorkConfigManageResponse *work in self.soilTypeArr)
    {
        WorkDetailPriceResponse *response = [WorkDetailPriceResponse new];
        response.tlxName = work.name;
        response.tlxId = work.workId;
        response.price = @"0";
        response.bodySize = bodySize;
        [prices addObject:response];
    }
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    WorkDetailPrceHeaderResponse *response = self.source[section];
    return response.contentDatas.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.source.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    PriceManageHeaderView *headerView = [PriceManageHeaderView new];
    [headerView setViewWithName:self.source[section].headerName
                           type:self.source[section].soilType];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 90;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    PriceManageFooterView *footView = [PriceManageFooterView new];
    footView.nameLb.text = self.source[section].soilType;
    WeakSelf(self)
    [footView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        if (weakself.carSizeArr.count == 0)
        {
            return;
        }
        [Tools showAddSoilCompent:weakself.carSizeArr name:self.source[section].footerName back:^(NSString * _Nonnull result) {
            if (section == 0)
            {
                [weakself handleZTCPrcie:result];
            }
            else
            {
                [weakself handleZDPrice:result];
            }
        }];
    }];
    return footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PriceManageCell *cell = [PriceManageCell cellWithCollectionView:tableView];
    WeakSelf(self)
    [cell.closeImg jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself.source[indexPath.section].contentDatas removeObjectAtIndex:indexPath.row];
        [weakself.tableView reloadData];
    }];
    WorkDetailPriceResponse *response = weakself.source[indexPath.section].contentDatas[indexPath.row];
    [cell loadViewWithModel:response change:^(NSString *prie) {
        response.price = prie;
    }];
    return cell;
}

@end
