//
//  AddCompent.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/11.
//

#import "AddCompent.h"
@interface AddCompent ()
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, copy) NSString *textStr;
@end
@implementation AddCompent

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        [self customerUI];
    }
    return self;
}

- (UILabel *)nameLb
{
    if (!_nameLb)
    {
        _nameLb = [UILabel labelWithText:@"添加车队"
                                    font:[UIFont boldSystemFontOfSize:14]
                               textColor:[UIColor blackColor]
                               alignment:NSTextAlignmentCenter];
    }
    return _nameLb;
}

- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [UITextField new];
        _textField.textColor = [UIColor jk_colorWithHexString:@"#666666"];
        _textField.font = [UIFont systemFontOfSize:12];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    }
    return _textField;
}

- (RACSubject *)subject
{
    if (!_subject)
    {
        _subject = [RACSubject new];
    }
    return _subject;
}

- (RACSubject *)cancelSubject
{
    if (!_cancelSubject)
    {
        _cancelSubject = [RACSubject new];
    }
    return _cancelSubject;
}

- (void)customerUI
{
    [self addSubview:self.nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(26);
    }];
    
    [self addSubview:self.textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLb.mas_bottom).offset(14);
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.height.equalTo(40);
    }];
    
    UIView *topView = [UIView new];
    topView.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.mas_bottom).offset(14);
        make.height.equalTo(0.5);
        make.left.right.equalTo(self);
    }];
    
    UILabel *leftLb = [UILabel labelWithText:@"取消"
                                        font:[UIFont systemFontOfSize:14]
                                   textColor:[UIColor blackColor]
                                   alignment:NSTextAlignmentCenter];
    leftLb.userInteractionEnabled = YES;
    WeakSelf(self)
    [leftLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself.cancelSubject sendNext:@"1"];
        [weakself removeFromSuperview];
    }];
    [self addSubview:leftLb];
    [leftLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self);
        make.right.equalTo(self.mas_centerX);
        make.top.equalTo(topView.mas_bottom);
        make.height.equalTo(44);
    }];
    
    UILabel *rightLb = [UILabel labelWithText:@"确认"
                                         font:[UIFont systemFontOfSize:14]
                                    textColor:[UIColor blueColor]
                                    alignment:NSTextAlignmentCenter];
    rightLb.userInteractionEnabled = YES;
    [rightLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself sureHandle];
    }];
    [self addSubview:rightLb];
    [rightLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX);
        make.top.bottom.equalTo(leftLb);
        make.right.equalTo(self);
    }];
    
    UIView *middleLine = [UIView new];
    middleLine.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [self addSubview:middleLine];
    [middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(0.5);
        make.top.bottom.equalTo(leftLb);
        make.centerX.equalTo(self);
    }];
}

- (void)sureHandle
{
    if (self.textField.text.length == 0)
    {
        [Tools showToast:self.textStr];
    }
    [self.subject sendNext:self.textField.text];
    [self removeFromSuperview];
}

- (void)loadViewWithTitle:(NSString *)title placeholder:(NSString *)placeholder
{
    self.textStr = placeholder;
    self.nameLb.text = title;
    self.textField.placeholder = placeholder;
}

@end
