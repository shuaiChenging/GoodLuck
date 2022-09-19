//
//  WorkContentScrollView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/9/5.
//

#import "WorkContentScrollView.h"
#import "LoginInfoManage.h"
#import "WorkManageCarCell.h"
#import "WorkManageEmptyCell.h"
#import "WorkManageCarHeaderView.h"
#import "EchartCell.h"
#import "WorkManageZDHeaderView.h"
#import "WorkManageCardCell.h"
#import "WorkManageCardHeaderView.h"
#import "WorkManageCarTeamCell.h"
#import "WorkManageCarTeamHeaderView.h"
#import "WorkManageSoilCell.h"
#import "WorkManageSoilHeaderView.h"
#import "WorkManageReleaseCell.h"
#import "WorkManageDetailFooterView.h"
@interface WorkContentScrollView ()

@end
@implementation WorkContentScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.showsVerticalScrollIndicator = self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        [self addChildView];
    }
    return self;
}

- (GLTableView *)carTab
{
    if (!_carTab)
    {
        _carTab = [[GLTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _carTab.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        _carTab.tableHeaderView = [self headerView];
        _carTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _carTab.showsVerticalScrollIndicator = _carTab.showsHorizontalScrollIndicator = NO;
        [_carTab registerClass:WorkManageCarCell.class forCellReuseIdentifier:NSStringFromClass(WorkManageCarCell.class)];
        [_carTab registerClass:WorkManageCarHeaderView.class forHeaderFooterViewReuseIdentifier:NSStringFromClass(WorkManageCarHeaderView.class)];
        
        [_carTab registerClass:WorkManageDetailFooterView.class forHeaderFooterViewReuseIdentifier:NSStringFromClass(WorkManageDetailFooterView.class)];
    }
    return _carTab;
}

- (GLTableView *)ztcTab
{
    if (!_ztcTab)
    {
        _ztcTab = [[GLTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _ztcTab.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        _ztcTab.tableHeaderView = [self headerView];
        _ztcTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _ztcTab.showsVerticalScrollIndicator = _ztcTab.showsHorizontalScrollIndicator = NO;
        [_ztcTab registerClass:EchartCell.class forCellReuseIdentifier:NSStringFromClass(EchartCell.class)];
        [_ztcTab registerClass:WorkManageCardCell.class forCellReuseIdentifier:NSStringFromClass(WorkManageCardCell.class)];
        [_ztcTab registerClass:WorkManageZDHeaderView.class forHeaderFooterViewReuseIdentifier:NSStringFromClass(WorkManageZDHeaderView.class)];
        
        [_ztcTab registerClass:WorkManageDetailFooterView.class forHeaderFooterViewReuseIdentifier:NSStringFromClass(WorkManageDetailFooterView.class)];
        
        [_ztcTab updataPostion];
    }
    return _ztcTab;
}

- (GLTableView *)zdTab
{
    if (!_zdTab)
    {
        _zdTab = [[GLTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _zdTab.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        _zdTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _zdTab.tableHeaderView = [self headerView];
        _zdTab.showsVerticalScrollIndicator = _zdTab.showsHorizontalScrollIndicator = NO;
        [_zdTab registerClass:EchartCell.class forCellReuseIdentifier:NSStringFromClass(EchartCell.class)];
        [_zdTab registerClass:WorkManageCardCell.class forCellReuseIdentifier:NSStringFromClass(WorkManageCardCell.class)];
        [_zdTab registerClass:WorkManageZDHeaderView.class forHeaderFooterViewReuseIdentifier:NSStringFromClass(WorkManageZDHeaderView.class)];
        
        [_zdTab registerClass:WorkManageDetailFooterView.class forHeaderFooterViewReuseIdentifier:NSStringFromClass(WorkManageDetailFooterView.class)];
        
        [_zdTab updataPostion];
    }
    return _zdTab;
}

- (GLTableView *)cardTab
{
    if (!_cardTab)
    {
        _cardTab = [[GLTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _cardTab.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        _cardTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _cardTab.tableHeaderView = [self headerView];
        _cardTab.showsVerticalScrollIndicator = _cardTab.showsHorizontalScrollIndicator = NO;
        [_cardTab registerClass:WorkManageCardCell.class forCellReuseIdentifier:NSStringFromClass(WorkManageCardCell.class)];
        [_cardTab registerClass:WorkManageCardHeaderView.class forHeaderFooterViewReuseIdentifier:NSStringFromClass(WorkManageCardHeaderView.class)];
        
        [_cardTab registerClass:WorkManageDetailFooterView.class forHeaderFooterViewReuseIdentifier:NSStringFromClass(WorkManageDetailFooterView.class)];
    }
    return _cardTab;
}

- (GLTableView *)carTeamTab
{
    if (!_carTeamTab)
    {
        _carTeamTab = [[GLTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _carTeamTab.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        _carTeamTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _carTeamTab.tableHeaderView = [self headerView];
        _carTeamTab.showsVerticalScrollIndicator = _carTeamTab.showsHorizontalScrollIndicator = NO;
        [_carTeamTab registerClass:WorkManageCardCell.class forCellReuseIdentifier:NSStringFromClass(WorkManageCardCell.class)];
        [_carTeamTab registerClass:WorkManageCarTeamHeaderView.class forHeaderFooterViewReuseIdentifier:NSStringFromClass(WorkManageCarTeamHeaderView.class)];
        
        [_carTeamTab registerClass:WorkManageDetailFooterView.class forHeaderFooterViewReuseIdentifier:NSStringFromClass(WorkManageDetailFooterView.class)];
    }
    return _carTeamTab;
}

- (GLTableView *)soilTab
{
    if (!_soilTab)
    {
        _soilTab = [[GLTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _soilTab.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        _soilTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _soilTab.tableHeaderView = [self headerView];
        _soilTab.showsVerticalScrollIndicator = _soilTab.showsHorizontalScrollIndicator = NO;
        [_soilTab registerClass:WorkManageSoilCell.class forCellReuseIdentifier:NSStringFromClass(WorkManageSoilCell.class)];
        [_soilTab registerClass:WorkManageSoilHeaderView.class forHeaderFooterViewReuseIdentifier:NSStringFromClass(WorkManageSoilHeaderView.class)];
        
        [_soilTab registerClass:WorkManageDetailFooterView.class forHeaderFooterViewReuseIdentifier:NSStringFromClass(WorkManageDetailFooterView.class)];
    }
    return _soilTab;
}

- (GLTableView *)historyTab
{
    if (!_historyTab)
    {
        _historyTab = [[GLTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _historyTab.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        _historyTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _historyTab.tableHeaderView = [self headerView];
        _historyTab.showsVerticalScrollIndicator = _historyTab.showsHorizontalScrollIndicator = NO;
        [_historyTab registerClass:WorkManageReleaseCell.class forCellReuseIdentifier:NSStringFromClass(WorkManageReleaseCell.class)];
        [_historyTab registerClass:WorkManageEmptyCell.class forCellReuseIdentifier:NSStringFromClass(WorkManageEmptyCell.class)];
    }
    return _historyTab;
}

- (UIView *)headerView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 16)];
    view.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
    return view;
}

- (void)addChildView
{
    CGFloat height = self.frame.size.height;
    BOOL isBoss = [LoginInfoManage shareInstance].isBoss;
    
    [self addSubview:self.carTab];
    _carTab.frame = CGRectMake(0, 0, kScreenWidth, height);
    
    [self addSubview:self.ztcTab];
    _ztcTab.frame = CGRectMake( (isBoss ? 3 : 1) * kScreenWidth, 0, kScreenWidth, height);
    
    [self addSubview:self.zdTab];
    _zdTab.frame = CGRectMake((isBoss ? 4 : 2) * kScreenWidth, 0, kScreenWidth, height);
    
    [self addSubview:self.cardTab];
    _cardTab.frame = CGRectMake((isBoss ? 2 : 3) * kScreenWidth, 0, kScreenWidth, height);
    
    [self addSubview:self.carTeamTab];
    _carTeamTab.frame = CGRectMake((isBoss ? 5 : 4) * kScreenWidth, 0, kScreenWidth, height);
    
    [self addSubview:self.soilTab];
    _soilTab.frame = CGRectMake((isBoss ? 1 : 5) * kScreenWidth, 0, kScreenWidth, height);
    
    if (!isBoss)
    {
        [self addSubview:self.historyTab];
        _historyTab.frame = CGRectMake(6 * kScreenWidth, 0, kScreenWidth, height);
    }
}

@end
