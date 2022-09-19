//
//  TodayCompent.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/3.
//

#import "TodayCompent.h"

@implementation TodayCompent

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 12;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 1;
        self.userInteractionEnabled = YES;
        [self customerUI];
    }
    return self;
}

- (UILabel *)todyLb
{
    if (!_todyLb)
    {
        _todyLb = [UILabel labelWithText:@"今天"
                                    font:[UIFont boldSystemFontOfSize:font_12]
                               textColor:[UIColor whiteColor]
                               alignment:NSTextAlignmentCenter];
    }
    return _todyLb;
}

- (void)customerUI
{
    [self addSubview:self.todyLb];
    [_todyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
    }];
    
    UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_white_arrow"]];
    [self addSubview:arrow];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(7);
        make.height.equalTo(4);
        make.left.equalTo(self.todyLb.mas_right).offset(8);
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self);
    }];
    
}

@end
