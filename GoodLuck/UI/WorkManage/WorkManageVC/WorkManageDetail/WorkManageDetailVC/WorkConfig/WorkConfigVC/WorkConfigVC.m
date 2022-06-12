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
    WorkConfigModel *baseModel = [WorkConfigModel new];
    baseModel.header = @"工地基本配置";
    baseModel.content = @[[[WorkConfigDetailModel alloc] initWithType:Default settingType:ZtcManage name:@"渣土场管理" describe:nil],
                          [[WorkConfigDetailModel alloc] initWithType:Default settingType:TlxManage name:@"土类型管理" describe:nil],
                          [[WorkConfigDetailModel alloc] initWithType:Default settingType:PriceManage name:@"价格管理" describe:nil],
                          [[WorkConfigDetailModel alloc] initWithType:Default settingType:CarTeamManage name:@"车队管理" describe:nil],
                          [[WorkConfigDetailModel alloc] initWithType:Seleted settingType:TravelModel name:@"放行模式" describe:@"在线"]];
    
    WorkConfigModel *manageModel = [WorkConfigModel new];
    manageModel.header = @"工单管理";
    manageModel.content = @[[[WorkConfigDetailModel alloc] initWithType:Default settingType:WorkOrderDelete name:@"工单删除" describe:nil],
                            [[WorkConfigDetailModel alloc] initWithType:Default settingType:WorkOrderChange name:@"工单修改" describe:nil]];
    
    WorkConfigModel *configModel = [WorkConfigModel new];
    configModel.header = @"旅行配置";
    configModel.content = @[[[WorkConfigDetailModel alloc] initWithType:DSwitch settingType:CarCardSetting name:@"新车牌记住上一车配置" describe:@"（车斗、渣土场、土类型、车队）"],
                            [[WorkConfigDetailModel alloc] initWithType:DSwitch settingType:CarCardAlert name:@"车牌识别辅助提醒" describe:@"（根据历史放行数据提醒是否可能出错）"],
                            [[WorkConfigDetailModel alloc] initWithType:Seleted settingType:PrintNumber name:@"默认打印联数" describe:@"两联"]];
    
    WorkConfigModel *otherModel = [WorkConfigModel new];
    otherModel.header = @"其他";
    otherModel.content = @[[[WorkConfigDetailModel alloc] initWithType:Default settingType:WorkInfoEdit name:@"工地信息编辑" describe:nil],
                           [[WorkConfigDetailModel alloc] initWithType:Default settingType:WorkManage name:@"工地人员管理" describe:nil]];
    
    self.source = @[baseModel,manageModel,configModel,otherModel];
    
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
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
    view.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    WorkConfigModel *model = self.source[section];
    UILabel *label = [UILabel labelWithText:model.header
                                       font:[UIFont systemFontOfSize:14]
                                  textColor:[UIColor jk_colorWithHexString:@"#333333"]
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
            [(WorkConfigSwitchCell *)cell loadViewWithModel:model];
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
        default:
            break;
    }
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
