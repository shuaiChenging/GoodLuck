//
//  WorkConfigVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/9.
//

#import "WorkConfigVC.h"
#import "WorkConfigCell.h"
#import "WorkConfigSelectedCell.h"
#import "WorkConfigSwitchCell.h"
#import "WorkConfigModel.h"
#import "WorkConfigManageVC.h"
#import "DischargedModelVC.h"
#import "OrderDeleteVC.h"
#import "OrderChangeVC.h"
#import "PriceManageVC.h"
#import "AddWorkPlaceVC.h"
#import "OrderStatisticsVC.h"
#import "PrintNumberVC.h"
#import "PrintNumberModel.h"
#import "LoginInfoManage.h"
@interface WorkConfigVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<WorkConfigModel *> *source;
@end

@implementation WorkConfigVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"工地配置";
    [self configData];
    [self customerUI];
}

- (void)configData
{
    NSString *seletedModel = [DDDataStorageManage userDefaultsGetObjectWithKey:MODELTYPE];
    NSString *name = @"不打印";
    switch ([LoginInfoManage shareInstance].workConfigResponse.pointCount) {
        case 1:
        {
            name = @"一联";
            break;
        }
        case 2:
        {
            name = @"二联";
            break;
        }
        case 3:
        {
            name = @"三联";
            break;
        }
        case 4:
        {
            name = @"四联";
            break;
        }
        default:
            break;
    }
    WorkConfigModel *baseModel = [WorkConfigModel new];
    baseModel.header = @"工地基本配置";
    baseModel.content = @[[[WorkConfigDetailModel alloc] initWithType:Default settingType:ZtcManage name:@"渣土场管理" describe:nil],
                          [[WorkConfigDetailModel alloc] initWithType:Default settingType:TlxManage name:@"土类型管理" describe:nil],
                          [[WorkConfigDetailModel alloc] initWithType:Default settingType:PriceManage name:@"价格管理" describe:nil],
                          [[WorkConfigDetailModel alloc] initWithType:Default settingType:CarTeamManage name:@"车队管理" describe:nil],
                          [[WorkConfigDetailModel alloc] initWithType:Seleted settingType:TravelModel name:@"放行模式"
                                                             describe:[Tools isEmpty:seletedModel] ? @"在线" : seletedModel]];
    
    WorkConfigModel *manageModel = [WorkConfigModel new];
    manageModel.header = @"工单管理";
    manageModel.content = @[[[WorkConfigDetailModel alloc] initWithType:Default settingType:WorkOrderDelete name:@"工单删除" describe:nil],
                            [[WorkConfigDetailModel alloc] initWithType:Default settingType:WorkOrderChange name:@"工单修改" describe:nil]];
    
    WorkConfigModel *configModel = [WorkConfigModel new];
    configModel.header = @"旅行配置";
    configModel.content = @[[[WorkConfigDetailModel alloc] initWithType:DSwitch settingType:CarCardSetting name:@"新车牌记住上一车配置" describe:@"（车斗、渣土场、土类型、车队）"],
                            [[WorkConfigDetailModel alloc] initWithType:DSwitch settingType:CarCardAlert name:@"车牌识别辅助提醒" describe:@"（根据历史放行数据提醒是否可能出错）"],
                            [[WorkConfigDetailModel alloc] initWithType:Seleted settingType:PrintNumber name:@"默认打印联数"
                                                               describe:name]];
    
    WorkConfigModel *otherModel = [WorkConfigModel new];
    otherModel.header = @"其他";
    otherModel.content = @[[[WorkConfigDetailModel alloc] initWithType:Default settingType:WorkInfoEdit name:@"工地信息编辑" describe:nil]];
    
    self.source = @[baseModel,manageModel,configModel,otherModel];
    
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:WorkConfigCell.class forCellReuseIdentifier:NSStringFromClass(WorkConfigCell.class)];
        [_tableView registerClass:WorkConfigSelectedCell.class forCellReuseIdentifier:NSStringFromClass(WorkConfigSelectedCell.class)];
        [_tableView registerClass:WorkConfigSwitchCell.class forCellReuseIdentifier:NSStringFromClass(WorkConfigSwitchCell.class)];
    }
    return _tableView;
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
    WorkConfigModel *configModel = self.source[indexPath.section];
    WorkConfigDetailModel *model = configModel.content[indexPath.row];
    if (model.type == DSwitch)
    {
        return 70;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
    WorkConfigModel *model = self.source[section];
    UILabel *label = [UILabel labelWithText:model.header
                                       font:[UIFont systemFontOfSize:font_14]
                                  textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                  alignment:NSTextAlignmentLeft];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(16);
        make.centerY.equalTo(view);
    }];
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.source.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    WorkConfigModel *model = self.source[section];
    return model.content.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    WorkConfigModel *configModel = self.source[indexPath.section];
    WorkConfigDetailModel *model = configModel.content[indexPath.row];
    switch (model.type) {
        case Default:
        {
            cell = [WorkConfigCell cellWithCollectionView:tableView];
            [(WorkConfigCell *)cell loadViewWithModel:model];
            break;
        }
        case Seleted:
        {
            cell = [WorkConfigSelectedCell cellWithCollectionView:tableView];
            [(WorkConfigSelectedCell *)cell loadViewWithModel:model];
            break;
        }
        case DSwitch:
        {
            cell = [WorkConfigSwitchCell cellWithCollectionView:tableView];
            [(WorkConfigSwitchCell *)cell loadViewWithModel:model projectId:self.projectId];
            break;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorkConfigModel *configModel = self.source[indexPath.section];
    WorkConfigDetailModel *model = configModel.content[indexPath.row];
    
    switch (model.settingType) {
        case ZtcManage:
        case TlxManage:
        case CarTeamManage:
        {
            [self gotoWorkConfigManageVC:model.settingType projectId:self.projectId name:model.name];
            break;
        }
        case PriceManage:
        {
            PriceManageVC *priceManageVC = [PriceManageVC new];
            priceManageVC.projectId = self.projectId;
            [self.navigationController pushViewController:priceManageVC animated:YES];
            break;
        }
        case TravelModel:
        {
            [self gotoDischargedModelVC:model];
            break;
        }
        case WorkOrderDelete:
        {
            OrderDeleteVC *orderDeleteVC = [OrderDeleteVC new];
            orderDeleteVC.projectId = self.projectId;
            [self.navigationController pushViewController:orderDeleteVC animated:YES];
            break;
        }
        case WorkOrderChange:
        {
            OrderStatisticsVC *orderStatisticsVC = [OrderStatisticsVC new];
            orderStatisticsVC.projectId = self.projectId;
            [self.navigationController pushViewController:orderStatisticsVC animated:YES];
            break;
        }
        case WorkInfoEdit:
        {
            AddWorkPlaceVC *addWorkPlace = [AddWorkPlaceVC new];
            addWorkPlace.title = @"工地信息详情";
            [addWorkPlace loadViewWithProjectId:self.projectId];
            [self.navigationController pushViewController:addWorkPlace animated:YES];
            break;
        }
        case PrintNumber:
        {
            WeakSelf(self)
            PrintNumberVC *printNumberVC = [PrintNumberVC new];
            [printNumberVC.subject subscribeNext:^(id  _Nullable x) {
                PrintNumberModel *printModel = (PrintNumberModel *)x;
                [weakself reloadPrintData:printModel];
            }];
            [self presentViewController:printNumberVC animated:YES completion:nil];
            break;
        }
        default:
            break;
    }
}

- (void)reloadPrintData:(PrintNumberModel *)printModel
{
    WorkConfigModel *model = self.source[2];
    WorkConfigDetailModel *detailModel = model.content[2];
    detailModel.describe = printModel.name;
    [self saveConfig:printModel.name];
    [self.tableView reloadData];
}

- (void)saveConfig:(NSString *)name
{
    int pointCount = 0;
    if ([name isEqualToString:@"一联"])
    {
        pointCount = 1;
    }
    else if ([name isEqualToString:@"二联"])
    {
        pointCount = 2;
    }
    else if ([name isEqualToString:@"三联"])
    {
        pointCount = 3;
    }
    else if ([name isEqualToString:@"四联"])
    {
        pointCount = 4;
    }
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:configedit argument:@{@"key":@"pointCount",@"value":@(pointCount),@"projectId":self.projectId}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            [LoginInfoManage shareInstance].workConfigResponse.pointCount = pointCount;
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

- (void)gotoDischargedModelVC:(WorkConfigDetailModel *)model
{
    DischargedModelVC *dischargedModelVC = [DischargedModelVC new];
    dischargedModelVC.name = model.describe;
    WeakSelf(self)
    [dischargedModelVC.subject subscribeNext:^(id  _Nullable x) {
        model.describe = (NSString *)x;
        [weakself.tableView reloadData];
    }];
    [self.navigationController pushViewController:dischargedModelVC animated:YES];
}

- (void)gotoWorkConfigManageVC:(WorkSettingType )settingType
                     projectId:(NSString *)projectId
                          name:(NSString *)name
{
    WorkConfigManageVC *workConfigManageVC = [WorkConfigManageVC new];
    workConfigManageVC.settingType = settingType;
    workConfigManageVC.projectId = projectId;
    workConfigManageVC.title = name;
    [self.navigationController pushViewController:workConfigManageVC animated:YES];
}

@end
