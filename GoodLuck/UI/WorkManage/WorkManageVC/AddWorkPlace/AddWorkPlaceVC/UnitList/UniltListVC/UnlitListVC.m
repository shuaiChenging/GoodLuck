//
//  UnlitListVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/8.
//

#import "UnlitListVC.h"
#import "UniltListCell.h"
#import "CompanyListResponse.h"
@interface UnlitListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<CompanyListResponse *> *soucrs;
@end

@implementation UnlitListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
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
        _tableView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:UniltListCell.class forCellReuseIdentifier:NSStringFromClass(UniltListCell.class)];
    }
    return _tableView;
}

- (void)getData
{
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:companylist argument:@{@"status":@"ENABLE"}];
    WeakSelf(self)
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            weakself.soucrs = [CompanyListResponse mj_objectArrayWithKeyValuesArray:result[@"data"]];
            [weakself handData];
            [weakself.tableView reloadData];
            
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

- (void)handData
{
    if (![Tools isEmpty:self.companyId])
    {
        for (CompanyListResponse *response in self.soucrs)
        {
            response.isSeleted = [response.companyId isEqualToString:self.companyId];
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
    return self.soucrs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UniltListCell *cell = [UniltListCell cellWithCollectionView:tableView];
    [cell loadViewWithModel:self.soucrs[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CompanyListResponse *response = self.soucrs[indexPath.row];
    [self.subject sendNext:response];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
