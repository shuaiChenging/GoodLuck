//
//  TimeShowView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/5.
//

#import "TimeShowView.h"
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
        _timeLb = [UILabel labelWithText:[NSString stringWithFormat:@"%@(24小时)",[Tools dateToString:[NSDate date] withDateFormat:@"yyyy-MM-dd"]]
                                    font:[UIFont systemFontOfSize:font_13]
                               textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                               alignment:NSTextAlignmentCenter];
    }
    return _timeLb;
}

- (void)customerUI
{
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_F5F8F8];
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
    
    UIImageView *leftImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"manage_detail_time_left"]];
    [self addSubview:leftImg];
    [leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.timeLb.mas_left).offset(-6);
        make.width.height.equalTo(14);
    }];
    
    UIImageView *downImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"manage_detail_time_select"]];
    [self addSubview:downImg];
    [downImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.timeLb.mas_right).offset(6);
        make.width.equalTo(9);
        make.height.equalTo(9.0/13 * 9);
    }];
}

@end
