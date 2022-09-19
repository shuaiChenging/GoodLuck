//
//  AlertCompent.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/4.
//

#import "AlertCompent.h"
@interface AlertCompent ()
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *contentLb;
@property (nonatomic, strong) UILabel *leftLb;
@property (nonatomic, strong) UILabel *rightLb;
@end
@implementation AlertCompent

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        [self customerUI];
    }
    return self;
}

- (RACSubject *)subject
{
    if (!_subject)
    {
        _subject = [RACSubject new];
    }
    return _subject;
}

- (UILabel *)titleLb
{
    if (!_titleLb)
    {
        _titleLb = [UILabel labelWithText:@"下班提示"
                                     font:[UIFont boldSystemFontOfSize:font_16]
                                textColor:[UIColor blackColor]
                                alignment:NSTextAlignmentCenter];
    }
    return _titleLb;
}

- (UILabel *)contentLb
{
    if (!_contentLb)
    {
        _contentLb = [UILabel labelWithText:@"您确定下班吗？"
                                       font:[UIFont systemFontOfSize:font_14]
                                  textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                  alignment:NSTextAlignmentCenter];
        _contentLb.numberOfLines = 0;
    }
    return _contentLb;
}

- (UILabel *)leftLb
{
    if (!_leftLb)
    {
        _leftLb = [UILabel labelWithText:@"取消"
                                    font:[UIFont systemFontOfSize:font_15]
                               textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                               alignment:NSTextAlignmentCenter];
        _leftLb.userInteractionEnabled = YES;
    }
    return _leftLb;
}

- (UILabel *)rightLb
{
    if (!_rightLb)
    {
        _rightLb = [UILabel labelWithText:@"确定"
                                    font:[UIFont systemFontOfSize:font_15]
                               textColor:[UIColor jk_colorWithHexString:COLOR_BLUE]
                               alignment:NSTextAlignmentCenter];
        _rightLb.userInteractionEnabled = YES;
    }
    return _rightLb;
}

- (void)customerUI
{
    [self addSubview:self.titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(30);
        make.centerX.equalTo(self);
    }];
    
    [self addSubview:self.contentLb];
    [_contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLb.mas_bottom).offset(16);
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.centerX.equalTo(self);
    }];
    
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(self);
        make.top.equalTo(self.contentLb.mas_bottom).offset(20);
    }];
    
    [self addSubview:self.leftLb];
    WeakSelf(self)
    [_leftLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself.subject sendNext:@"1"];
        [weakself removeFromSuperview];
    }];
    [_leftLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomLine.mas_bottom).offset(16);
        make.left.equalTo(self);
        make.right.equalTo(self.mas_centerX);
        make.bottom.equalTo(self).offset(-16);
    }];
    
    [self addSubview:self.rightLb];
    [_rightLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself.subject sendNext:@"2"];
        [weakself removeFromSuperview];
    }];
    [_rightLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX);
        make.top.bottom.equalTo(self.leftLb);
        make.right.equalTo(self);
    }];
    
    UIView *middleLine = [UIView new];
    middleLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [self addSubview:middleLine];
    [middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(0.5);
        make.top.equalTo(self.leftLb);
        make.bottom.equalTo(self);
    }];
}

- (void)loadViewWithTitle:(NSString *)titleStr
                  content:(NSString *)contentStr
                     left:(NSString *)leftStr
                    right:(NSString *)rightStr
{
    self.titleLb.text = titleStr;
    self.contentLb.text = contentStr;
    self.leftLb.text = leftStr;
    self.rightLb.text = rightStr;
}

@end
