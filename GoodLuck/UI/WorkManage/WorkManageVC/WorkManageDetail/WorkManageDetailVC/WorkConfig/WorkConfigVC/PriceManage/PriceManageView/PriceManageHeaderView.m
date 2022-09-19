//
//  PriceManageHeaderView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/29.
//

#import "PriceManageHeaderView.h"
@interface PriceManageHeaderView ()
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *typeLb;
@property (nonatomic, strong) UILabel *sizeLb;
@property (nonatomic, strong) UILabel *priceLb;
@end
@implementation PriceManageHeaderView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        [self customerUI];
    }
    return self;
}

- (UILabel *)nameLb
{
    if (!_nameLb)
    {
        _nameLb = [UILabel labelWithText:@"渣土场价格添加"
                                   font:[UIFont boldSystemFontOfSize:15]
                              textColor:[UIColor blackColor]
                              alignment:NSTextAlignmentLeft];
    }
    return _nameLb;
}

- (UILabel *)typeLb
{
    if (!_typeLb)
    {
        _typeLb = [UILabel labelWithText:@"渣土场"
                                    font:[UIFont boldSystemFontOfSize:font_14]
                               textColor:[UIColor blackColor]
                               alignment:NSTextAlignmentCenter];
    }
    return _typeLb;
}

- (UILabel *)sizeLb
{
    if (!_sizeLb)
    {
        _sizeLb = [UILabel labelWithText:@"车斗/方"
                                    font:[UIFont boldSystemFontOfSize:font_14]
                               textColor:[UIColor blackColor]
                               alignment:NSTextAlignmentCenter];
    }
    return _sizeLb;
}

- (UILabel *)priceLb
{
    if (!_priceLb)
    {
        _priceLb = [UILabel labelWithText:@"价格/车"
                                     font:[UIFont boldSystemFontOfSize:font_14]
                                textColor:[UIColor blackColor]
                                alignment:NSTextAlignmentCenter];
    }
    return _priceLb;
}

- (void)customerUI
{
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(4);
        make.height.equalTo(14);
        make.left.top.equalTo(self).offset(16);
    }];
    
    [self addSubview:self.nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView.mas_right).offset(10);
        make.centerY.equalTo(lineView);
    }];
    
    UIView *contentBack = [UIView new];
    contentBack.backgroundColor = [UIColor jk_colorWithHexString:COLOR_FORM];
    [self addSubview:contentBack];
    [contentBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.top.equalTo(lineView.mas_bottom).offset(16);
        make.bottom.equalTo(self);
    }];
    
    [contentBack addSubview:self.typeLb];
    [_typeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(contentBack);
        make.width.equalTo((kScreenWidth - 32)/3);
    }];
    
    [contentBack addSubview:self.sizeLb];
    [_sizeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(contentBack);
        make.left.equalTo(self.typeLb.mas_right);
        make.width.equalTo((kScreenWidth - 32)/3);
    }];
    
    [contentBack addSubview:self.priceLb];
    [_priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(contentBack);
        make.left.equalTo(self.sizeLb.mas_right);
        make.width.equalTo((kScreenWidth - 32)/3);
    }];
    
}

- (void)setViewWithName:(NSString *)name
                   type:(NSString *)type
{
    self.nameLb.text = name;
    self.typeLb.text = type;
}

@end
