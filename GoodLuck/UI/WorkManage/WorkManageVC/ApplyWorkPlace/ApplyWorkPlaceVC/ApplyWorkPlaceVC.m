//
//  ApplyWorkPlaceVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/5.
//

#import "ApplyWorkPlaceVC.h"
#import "DLButton.h"
#import "AddressBookVC.h"
#import "BaseNavigationVC.h"
#import "ApplyWorkPlaceCell.h"
#import "ApplyWorkPlaceHeaderView.h"
#import "BossListResponse.h"
#import "BossInfoResponse.h"
@interface ApplyWorkPlaceVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL isHidden;
@property (nonatomic, strong) ApplyWorkPlaceHeaderView *applyWorkPlaceHeaderView;
@property (nonatomic, strong) NSArray *source;
@property (nonatomic, assign) int seletedRow;
@end

@implementation ApplyWorkPlaceVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"加入工地项目";
    self.view.backgroundColor = [UIColor whiteColor];
    self.isHidden = YES;
    self.seletedRow = 1000;
    [self customerUI];
}

- (ApplyWorkPlaceHeaderView *)applyWorkPlaceHeaderView
{
    if (!_applyWorkPlaceHeaderView)
    {
        _applyWorkPlaceHeaderView = [ApplyWorkPlaceHeaderView new];
    }
    return _applyWorkPlaceHeaderView;
}

- (void)customerUI
{
    UIView *bottomView = [UIView new];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(78);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];

    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [bottomView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(bottomView);
        make.height.equalTo(0.5);
    }];

    UIButton *button = [UIButton new];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [button setTitle:@"发送申请" forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.backgroundColor = [UIColor blueColor];
    [bottomView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(16);
        make.right.equalTo(bottomView).offset(-16);
        make.center.equalTo(bottomView);
        make.height.equalTo(46);
    }];
    
    WeakSelf(self)
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself applyWorkPlace];
    }];
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(bottomView.mas_top);
    }];
}

- (void)applyWorkPlace
{
    if (self.seletedRow == 1000)
    {
        [Tools showToast:@"请选择项目"];
        return;
    }
    NSString *describeStr = self.applyWorkPlaceHeaderView.contentInput.textField.text;
    if (describeStr.length == 0)
    {
        [Tools showToast:@"请输入备注"];
        return;
    }
    if (self.seletedRow < self.source.count)
    {
        BossListResponse *bossList = self.source[self.seletedRow];
        PostRequest *request = [[PostRequest alloc] initWithRequestUrl:projectapply argument:@{@"description":describeStr,@"projectId":bossList.projectId,@"role":@"BOSS"}];
        WeakSelf(self)
        [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
            if (success)
            {
                [weakself.subject sendNext:@"1"];
            }
            
        } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
            
        }];
    }
    
    
}

- (RACSubject *)subject
{
    if (!_subject)
    {
        _subject = [RACSubject new];
    }
    return _subject;
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [self tableHeaderView];
        _tableView.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:ApplyWorkPlaceCell.class forCellReuseIdentifier:NSStringFromClass(ApplyWorkPlaceCell.class)];
    }
    return _tableView;
}

- (UIView *)tableHeaderView
{
    WeakSelf(self)
    self.applyWorkPlaceHeaderView.frame = CGRectMake(0, 0, kScreenWidth, 146);
    [[self.applyWorkPlaceHeaderView.bossInput.textField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        if (x.length > 11)
        {
            x = [weakself.applyWorkPlaceHeaderView.bossInput.textField.text substringToIndex: 11];
            weakself.applyWorkPlaceHeaderView.bossInput.textField.text = x;
        }
        if (x.length == 11)
        {
            [weakself getBossInfo:x];
            [weakself getBossWorkPlaceList:x];
        }
        else
        {
            weakself.isHidden = YES;
            weakself.applyWorkPlaceHeaderView.frame = CGRectMake(0, 0, kScreenWidth, 146);
            [weakself.applyWorkPlaceHeaderView hiddenBossName];
            [weakself.tableView reloadData];
        }
    }];
    return _applyWorkPlaceHeaderView;
}

- (void)getBossInfo:(NSString *)phone
{
    WeakSelf(self)
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:listbyphone argument:@{@"phone":phone}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            NSArray *infos = [BossInfoResponse mj_objectArrayWithKeyValuesArray:result[@"data"]];
            if (infos.count > 0)
            {
                BossInfoResponse *info = infos.firstObject;
                if(![Tools isEmpty:info.name])
                {
                    weakself.applyWorkPlaceHeaderView.bossNameInput.textField.text = info.name;
                    weakself.applyWorkPlaceHeaderView.frame = CGRectMake(0, 0, kScreenWidth, 190);
                    [weakself.applyWorkPlaceHeaderView showBossName];
                }
            }
        }
        
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

- (void)getBossWorkPlaceList:(NSString *)phone
{
    WeakSelf(self)
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:bosslist argument:@{@"phone":phone}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            weakself.source = [BossListResponse mj_objectArrayWithKeyValuesArray:result[@"data"]];
            weakself.isHidden = NO;
            [weakself.tableView reloadData];
        }
        
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

- (void)presentAddressBookVC
{
    AddressBookVC *addressBookVC = [AddressBookVC new];
    [addressBookVC.subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    BaseNavigationVC *addressNavi = [[BaseNavigationVC alloc] initWithRootViewController:addressBookVC];
    [self presentViewController:addressNavi animated:YES completion:nil];
}

- (UIView *)headerView
{
    UIView *headerView = [UIView new];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [UILabel labelWithText:@"请选择您要加入的项目"
                                       font:[UIFont systemFontOfSize:14]
                                  textColor:[UIColor blackColor]
                                  alignment:NSTextAlignmentLeft];
    [headerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView.mas_left).offset(16);
        make.centerY.equalTo(headerView);
    }];
    
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [headerView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.bottom.right.equalTo(headerView);
    }];
    
    return headerView;
}

- (void)seletedChange:(int)row
{
    for (int i = 0; i < self.source.count; i++)
    {
        BossListResponse *response = self.source[i];
        response.isSeleted = row == i ? YES: NO;
        
    }
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 46;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.isHidden)
    {
        return 0;
    }
    return 46;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self headerView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isHidden)
    {
        return 0;
    }
    return self.source.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ApplyWorkPlaceCell *cell = [ApplyWorkPlaceCell cellWithCollectionView:tableView];
    [cell loadViewWithModel:self.source[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.seletedRow = (int)indexPath.row;
    [self seletedChange:(int)indexPath.row];
}

@end
