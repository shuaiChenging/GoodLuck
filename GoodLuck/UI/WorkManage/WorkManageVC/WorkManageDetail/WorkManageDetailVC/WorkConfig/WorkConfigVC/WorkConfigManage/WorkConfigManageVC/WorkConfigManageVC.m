//
//  WorkConfigManageVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/9.
//

#import "WorkConfigManageVC.h"
#import "WorkManageHeaderView.h"
#import "WorkManageCell.h"
#import "WorkConfigManageResponse.h"
@interface WorkConfigManageVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) WorkManageHeaderView *headerView;
@property (nonatomic, strong) GLTableView *tableView;
@property (nonatomic, strong) NSMutableArray *source;
@property (nonatomic, assign) BOOL isEdit;
@end

@implementation WorkConfigManageVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.source = [NSMutableArray arrayWithCapacity:0];
    self.isEdit = NO;
    [self customerUI];
    [self getData];
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[GLTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:WorkManageCell.class forCellReuseIdentifier:NSStringFromClass(WorkManageCell.class)];
    }
    return _tableView;
}

- (void)getData
{
    NSString *url = @"";
    switch (self.settingType) {
        case ZtcManage:
        {
            url = ztcquery;
            break;
        }
        case TlxManage:
        {
            url = tlxquery;
            break;
        }
        case CarTeamManage:
        {
            url = fleetquery;
            break;
        }
        default:
            break;
    }
    WeakSelf(self)
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:url argument:@{@"projectId":self.projectId}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            NSArray *array = [WorkConfigManageResponse mj_objectArrayWithKeyValuesArray:result[@"data"]];
            weakself.tableView.emptyLb.hidden = array.count > 0;
            weakself.source = [Tools cutArry:2 array:array];
            [weakself.tableView reloadData];
        }
        
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

- (WorkManageHeaderView *)headerView
{
    if (!_headerView)
    {
        _headerView = [WorkManageHeaderView new];
    }
    return _headerView;
}

- (void)customerUI
{
    [self.view addSubview:self.headerView];
    switch (self.settingType) {
        case ZtcManage:
        {
            self.headerView.nameLb.text = @"渣土场名称";
            break;
        }
        case TlxManage:
        {
            self.headerView.nameLb.text = @"土类型名称";
            break;
        }
        case CarTeamManage:
        {
            self.headerView.nameLb.text = @"车队名称";
            break;
        }
        default:
            break;
    }
    WeakSelf(self)
    [[_headerView.addBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself addCarTeam];
    }];
    [[_headerView.editBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself edit];
    }];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(50);
    }];
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)edit
{
    self.isEdit = !self.isEdit;
    [_headerView.editBt setTitle:self.isEdit ? @"完成" : @"编辑" forState:UIControlStateNormal];
    for (NSArray *array in self.source)
    {
        for(WorkConfigManageResponse *response in array)
        {
            response.isSelected = self.isEdit;
        }
    }
    [self.tableView reloadData];
}

- (void)addCarTeam
{
    NSString *titleStr = @"";
    NSString *placeholderStr = @"";
    switch (self.settingType) {
        case ZtcManage:
        {
            titleStr = @"增加渣土厂";
            placeholderStr = @"请输入渣土厂名称";
            break;
        }
        case TlxManage:
        {
            titleStr = @"增加土类型";
            placeholderStr = @"请输入土类型";
            break;
        }
        case CarTeamManage:
        {
            titleStr = @"添加车队";
            placeholderStr = @"请输入车队名称";
            break;
        }
        default:
            break;
    }
    WeakSelf(self)
    [Tools addViewWithTitle:titleStr placeholder:placeholderStr textback:^(NSString *name) {
        [weakself requestCarTeam:name];
    }];
}

/// 删除车队
/// @param carId carId description
- (void)deleteCarTeam:(NSString *)carId
{
    NSString *url = @"";
    switch (self.settingType) {
        case ZtcManage:
        {
            url = ztcdelete;
            break;
        }
        case TlxManage:
        {
            url = tlxdelete;
            break;
        }
        case CarTeamManage:
        {
            url = fleetdelete;
            break;
        }
        
        default:
            break;
    }
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:url argument:@{@"id":carId}];
    WeakSelf(self)
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            [weakself getData];
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

/// 新增车队
/// @param name name description
- (void)requestCarTeam:(NSString *)name
{
    NSString *url = @"";
    switch (self.settingType) {
        case ZtcManage:
        {
            url = ztcsave;
            break;
        }
        case TlxManage:
        {
            url = tlxsave;
            break;
        }
        case CarTeamManage:
        {
            url = fleetsave;
            break;
        }
        default:
            break;
    }
    PostRequest *request = [[PostRequest alloc] initWithRequestUrl:url argument:@{@"projectId":self.projectId,@"name":name}];
    WeakSelf(self)
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            [weakself getData];
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.source.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorkManageCell *cell = [WorkManageCell cellWithCollectionView:tableView];
    WeakSelf(self)
    cell.manageDelete = ^(NSString *workId) {
        [weakself deleteCarTeam:workId];
    };
    [cell loadViewWithArray:self.source[indexPath.row]];
    return cell;
}

@end
