//
//  ForgetPasswordVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/4.
//

#import "ForgetPasswordVC.h"
#import "DLTextFeild.h"
#import "LoginInfoManage.h"
@interface ForgetPasswordVC ()
@property (nonatomic, strong) DLTextFeild *passwordTF;
@property (nonatomic, strong) DLTextFeild *newPasswordTF;
@property (nonatomic, strong) DLButton *button;
@end

@implementation ForgetPasswordVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"修改密码";
    [self customerUI];
}

- (DLTextFeild *)passwordTF
{
    if (!_passwordTF)
    {
        _passwordTF = [[DLTextFeild alloc] initWithType:SetPasswordInput];
    }
    return _passwordTF;
}

- (DLTextFeild *)newPasswordTF
{
    if (!_newPasswordTF)
    {
        _newPasswordTF = [[DLTextFeild alloc] initWithType:ReSetPasswordInput];
    }
    return _newPasswordTF;
}

- (DLButton *)button
{
    if (!_button)
    {
        _button = [DLButton new];
        [_button setTitle:@"提交" forState:UIControlStateNormal];
        _button.layer.cornerRadius = 20;
        _button.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
    }
    return _button;
}

- (void)customerUI
{
    UIView *backView = [UIView new];
    backView.layer.cornerRadius = 5;
    backView.layer.masksToBounds = YES;
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.right.equalTo(self.view).offset(-16);
        make.top.equalTo(self.view).offset(16);
        make.height.equalTo(100);
    }];
    
    [backView addSubview:self.passwordTF];
    [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(50);
        make.top.equalTo(backView);
        make.left.equalTo(backView).offset(16);
        make.right.equalTo(backView).offset(-16);
    }];
    
    [backView addSubview:self.newPasswordTF];
    [_newPasswordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(50);
        make.top.equalTo(self.passwordTF.mas_bottom);
        make.left.equalTo(backView).offset(16);
        make.right.equalTo(backView).offset(-16);
    }];
    
    [self.view addSubview:self.button];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.right.equalTo(self.view).offset(-16);
        make.height.equalTo(46);
        make.top.equalTo(backView.mas_bottom).offset(40);
    }];
    WeakSelf(self)
    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself sendRequest];
    }];
}

- (void)sendRequest
{
    if ([Tools isEmpty:self.passwordTF.textField.text])
    {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请设置密码"];
        return;
    }
    
    if ([Tools isEmpty:self.newPasswordTF.textField.text])
    {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请再次输入密码"];
        return;
    }
    
    if (![self.passwordTF.textField.text isEqualToString:self.newPasswordTF.textField.text])
    {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"两次输入密码不一致"];
        return;
    }
    
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:resetpassword argument:@{@"resetPassword":self.passwordTF.textField.text}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"修改成功"];
            [LoginInfoManage shareInstance].token = @"";
            [Tools logout];
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

@end
