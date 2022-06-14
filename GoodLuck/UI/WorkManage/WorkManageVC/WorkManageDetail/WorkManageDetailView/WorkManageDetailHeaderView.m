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
@interface WorkManageDetailHeaderView ()
@property (nonatomic, strong) WorkOrderStatisticsView *workOrderView;
@end
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

- (WorkOrderStatisticsView *)workOrderView
{
    if (!_workOrderView)
    {
        _workOrderView = [WorkOrderStatisticsView new];
    }
    return _workOrderView;
}

- (UILabel *)currentPeople
{
    if (!_currentPeople)
    {
        _currentPeople = [UILabel labelWithText:@"当前上班管理员："
                                           font:[UIFont systemFontOfSize:12]
                                      textColor:[UIColor blackColor]
                                      alignment:NSTextAlignmentLeft];
    }
    return _currentPeople;
}

- (UIView *)scanView
{
    if (!_scanView)
    {
        _scanView = [UIView new];
        _scanView.backgroundColor = [UIColor blueColor];
        _scanView.layer.masksToBounds = YES;
        _scanView.layer.cornerRadius = 50;
        _scanView.hidden = [LoginInfoManage shareInstance].isBoss;
    }
    return _scanView;
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
        make.height.equalTo(220);
    }];
    
    [self addSubview:self.scanView];
    [_scanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(100);
        make.centerX.equalTo(self);
        make.top.equalTo(mapView).offset(40);
    }];
    
    UIView *currentBack = [UIView new];
    currentBack.layer.masksToBounds = YES;
    currentBack.layer.cornerRadius = 5;
    currentBack.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [self addSubview:currentBack];
    [currentBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(mapView).offset(-10);
        make.left.equalTo(self).offset(16);
        make.height.equalTo(42);
        make.right.equalTo(self).offset(-40);
    }];
    
    UIImageView *img = [UIImageView new];
    img.backgroundColor = [UIColor grayColor];
    [currentBack addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(30);
        make.left.equalTo(currentBack).offset(16);
        make.centerY.equalTo(currentBack);
    }];
    
    [currentBack addSubview:self.currentPeople];
    [_currentPeople mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(img.mas_right).offset(8);
        make.centerY.equalTo(img);
        make.right.equalTo(currentBack).offset(-16);
    }];
    
    [self addSubview:self.workOrderView];
    [_workOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.top.equalTo(self.workOrderView.mas_bottom);
    }];
    
    WorkStatisticsView *workView = [WorkStatisticsView new];
    [self addSubview:workView];
    [workView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(100);
    }];
}

- (void)loadOrderWithModel:(WorkOrderResponse *)response
{
    [self.workOrderView loadOrderWithModel:response];
}

@end
