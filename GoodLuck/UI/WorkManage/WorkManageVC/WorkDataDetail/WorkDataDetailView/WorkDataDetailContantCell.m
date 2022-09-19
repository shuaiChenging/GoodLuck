//
//  WorkDataDetailContantCell.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/14.
//

#import "WorkDataDetailContantCell.h"
#import "WorkDataDetailCell.h"
#import "WorkDataDetailSectionHeaderView.h"
@interface WorkDataDetailContantCell ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL isZTC;
@property (nonatomic, strong) NSArray<WorkerItem *> *zctArray;
@property (nonatomic, strong) NSArray<WorkerItemType *> *classArray;
@property (nonatomic, strong) UILabel *emptyLb;
@end
@implementation WorkDataDetailContantCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        [self customerUI];
    }
    
    return self;
}

+ (instancetype)cellWithCollectionView:(UITableView *)tableView
{
    WorkDataDetailContantCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    return cell;
}

- (UILabel *)emptyLb
{
    if (!_emptyLb)
    {
        _emptyLb = [UILabel labelWithText:@"暂无数据"
                                     font:[UIFont systemFontOfSize:font_14]
                                textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                alignment:NSTextAlignmentCenter];
    }
    return _emptyLb;
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
        [_tableView registerClass:WorkDataDetailCell.class forCellReuseIdentifier:NSStringFromClass(WorkDataDetailCell.class)];
    }
    return _tableView;
}

- (void)customerUI
{
    
    [self.contentView addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.emptyLb];
    [_emptyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
}

- (UIView *)sectionHeaderView:(NSInteger)section
{
    UIView *view = [UIView new];
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_FORM];
    [view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(16);
        make.right.equalTo(view).offset(-16);
        make.top.bottom.equalTo(view);
    }];
    
    UILabel *nameLb = [UILabel labelWithText:self.classArray[section].workType
                                        font:[UIFont systemFontOfSize:font_12]
                                   textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                   alignment:NSTextAlignmentLeft];
    [backView addSubview:nameLb];
    [nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(16);
        make.centerY.equalTo(backView);
    }];
    
    UILabel *allLb = [UILabel labelWithText:[NSString stringWithFormat:@"合计 %@车",self.classArray[section].count]
                                       font:[UIFont systemFontOfSize:font_12]
                                  textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                  alignment:NSTextAlignmentRight];
    [backView addSubview:allLb];
    [allLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-16);
        make.centerY.equalTo(backView);
    }];
    
    return view;
}

- (void)loadViewWithType:(BOOL)isZTCType ztcArr:(NSArray<WorkerItem *> *)ztcArr classArr:(NSArray<WorkerItemType *> *)classArr
{
    self.isZTC = isZTCType;
    self.zctArray = ztcArr;
    self.classArray = classArr;
    if (isZTCType)
    {
        self.emptyLb.hidden = ztcArr.count > 0;
    }
    else
    {
        self.emptyLb.hidden = classArr.count > 0;
    }
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.isZTC)
    {
        return 1;
    }
    return self.classArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.isZTC)
    {
        return 0;
    }
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self sectionHeaderView:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.isZTC)
    {
        return 0;
    }
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isZTC)
    {
        return self.zctArray.count;
    }
    else
    {
        return self.classArray[section].details.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorkDataDetailCell *cell = [WorkDataDetailCell cellWithCollectionView:tableView];
    if (self.isZTC)
    {
        [cell loadViewWithModel:self.zctArray[indexPath.row]];
    }
    else
    {
        [cell loadViewWithModel:self.classArray[indexPath.section].details[indexPath.row]];
    }
    return cell;
}

@end
