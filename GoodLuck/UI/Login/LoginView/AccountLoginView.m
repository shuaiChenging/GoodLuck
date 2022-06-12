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
        _phoneLoginLb = [UILabel labelWithText:@"手机快捷登录"
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
        _accountTF = [[DLTextFeild alloc] initWithType:UserInput];
        _accountTF.textField.text = @"15995754057";
    }
    return _accountTF;
}

- (DLTextFeild *)passwordTF
{
    if (!_passwordTF)
    {
        _passwordTF = [[DLTextFeild alloc] initWithType:PasswordInput];
        _passwordTF.textField.text = @"123456";
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
    
    UILabel *titleLb = [UILabel labelWithText:@"好运来"
                                         font:[UIFont boldSystemFontOfSize:24]
                                    textColor:[UIColor blueColor]
                                    alignment:NSTextAlignmentCenter];
    [self addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconImg.mas_bottom).offset(6);
        make.centerX.equalTo(iconImg);
    }];
    
    UILabel *describeLb = [UILabel labelWithText:@"建筑工程好管家"
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
    
    [self addSubview:self.passwordTF];
    [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(40);
        make.top.equalTo(self.accountTF.mas_bottom).offset(30);
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
    
}
@end
