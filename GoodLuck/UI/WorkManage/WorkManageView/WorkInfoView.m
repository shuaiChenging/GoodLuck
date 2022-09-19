//
//  WorkInfoView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/4.
//

#import "WorkInfoView.h"
@interface WorkInfoView ()

@end
@implementation WorkInfoView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self customerUI];
    }
    return self;
}

- (UILabel *)numberLb
{
    if (!_numberLb)
    {
        _numberLb = [UILabel labelWithText:@"0"
                                      font:[UIFont boldSystemFontOfSize:font_16]
                                 textColor:[UIColor jk_colorWithHexString:COLOR_BLUE]
                                 alignment:NSTextAlignmentCenter];
    }
    return _numberLb;
}

- (UILabel *)itemLb
{
    if (!_itemLb)
    {
        _itemLb = [UILabel labelWithText:@"0"
                                    font:[UIFont systemFontOfSize:font_12]
                               textColor:[UIColor jk_colorWithHexString:COLOR_9B9B9B]
                               alignment:NSTextAlignmentCenter];
    }
    return _itemLb;
}

- (void)customerUI
{
    [self addSubview:self.numberLb];
    [_numberLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.centerX.equalTo(self);
    }];
    
    [self addSubview:self.itemLb];
    [_itemLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.numberLb.mas_bottom).offset(10);
        make.centerX.equalTo(self);
    }];
}

- (void)listHeadStyle
{
    self.numberLb.textColor = [UIColor whiteColor];
    self.itemLb.textColor = [UIColor whiteColor];
}

@end
