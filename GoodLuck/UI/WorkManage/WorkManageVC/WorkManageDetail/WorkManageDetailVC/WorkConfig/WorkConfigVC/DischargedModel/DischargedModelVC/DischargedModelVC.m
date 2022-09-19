//
//  DischargedModelVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/19.
//

#import "DischargedModelVC.h"
#import "DischargedModelCell.h"
#import "DischargedModelModel.h"
@interface DischargedModelVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<DischargedModelModel *> *sources;
@end

@implementation DischargedModelVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"放行模式选择";
    self.sources = @[[[DischargedModelModel alloc] initWithItem:@"在线" describe:@"有网状态下才能放行" isSeleted:YES],
                     [[DischargedModelModel alloc] initWithItem:@"离线" describe:@"无网络的情况下进行放行，有网自动上传" isSeleted:NO],
                     [[DischargedModelModel alloc] initWithItem:@"自动" describe:@"弱网自动切换至离线模式，有网后自动上传" isSeleted:NO]];
    NSString *seletedName = [DDDataStorageManage userDefaultsGetObjectWithKey:MODELTYPE];
    if (![Tools isEmpty:seletedName])
    {
        for (DischargedModelModel *model in self.sources)
        {
            model.isSeleted = [seletedName isEqualToString:model.item];
        }
    }
    WeakSelf(self)
    [self.sources.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        DischargedModelModel *model = (DischargedModelModel *)x;
        model.isSeleted = [model.item isEqualToString:weakself.name];
    }];
    [self customerUI];
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
        _tableView.tableHeaderView = [self headView];
        _tableView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:DischargedModelCell.class forCellReuseIdentifier:NSStringFromClass(DischargedModelCell.class)];
    }
    return _tableView;
}

- (UIView *)headView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 16)];
    view.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
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
    return 56;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DischargedModelCell *cell = [DischargedModelCell cellWithCollectionView:tableView];
    [cell loadViewWithModel:self.sources[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.subject sendNext:self.sources[indexPath.row].item];
    [DDDataStorageManage userDefaultsSaveObject:self.sources[indexPath.row].item forKey:MODELTYPE];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
