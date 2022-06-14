//
//  TimeShowView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/5.
//

#import "TimeShowView.h"
@interface TimeShowView ()
@property (nonatomic, strong) UILabel *timeLb;
@end
@implementation TimeShowView

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

- (UILabel *)timeLb
{
    if (!_timeLb)
    {
        _timeLb = [UILabel labelWithText:@"2022.05.19(24小时)"
                                    font:[UIFont systemFontOfSize:14]
                               textColor:[UIColor blackColor]
                               alignment:NSTextAlignmentCenter];
    }
    return _timeLb;
}

- (void)customerUI
{
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(kScreenWidth - 32);
        make.top.bottom.equalTo(self);
    }];
    
    [self addSubview:self.timeLb];
    [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}

@end
