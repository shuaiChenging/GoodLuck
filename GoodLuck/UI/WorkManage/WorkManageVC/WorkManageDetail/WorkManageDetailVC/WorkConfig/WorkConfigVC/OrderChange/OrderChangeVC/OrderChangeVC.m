//
//  OrderChangeVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/19.
//

#import "OrderChangeVC.h"
#import "OrderChangeCell.h"
@interface OrderChangeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) GLTextField *searchBar;
@property (nonatomic, strong) UILabel *timeLb;
@end

@implementation OrderChangeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"工单详情";
    [self customerUI];
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
        [_tableView registerClass:OrderChangeCell.class forCellReuseIdentifier:NSStringFromClass(OrderChangeCell.class)];
    }
    return _tableView;
}

- (UIView *)headerView
{
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, kScreenWidth, 16);
    return view;
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
        _timeLb = [UILabel labelWithText:@"2022.04.28(24小时)"
                                    font:[UIFont systemFontOfSize:14]
                               textColor:[UIColor blackColor]
                               alignment:NSTextAlignmentCenter];
    }
    return _timeLb;
}

- (void)requestData
{
    
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
    
    UIView *selectView = [UIView new];
    selectView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:selectView];
    [selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(64);
        make.left.right.equalTo(self.view);
        make.top.equalTo(dateBack.mas_bottom);
    }];
    
    [selectView addSubview:self.searchBar];
    [_searchBar.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        
    }];
    [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selectView).offset(12);
        make.left.equalTo(selectView).offset(16);
        make.right.equalTo(selectView).offset(-16);
        make.bottom.equalTo(selectView.mas_bottom).offset(-12);
    }];
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selectView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderChangeCell *cell = [OrderChangeCell cellWithCollectionView:tableView];
    return cell;
}

@end
