//
//  PhoneLoginView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/5/31.
//

#import "PhoneLoginView.h"

@interface PhoneLoginView ()

@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *describeLb;

@end
@implementation PhoneLoginView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self customerUI];
    }
    return self;
}

- (UILabel *)titleLb
{
    if (!_titleLb)
    {
        _titleLb = [UILabel labelWithText:@"手机登录好运来"
                                     font:[UIFont boldSystemFontOfSize:24]
                                textColor:nil
                                alignment:NSTextAlignmentLeft];
    }
    return _titleLb;
}

- (UILabel *)registLb
{
    if (!_registLb)
    {
        _registLb = [UILabel labelWithText:@"用户注册"
                                      font:[UIFont systemFontOfSize:16]
                                 textColor:nil
                                 alignment:NSTextAlignmentLeft];
        _registLb.userInteractionEnabled = YES;
    }
    return _registLb;
}

- (UILabel *)accountLoginLb
{
    if (!_accountLoginLb)
    {
        _accountLoginLb = [UILabel labelWithText:@"账号密码登录"
                                            font:[UIFont systemFontOfSize:16]
                                       textColor:nil
                                       alignment:NSTextAlignmentLeft];
        _accountLoginLb.userInteractionEnabled = YES;
    }
    return _accountLoginLb;
}

- (UILabel *)describeLb
{
    if (!_describeLb)
    {
        _describeLb = [UILabel labelWithText:@"验证即登录，未注册则自动创建新账号"
                                        font:[UIFont systemFontOfSize:14]
                                   textColor:[UIColor jk_colorWithHexString:@"#666666"]
                                   alignment:NSTextAlignmentLeft];
    }
    return _describeLb;
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
    [self addSubview:self.titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.top.equalTo(self).offset(120);
    }];
    
    [self addSubview:self.describeLb];
    [_describeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLb);
        make.top.equalTo(self.titleLb.mas_bottom).offset(10);
    }];
    
    [self addSubview:self.accountTF];
    [_accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(40);
        make.top.equalTo(self.describeLb.mas_bottom).offset(40);
        make.left.equalTo(self.titleLb);
        make.right.equalTo(self).offset(-16);
    }];
    
    [self addSubview:self.codeTF];
    [_codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(40);
        make.top.equalTo(self.accountTF.mas_bottom).offset(30);
        make.left.equalTo(self.titleLb);
        make.right.equalTo(self).offset(-16);
    }];
    
    [self addSubview:self.button];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.height.equalTo(46);
        make.top.equalTo(self.codeTF.mas_bottom).offset(40);
    }];
    
    [self addSubview:self.accountLoginLb];
    [_accountLoginLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(40);
        make.top.equalTo(self.button.mas_bottom).offset(40);
    }];
    
    [self addSubview:self.registLb];
    [_registLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-40);
        make.centerY.equalTo(self.accountLoginLb);
    }];
}

@end
