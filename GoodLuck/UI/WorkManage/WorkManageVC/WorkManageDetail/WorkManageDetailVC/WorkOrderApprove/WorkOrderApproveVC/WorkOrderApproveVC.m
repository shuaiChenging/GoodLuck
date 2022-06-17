//
//  WorkOrderApproveVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/14.
//

#import "WorkOrderApproveVC.h"
#import "WorkOrderApproveCell.h"
@interface WorkOrderApproveVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation WorkOrderApproveVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"工单审批";
    [self customerUI];
    [self getData];
}

- (void)getData
{
    
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [self headerView];
        _tableView.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:WorkOrderApproveCell.class forCellReuseIdentifier:NSStringFromClass(WorkOrderApproveCell.class)];
    }
    return _tableView;
}

- (UIView *)headerView
{
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, kScreenWidth, 20);
    return view;
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
    return 260;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorkOrderApproveCell *cell = [WorkOrderApproveCell cellWithCollectionView:tableView];
    return cell;
}


@end
