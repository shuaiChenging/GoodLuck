//
//  WorkManageDetailHeaderView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/5.
//

#import "WorkManageDetailHeaderView.h"
#import "WorkStatisticsView.h"
#import "WorkOrderStatisticsView.h"
#import "LoginInfoManage.h"

@implementation WorkManageDetailHeaderView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self customerUI];
    }
    return self;
}

- (WorkManageHandleView *)handleView
{
    if (!_handleView)
    {
        _handleView = [WorkManageHandleView new];
    }
    return _handleView;
}

- (WorkManageDetalAdmiView *)admiView
{
    if (!_admiView)
    {
        _admiView = [WorkManageDetalAdmiView new];
    }
    return _admiView;
}

- (void)customerUI
{
    if ([LoginInfoManage shareInstance].isBoss)
    {
        [self addSubview:self.handleView];
        [_handleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
        }];
    }
    else
    {
        [self addSubview:self.admiView];
        [_admiView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.equalTo(46);
        }];
    }
    
    UIView *mapView = [UIView new];
    mapView.backgroundColor = [UIColor orangeColor];
    [self addSubview:mapView];
    [mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo( [LoginInfoManage shareInstance].isBoss ? self.handleView.mas_bottom : self.admiView.mas_bottom);
        make.height.equalTo(150);
    }];
    
    WorkOrderStatisticsView *workOrderView = [WorkOrderStatisticsView new];
    [self addSubview:workOrderView];
    [workOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mapView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(194);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(10);
        make.top.equalTo(workOrderView.mas_bottom);
    }];
    
    WorkStatisticsView *workView = [WorkStatisticsView new];
    [self addSubview:workView];
    [workView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(100);
    }];
}

@end
