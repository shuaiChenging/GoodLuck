//
//  RegistView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/4.
//

#import "RegisterView.h"
#import "WebViewVC.h"
@interface RegisterView ()<UITextViewDelegate>
@property (nonatomic, strong) GLImageView *seletedImg;
@end
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

- (GLImageView *)seletedImg
{
    if (!_seletedImg)
    {
        _seletedImg = [GLImageView new];
        _seletedImg.backgroundColor = [UIColor jk_colorWithHexString:COLOR_E6E6E6];
        _seletedImg.userInteractionEnabled = YES;
    }
    return _seletedImg;
}

- (UILabel *)phoneLoginLb
{
    if (!_phoneLoginLb)
    {
        _phoneLoginLb = [UILabel labelWithText:@"已有账户，立即登录"
                                          font:[UIFont systemFontOfSize:font_16]
                                     textColor:[UIColor jk_colorWithHexString:COLOR_242424]
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
    
    UILabel *titleLb = [UILabel labelWithText:@"用户注册"
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
    
    [self addSubview:self.codeTF];
    [_codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(40);
        make.top.equalTo(self.accountTF.mas_bottom).offset(24);
        make.left.equalTo(self.accountTF);
        make.right.equalTo(self).offset(-16);
    }];
    
    [self addSubview:self.passwordTF];
    [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(40);
        make.top.equalTo(self.codeTF.mas_bottom).offset(24);
        make.left.equalTo(self.codeTF);
        make.right.equalTo(self).offset(-16);
    }];
    
    [self addSubview:self.rePasswordTF];
    [_rePasswordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(40);
        make.top.equalTo(self.passwordTF.mas_bottom).offset(24);
        make.left.equalTo(self.passwordTF);
        make.right.equalTo(self).offset(-16);
    }];
    
    [self addSubview:self.seletedImg];
    WeakSelf(self)
    [_seletedImg jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        weakself.isSeleted = !weakself.isSeleted;
        weakself.seletedImg.image = [UIImage imageNamed: weakself.isSeleted ? @"register_seleted_icon" : @""];
    }];
    [_seletedImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(17));
        make.left.equalTo(self).offset(16);
        make.top.equalTo(self.rePasswordTF.mas_bottom).offset(26);
    }];
    
    [self addSubview:self.button];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.height.equalTo(46);
        make.top.equalTo(self.seletedImg.mas_bottom).offset(30);
    }];
    
    UITextView *textView = [UITextView new];
    textView.backgroundColor = [UIColor whiteColor];
    NSString *str = @"勾选同意《用户服务协议》和《隐私协议》";
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:str];
        [attribute addAttribute:NSLinkAttributeName value:@"agreement" range:[str rangeOfString:@"《用户服务协议》"]];
        [attribute addAttribute:NSLinkAttributeName value:@"privacy" range:[str rangeOfString:@"《隐私协议》"]];
    textView.attributedText = attribute;
    textView.linkTextAttributes = @{ NSForegroundColorAttributeName:[UIColor jk_colorWithHexString:COLOR_BLUE]};
    textView.editable = NO;
    textView.delegate = self;
    textView.textColor = [UIColor jk_colorWithHexString:COLOR_242424];
    textView.font = [UIFont systemFontOfSize:font_14];
    [self addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.seletedImg.mas_right);
        make.top.equalTo(self.rePasswordTF.mas_bottom).offset(18);
        make.right.equalTo(self);
        make.bottom.equalTo(self.button.mas_top);
    }];
    
    [self addSubview:self.phoneLoginLb];
    [_phoneLoginLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.button.mas_bottom).offset(30);
    }];
    
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction
{
    if([URL.absoluteString isEqualToString:@"agreement"])
    {
        WebViewVC *webVC = [WebViewVC new];
        webVC.title = @"用户服务协议";
        webVC.webUrl = SERVICEURL;
        [[Tools getTopMostController].navigationController pushViewController:webVC animated:YES];
    }
    else if ([URL.absoluteString isEqualToString:@"privacy"])
    {
        WebViewVC *webVC = [WebViewVC new];
        webVC.title = @"隐私协议";
        webVC.webUrl = PRIVACY;
        [[Tools getTopMostController].navigationController pushViewController:webVC animated:YES];
    }
    return YES;
}

@end
