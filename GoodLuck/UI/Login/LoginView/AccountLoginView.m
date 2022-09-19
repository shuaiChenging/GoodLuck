//
//  AccountLoginView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/5/31.
//

#import "AccountLoginView.h"

@implementation AccountLoginView

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
        _phoneLoginLb = [UILabel labelWithText:@"手机号登录"
                                          font:[UIFont systemFontOfSize:font_16]
                                     textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                     alignment:NSTextAlignmentLeft];
        _phoneLoginLb.userInteractionEnabled = YES;
    }
    return _phoneLoginLb;
}

- (UILabel *)regiestLb
{
    if (!_regiestLb)
    {
        _regiestLb =  [UILabel labelWithText:@"账号注册"
                                        font:[UIFont systemFontOfSize:font_16]
                                   textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                   alignment:NSTextAlignmentRight];
        _regiestLb.userInteractionEnabled = YES;
    }
    return _regiestLb;
}

- (DLTextFeild *)accountTF
{
    if (!_accountTF)
    {
        _accountTF = [[DLTextFeild alloc] initWithType:UserInput];
//        _accountTF.textField.text = @"15952414057";
    }
    return _accountTF;
}

- (DLTextFeild *)passwordTF
{
    if (!_passwordTF)
    {
        _passwordTF = [[DLTextFeild alloc] initWithType:PasswordInput];
//        _passwordTF.textField.text = @"123456";
    }
    return _passwordTF;
}

- (DLButton *)button
{
    if (!_button)
    {
        _button = [DLButton new];
        [_button setTitle:@"登录" forState:UIControlStateNormal];
        _button.layer.cornerRadius = 20;
        _button.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
    }
    return _button;
}


- (void)customerUI
{
    UIImageView *iconImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_icon"]];
    [self addSubview:iconImg];
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(130);
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(80);
    }];
    
    UILabel *titleLb = [UILabel labelWithText:@"用户登录"
                                         font:[UIFont boldSystemFontOfSize:maxFont]
                                    textColor:[UIColor jk_colorWithHexString:COLOR_BLUE]
                                    alignment:NSTextAlignmentCenter];
    [self addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconImg.mas_bottom);
        make.centerX.equalTo(iconImg);
    }];
    
    [self addSubview:self.accountTF];
    [_accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(40);
        make.top.equalTo(titleLb.mas_bottom).offset(40);
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
    }];
    
    [self addSubview:self.passwordTF];
    [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(40);
        make.top.equalTo(self.accountTF.mas_bottom).offset(20);
        make.left.equalTo(self.accountTF);
        make.right.equalTo(self).offset(-16);
    }];
    
    [self addSubview:self.button];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.height.equalTo(46);
        make.top.equalTo(self.passwordTF.mas_bottom).offset(40);
    }];
    
    [self addSubview:self.phoneLoginLb];
    [_phoneLoginLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(40);
        make.top.equalTo(self.button.mas_bottom).offset(40);
    }];
    
    [self addSubview:self.regiestLb];
    [_regiestLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-40);
        make.centerY.equalTo(self.phoneLoginLb);
    }];
    
}
@end
