//
//  DateSeletedCompent.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/3.
//

#import "DateSeletedCompent.h"
@interface DateSeletedCompent ()
@property (nonatomic, strong) UILabel *todayLb;
@property (nonatomic, strong) UILabel *yesterdodayLb;
@property (nonatomic, strong) UILabel *sevenLb;
@end
@implementation DateSeletedCompent

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        self.backgroundColor = [UIColor whiteColor];
        [self customerUI];
    }
    return self;
}

- (UILabel *)todayLb
{
    if (!_todayLb)
    {
        _todayLb = [UILabel labelWithText:@"今天"
                                     font:[UIFont systemFontOfSize:font_12]
                                textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                alignment:NSTextAlignmentCenter];
        _todayLb.userInteractionEnabled = YES;
    }
    return _todayLb;
}

- (UILabel *)yesterdodayLb
{
    if (!_yesterdodayLb)
    {
        _yesterdodayLb = [UILabel labelWithText:@"昨天"
                                           font:[UIFont systemFontOfSize:font_12]
                                      textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                      alignment:NSTextAlignmentCenter];
        _yesterdodayLb.userInteractionEnabled = YES;
    }
    return _yesterdodayLb;
}

- (UILabel *)sevenLb
{
    if (!_sevenLb)
    {
        _sevenLb = [UILabel labelWithText:@"过去七天"
                                     font:[UIFont systemFontOfSize:font_12]
                                textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                alignment:NSTextAlignmentCenter];
        _sevenLb.userInteractionEnabled = YES;
    }
    return _sevenLb;
}

- (void)customerUI
{
    [self addSubview:self.todayLb];
    WeakSelf(self)
    [_todayLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself.subject sendNext:@(0)];
        [weakself removeFromSuperview];
    }];
    [_todayLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(40);
    }];
    
    UIView *firstLine = [UIView new];
    firstLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [self addSubview:firstLine];
    [firstLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(self);
        make.top.equalTo(self.todayLb.mas_bottom);
    }];
    
    [self addSubview:self.yesterdodayLb];
    [_yesterdodayLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself.subject sendNext:@(1)];
        [weakself removeFromSuperview];
    }];
    [_yesterdodayLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(40);
        make.top.equalTo(self.todayLb.mas_bottom);
    }];
    
    UIView *secondLine = [UIView new];
    secondLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [self addSubview:secondLine];
    [secondLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(self);
        make.top.equalTo(self.yesterdodayLb.mas_bottom);
    }];
    
    [self addSubview:self.sevenLb];
    [_sevenLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself.subject sendNext:@(2)];
        [weakself removeFromSuperview];
    }];
    [_sevenLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.yesterdodayLb.mas_bottom);
        make.height.equalTo(40);
    }];
}

- (RACSubject *)subject
{
    if (!_subject)
    {
        _subject = [RACSubject new];
    }
    return _subject;
}

- (void)loadWithType:(DataSeletedType )type
{
    switch (type)
    {
        case Today:
        {
            self.todayLb.textColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
            break;
        }
        case YesterDay:
        {
            self.yesterdodayLb.textColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
            break;
        }
        case SevenDay:
        {
            self.sevenLb.textColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
            break;
        }
    }
}

@end
