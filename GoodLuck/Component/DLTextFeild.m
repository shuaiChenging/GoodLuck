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
@end
@implementation DLTextFeild

- (instancetype)initWithType:(TextFeildType)type
{
    self = [super init];
    if (self)
    {
//        self.backgroundColor = [UIColor orangeColor];
        [self customerUI:type];
    }
    return self;
}

- (UILabel *)phoneLb
{
    if (!_phoneLb)
    {
        _phoneLb = [UILabel labelWithText:@"+86"
                                     font:[UIFont systemFontOfSize:16]
                                textColor:[UIColor blueColor]
                                alignment:NSTextAlignmentLeft];
        _phoneLb.hidden = YES;
    }
    return _phoneLb;
}

- (UIView *)phoneLine
{
    if (!_phoneLine)
    {
        _phoneLine = [UIView new];
        _phoneLine.hidden = YES;
        _phoneLine.backgroundColor = [UIColor jk_colorWithHexString:@"#cccccc"];
    }
    return _phoneLine;
}

- (DLButton *)sendCode
{
    if (!_sendCode)
    {
        _sendCode = [DLButton buttonWithType:UIButtonTypeCustom];
        [_sendCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_sendCode.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _sendCode.layer.cornerRadius = 15;
        _sendCode.backgroundColor = [UIColor blueColor];
        _sendCode.hidden = YES;
    }
    return _sendCode;
}

- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [UITextField new];
        _textField.textColor = [UIColor jk_colorWithHexString:@"666666"];
        _textField.font = [UIFont systemFontOfSize:18];
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
    line.backgroundColor = [UIColor jk_colorWithHexString:@"#cccccc"];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.bottom.equalTo(self);
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
            break;
        }
        case SetPasswordInput:
        {
            placeholderStr = @"请设置6-20位登录密码";
            break;
        }
        case ReSetPasswordInput:
        {
            placeholderStr = @"请再次输入新的登录密码";
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
