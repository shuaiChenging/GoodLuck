//
//  RegistView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/4.
//

#import "RegisterView.h"

@implementation RegisterView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self customerUI];
    }
    return self;
}

- (UILabel *)phoneLoginLb
{
    if (!_phoneLoginLb)
    {
        _phoneLoginLb = [UILabel labelWithText:@"已有账户，立即登录"
                                          font:[UIFont systemFontOfSize:16]
                                     textColor:nil
                                     alignment:NSTextAlignmentLeft];
        _phoneLoginLb.userInteractionEnabled = YES;
    }
    return _phoneLoginLb;
}

- (DLTextFeild *)accountTF
{
    if (!_accountTF)
    {
        _accountTF = [[DLTextFeild alloc] initWithType:PhoneInput];
    }
    return _accountTF;
}

- (DLTextFeild *)codeTF
{
    if (!_codeTF)
    {
        _codeTF = [[DLTextFeild alloc] initWithType:CodeInput];
    }
    return _codeTF;
}

- (DLTextFeild *)passwordTF
{
    if (!_passwordTF)
    {
        _passwordTF = [[DLTextFeild alloc] initWithType:SetPasswordInput];
    }
    return _passwordTF;
}

- (DLTextFeild *)rePasswordTF
{
    if (!_rePasswordTF)
    {
        _rePasswordTF = [[DLTextFeild alloc] initWithType:ReSetPasswordInput];
    }
    return _rePasswordTF;
}

- (DLButton *)button
{
    if (!_button)
    {
        _button = [DLButton new];
        [_button setTitle:@"立即注册" forState:UIControlStateNormal];
        _button.layer.cornerRadius = 20;
        _button.backgroundColor = [UIColor blueColor];
    }
    return _button;
}

- (void)customerUI
{
    UIImageView *iconImg = [UIImageView new];
    iconImg.backgroundColor = [UIColor grayColor];
    [self addSubview:iconImg];
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(60);
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(120);
    }];
    
    UILabel *titleLb = [UILabel labelWithText:@"用户注册"
                                         font:[UIFont boldSystemFontOfSize:24]
                                    textColor:[UIColor blueColor]
                                    alignment:NSTextAlignmentCenter];
    [self addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconImg.mas_bottom).offset(6);
        make.centerX.equalTo(iconImg);
    }];
    
    UILabel *describeLb = [UILabel labelWithText:@"USER LOGIN"
                                            font:[UIFont systemFontOfSize:14]
                                       textColor:[UIColor jk_colorWithHexString:@"#666666"]
                                       alignment:NSTextAlignmentCenter];
    [self addSubview:describeLb];
    [describeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLb.mas_bottom).offset(6);
        make.centerX.equalTo(titleLb);
    }];
    
    [self addSubview:self.accountTF];
    [_accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(40);
        make.top.equalTo(describeLb.mas_bottom).offset(40);
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
    }];
    
    [self addSubview:self.codeTF];
    [_codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(40);
        make.top.equalTo(self.accountTF.mas_bottom).offset(30);
        make.left.equalTo(self.accountTF);
        make.right.equalTo(self).offset(-16);
    }];
    
    [self addSubview:self.passwordTF];
    [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(40);
        make.top.equalTo(self.codeTF.mas_bottom).offset(30);
        make.left.equalTo(self.codeTF);
        make.right.equalTo(self).offset(-16);
    }];
    
    [self addSubview:self.rePasswordTF];
    [_rePasswordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(40);
        make.top.equalTo(self.passwordTF.mas_bottom).offset(30);
        make.left.equalTo(self.passwordTF);
        make.right.equalTo(self).offset(-16);
    }];
    
    [self addSubview:self.button];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.height.equalTo(46);
        make.top.equalTo(self.rePasswordTF.mas_bottom).offset(40);
    }];
    
    [self addSubview:self.phoneLoginLb];
    [_phoneLoginLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.button.mas_bottom).offset(40);
    }];
    
}

@end
