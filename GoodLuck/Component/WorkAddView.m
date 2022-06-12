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
        self.layer.borderColor = [UIColor blueColor].CGColor;
        [self customerUI];
    }
    return self;
}

- (UILabel *)nameLb
{
    if (!_nameLb)
    {
        _nameLb = [UILabel labelWithText:@""
                                    font:[UIFont systemFontOfSize:14]
                               textColor:[UIColor blueColor]
                               alignment:NSTextAlignmentCenter];
    }
    return _nameLb;
}

- (void)customerUI
{
    [self addSubview:self.nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(4, 6, 4, 6));
    }];
}

@end
