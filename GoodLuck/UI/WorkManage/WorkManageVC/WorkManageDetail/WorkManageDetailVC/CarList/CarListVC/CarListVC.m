//
//  CarListVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/25.
//

#import "CarListVC.h"
#import "CarListCell.h"
#import "WorkConfigManageResponse.h"
@interface CarListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<WorkConfigManageResponse *> *source;
@end

@implementation CarListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self customerUI];
    [self getData];
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
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:CarListCell.class forCellReuseIdentifier:NSStringFromClass(CarListCell.class)];
    }
    return _tableView;
}

- (void)getData
{
    WeakSelf(self)
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:fleetquery argument:@{@"projectId":self.projectId}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            weakself.source = [WorkConfigManageResponse mj_objectArrayWithKeyValuesArray:result[@"data"]];
            if (weakself.source.count == 0)
            {
                [weakself dismissViewControllerAnimated:YES completion:nil];
            }
            else
            {
                [weakself handData];
                [weakself.tableView reloadData];
            }
        }
        
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

- (void)handData
{
    if (![Tools isEmpty:self.workerId])
    {
        for (WorkConfigManageResponse *response in self.source)
        {
            response.isSelected = [response.workId isEqualToString:self.workerId];
        }
    }
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
    return 54;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.source.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarListCell *cell = [CarListCell cellWithCollectionView:tableView];
    [cell loadViewWithModel:self.source[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorkConfigManageResponse *response = self.source[indexPath.row];
    [self.subject sendNext:response];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
