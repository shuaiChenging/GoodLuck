//
//  WorkManageItemView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/5.
//

#import "WorkManageItemView.h"
@implementation WorkManageItemView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self customerUI];
    }
    return self;
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

- (UILabel *)detailLb
{
    if (!_detailLb)
    {
        _detailLb = [UILabel labelWithText:@"详情"
                                      font:[UIFont systemFontOfSize:font_12]
                                 textColor:[UIColor jk_colorWithHexString:COLOR_GREEN]
                                 alignment:NSTextAlignmentRight];
        _detailLb.userInteractionEnabled = YES;
    }
    return _detailLb;
}

- (UIImageView *)arrowImg
{
    if (!_arrowImg)
    {
        _arrowImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_right_arrow"]];
    }
    return _arrowImg;
}

- (void)customerUI
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.top.equalTo(self).offset(18);
        make.bottom.equalTo(self).offset(-18);
        make.width.equalTo(6);
        make.height.equalTo(18);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.bottom.equalTo(self);
    }];
    
    [self addSubview:self.nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_right).offset(10);
        make.centerY.equalTo(view);
    }];
    
    [self addSubview:self.arrowImg];
    [_arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(16);
        make.centerY.equalTo(view);
        make.right.equalTo(self).offset(-16);
    }];
    
    [self addSubview:self.detailLb];
    [_detailLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowImg.mas_left);
        make.centerY.equalTo(view);
    }];
}

@end
