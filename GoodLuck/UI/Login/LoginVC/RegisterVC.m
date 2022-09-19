//
//  RegistVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/4.
//

#import "RegisterVC.h"
#import "RegisterView.h"
#import "RegisterVM.h"
@interface RegisterVC ()
@property (nonatomic, strong) RegisterView *registerView;
@property (nonatomic, strong) RegisterVM *registerVM;
@property (nonatomic, strong) RACDisposable *disposable;
@property (nonatomic, assign) int time;
@end

@implementation RegisterVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self customerUI];
    [self registerInit];
}

- (void)registerInit
{
    self.time = 60;
    RAC(self.registerVM,account) = self.registerView.accountTF.textField.rac_textSignal;
    RAC(self.registerVM,code) = self.registerView.codeTF.textField.rac_textSignal;
    RAC(self.registerVM,setPassword) = self.registerView.passwordTF.textField.rac_textSignal;
    RAC(self.registerVM,reSetPassword) = self.registerView.rePasswordTF.textField.rac_textSignal;
    RAC(self.registerView.button,enabled) = self.registerVM.btnEnableSignal;
    
    @weakify(self);
    [self.registerVM.btnEnableSignal subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.registerView.button setBackgroundColor:[x boolValue] ? [UIColor jk_colorWithHexString:COLOR_BLUE] : [UIColor jk_colorWithHexString:COLOR_94BCF7]];
    }];
    
    [self.registerView.accountTF.textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        if (x.length > 11)
        {
            self.registerView.accountTF.textField.text = [x substringToIndex:11];
        }
    }];
    
    [self.registerVM.sendCodeCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self codeBtHandle];
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"短信发送成功"];
    }];
    
    [self.registerVM.loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"注册成功"];
    }];
    
    [[self.registerView.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (!self.registerView.isSeleted)
        {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请勾选同意用户协议"];
            return;
        }
        [self.registerVM.loginCommand execute:@{@"phoneNo":self.registerView.accountTF.textField.text,@"code":self.registerView.codeTF.textField.text,@"password":self.registerView.passwordTF.textField.text,@"rePassword":self.registerView.rePasswordTF.textField.text}];
    }];
    
    [[self.registerView.codeTF.sendCode rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if ([Tools isEmpty:self.registerView.accountTF.textField.text])
        {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入手机号！"];
            return;
        }
        else if (self.registerView.accountTF.textField.text.length != 11)
        {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入正确的手机号！"];
            return;
        }
        [self.registerVM.sendCodeCommand execute:@{@"phoneNo":self.registerView.accountTF.textField.text}];
    }];
    
    [self.registerView.phoneLoginLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

- (void)codeBtHandle
{
    self.registerView.codeTF.sendCode.enabled = NO;
    @weakify(self);
    self.disposable = [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
        @strongify(self);
        self.time --;
        if (self.time > 0)
        {
            [self.registerView.codeTF.sendCode setTitle:[NSString stringWithFormat:@"%dS后重新获取",self.time] forState:UIControlStateDisabled];
        }
        else
        {
            [self.disposable dispose];
            self.time = 60;
            [self.registerView.codeTF.sendCode setTitle:@"重新发送" forState:UIControlStateNormal];
            self.registerView.codeTF.sendCode.enabled = YES;
        }
    }];
}

- (RegisterVM *)registerVM
{
    if (!_registerVM)
    {
        _registerVM = [RegisterVM new];
    }
    return _registerVM;
}

- (RegisterView *)registerView
{
    if (!_registerView)
    {
        _registerView = [RegisterView new];
    }
    return _registerView;
}

- (void)customerUI
{
    [self.view addSubview:self.registerView];
    [_registerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

@end
