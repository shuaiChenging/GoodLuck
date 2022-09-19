//
//  WorkDataDetailSectionHeaderView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/4.
//

#import "WorkDataDetailSectionHeaderView.h"
@interface WorkDataDetailSectionHeaderView ()
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *orderLb;
@property (nonatomic, strong) UILabel *ztcLb;
@end
@implementation WorkDataDetailSectionHeaderView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self customerUI];
    }
    return self;
}

- (UILabel *)orderLb
{
    if (!_orderLb)
    {
        _orderLb = [UILabel labelWithText:@"工单数：2"
                                     font:[UIFont systemFontOfSize:font_12]
                                textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                alignment:NSTextAlignmentLeft];
    }
    return _orderLb;
}

- (UILabel *)ztcLb
{
    if (!_ztcLb)
    {
        _ztcLb = [UILabel labelWithText:@"渣土场数：2"
                                   font:[UIFont systemFontOfSize:font_12]
                              textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                              alignment:NSTextAlignmentLeft];
    }
    return _ztcLb;
}

- (UILabel *)nameLb
{
    if (!_nameLb)
    {
        _nameLb = [UILabel labelWithText:@"工单数据统计"
                                    font:[UIFont boldSystemFontOfSize:font_16]
                               textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                               alignment:NSTextAlignmentLeft];
    }
    return _nameLb;
}

- (void)customerUI
{
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.top.bottom.equalTo(self);
    }];
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
    [backView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(16);
        make.centerY.equalTo(backView);
        make.width.equalTo(6);
        make.height.equalTo(18);
    }];
    
    [backView addSubview:self.nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_right).offset(10);
        make.centerY.equalTo(view);
    }];
    
    [backView addSubview:self.orderLb];
    [_orderLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-16);
        make.centerY.equalTo(backView);
    }];
    
    [backView addSubview:self.ztcLb];
    [_ztcLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.orderLb.mas_left).offset(-8);
        make.centerY.equalTo(backView);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [backView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(backView);
        make.height.equalTo(0.5);
    }];
}

- (void)loadViewWithCustomModel:(CustomtcStatisticsResponse *)customModel
                workerTypeModel:(WorkerTypeResponse *)workerModel
                          isZTC:(BOOL)isZTC
{
    if (isZTC)
    {
        _nameLb.text = @"指定渣土场";
        _ztcLb.hidden = NO;
        _ztcLb.text = [NSString stringWithFormat:@"渣土场数：%@",customModel.ztcCount];
        _orderLb.text = [NSString stringWithFormat:@"工单数：%@",customModel.workerOrderCount];
    }
    else
    {
        _nameLb.text = @"班次合计";
        _ztcLb.hidden = YES;
        _ztcLb.text = @"";
        _orderLb.text = [NSString stringWithFormat:@"工单数：%@",workerModel.workerOrderCount];
    }
}

@end
