//
//  WorkAddView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/4.
//

#import "WorkAddView.h"

@implementation WorkAddView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 2;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor jk_colorWithHexString:COLOR_4B8BC3].CGColor;
        [self customerUI];
    }
    return self;
}

- (UILabel *)nameLb
{
    if (!_nameLb)
    {
        _nameLb = [UILabel labelWithText:@""
                                    font:[UIFont systemFontOfSize:font_13]
                               textColor:[UIColor jk_colorWithHexString:COLOR_4B8BC3]
                               alignment:NSTextAlignmentCenter];
    }
    return _nameLb;
}

- (void)customerUI
{
    [self addSubview:self.nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(6, 8, 6, 8));
    }];
}

@end
