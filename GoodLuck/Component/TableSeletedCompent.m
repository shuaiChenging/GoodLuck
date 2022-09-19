//
//  TableSeletedCompent.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/8/29.
//

#import "TableSeletedCompent.h"
#import "TableSeletedCell.h"
@interface TableSeletedCompent ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *array;
@end
@implementation TableSeletedCompent

- (instancetype)initWithArray:(NSArray *)array
{
    self = [super init];
    if (self)
    {
        self.array = array;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor jk_colorWithHexString:COLOR_LINE].CGColor;
        self.layer.cornerRadius = 10;
        [self customerUI];
    }
    return self;
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
        [_tableView registerClass:TableSeletedCell.class forCellReuseIdentifier:NSStringFromClass(TableSeletedCell.class)];
    }
    return _tableView;
}

- (void)customerUI
{
    [self addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableSeletedCell *cell = [TableSeletedCell cellWithCollectionView:tableView];
    cell.label.text = self.array[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.subject sendNext:@(indexPath.row)];
    [self removeFromSuperview];
}

@end
