//
//  DLTextFeild.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/5/31.
//

#import "DLTextFeild.h"

@interface DLTextFeild ()
@property (nonatomic, strong) UILabel *phoneLb;
@property (nonatomic, strong) UIView *phoneLine;
@property (nonatomic, strong) GLImageView *passwordImg;
@property (nonatomic, assign) BOOL isOpen;
@end
@implementation DLTextFeild

- (instancetype)initWithType:(TextFeildType)type
{
    self = [super init];
    if (self)
    {
        self.isOpen = NO;
        [self customerUI:type];
    }
    return self;
}

- (UILabel *)phoneLb
{
    if (!_phoneLb)
    {
        _phoneLb = [UILabel labelWithText:@"+86"
                                     font:[UIFont systemFontOfSize:font_16]
                                textColor:[UIColor jk_colorWithHexString:COLOR_BLUE]
                                alignment:NSTextAlignmentLeft];
        _phoneLb.hidden = YES;
    }
    return _phoneLb;
}

- (GLImageView *)passwordImg
{
    if (!_passwordImg)
    {
        _passwordImg = [[GLImageView alloc] initWithImage:[UIImage imageNamed:@"login_eye_close"]];
        _passwordImg.userInteractionEnabled = YES;
        _passwordImg.hidden = YES;
    }
    return _passwordImg;
}

- (UIView *)phoneLine
{
    if (!_phoneLine)
    {
        _phoneLine = [UIView new];
        _phoneLine.hidden = YES;
        _phoneLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LOGIN_LINE];
    }
    return _phoneLine;
}

- (DLButton *)sendCode
{
    if (!_sendCode)
    {
        _sendCode = [DLButton buttonWithType:UIButtonTypeCustom];
        [_sendCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_sendCode.titleLabel setFont:[UIFont systemFontOfSize:font_14]];
        _sendCode.layer.cornerRadius = 15;
        _sendCode.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
        _sendCode.hidden = YES;
    }
    return _sendCode;
}

- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [UITextField new];
        _textField.textColor = [UIColor jk_colorWithHexString:COLOR_242424];
        _textField.font = [UIFont systemFontOfSize:font_16];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _textField;
}

- (void)customerUI:(TextFeildType)type
{
  
    [self addSubview:self.textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LOGIN_LINE];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.bottom.equalTo(self);
    }];
    
    [self addSubview:self.passwordImg];
    WeakSelf(self)
    [_passwordImg jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        weakself.isOpen = !weakself.isOpen;
        weakself.textField.secureTextEntry = !weakself.isOpen;
        weakself.passwordImg.image = [UIImage imageNamed:weakself.isOpen ? @"login_eye_open" : @"login_eye_close"];
    }];
    [_passwordImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(20);
        make.height.equalTo(13);
        make.right.equalTo(-16);
        make.centerY.equalTo(self);
    }];
    
    [self addSubview:self.phoneLb];
    [_phoneLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(self);
        make.width.equalTo(30);
    }];
    
    [self addSubview:self.phoneLine];
    [_phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneLb.mas_right).offset(6);
        make.centerY.equalTo(self.phoneLb);
        make.width.equalTo(0.5);
        make.height.equalTo(20);
    }];
    
    [self addSubview:self.sendCode];
    [_sendCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(30);
        make.width.equalTo(110);
        make.right.equalTo(self).offset(-6);
        make.centerY.equalTo(self);
    }];
    
    NSString *placeholderStr = @"";
    switch (type)
    {
        case UserInput:
        {
            placeholderStr = @"请输入手机号";
            _textField.keyboardType = UIKeyboardTypeNumberPad;
            break;
        }
        case PasswordInput:
        {
            placeholderStr = @"请输入密码";
            _passwordImg.hidden = NO;
            _textField.secureTextEntry = YES;
            [_textField mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self).offset(-16 - 6 - 20);
            }];
            break;
        }
        case SetPasswordInput:
        {
            placeholderStr = @"请设置6-20位登录密码";
            _textField.secureTextEntry = YES;
            break;
        }
        case ReSetPasswordInput:
        {
            placeholderStr = @"请再次输入新的登录密码";
            _textField.secureTextEntry = YES;
            break;
        }
        case PhoneInput:
        {
            placeholderStr = @"请输入手机号码";
            _phoneLb.hidden = NO;
            _phoneLine.hidden = NO;
            _textField.keyboardType = UIKeyboardTypeNumberPad;
            [_textField mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.phoneLine.mas_right).offset(6);
                make.top.bottom.right.equalTo(self);
            }];
            break;
        }
        case CodeInput:
        {
            placeholderStr = @"请输入短信验证码";
            _sendCode.hidden = NO;
            _textField.keyboardType = UIKeyboardTypeNumberPad;
            [_textField mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self).offset(-16 - 6 - 110);
            }];
            break;
        }
    }
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:placeholderStr
                                                                     attributes:@{NSForegroundColorAttributeName:[UIColor jk_colorWithHexString:@"#CECECE"]}];
    _textField.attributedPlaceholder = attrString;
    
    
}

@end
