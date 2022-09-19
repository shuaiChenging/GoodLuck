//
//  LoginVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/5/31.
//

#import "LoginVC.h"
#import "PhoneLoginView.h"
#import "PhoneLoginVM.h"
#import "AccountLoginVC.h"
#import "RegisterVC.h"
#import "AppDelegate.h"
@interface LoginVC ()
@property (nonatomic, strong) PhoneLoginView *phoneLoginView;
@property (nonatomic, strong) PhoneLoginVM *phoneLoginVM;
@property (nonatomic, assign) int time;
@property (nonatomic, strong) RACDisposable *disposable;
@end

@implementation LoginVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self customerUI];
    [self phoneLoginInit];
}

- (void)phoneLoginInit
{
    self.time = 60;
    RAC(self.phoneLoginVM,account) = self.phoneLoginView.accountTF.textField.rac_textSignal;
    RAC(self.phoneLoginVM,code) = self.phoneLoginView.codeTF.textField.rac_textSignal;
    RAC(self.phoneLoginView.button,enabled) = self.phoneLoginVM.btnEnableSignal;
    
    @weakify(self);
    [self.phoneLoginVM.btnEnableSignal subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.phoneLoginView.button setBackgroundColor:[x boolValue] ? [UIColor jk_colorWithHexString:COLOR_BLUE] : [UIColor jk_colorWithHexString:COLOR_94BCF7]];
    }];
    
    [self.phoneLoginView.accountTF.textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        if (x.length > 11)
        {
            self.phoneLoginView.accountTF.textField.text = [x substringToIndex:11];
        }
    }];
    
    [self.phoneLoginVM.sendCodeCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self codeBtHandle];
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"短信发送成功"];
    }];
    
    [self.phoneLoginVM.loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        [[[UIApplication sharedApplication] delegate] performSelector:@selector(tabbarMainView)];
        
//        [((AppDelegate *)[UIApplication sharedApplication].delegate) tabbarMainView];
    }];
    
    [[self.phoneLoginView.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.phoneLoginVM.loginCommand execute:@{@"phoneNo":self.phoneLoginView.accountTF.textField.text,@"code":self.phoneLoginView.codeTF.textField.text}];
    }];
    
    [[self.phoneLoginView.codeTF.sendCode rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if ([Tools isEmpty:self.phoneLoginView.accountTF.textField.text])
        {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入手机号！"];
            return;
        }
        else if (self.phoneLoginView.accountTF.textField.text.length != 11)
        {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入正确的手机号！"];
            return;
        }
        
        [self.phoneLoginVM.sendCodeCommand execute:@{@"phoneNo":self.phoneLoginView.accountTF.textField.text}];
    }];
    
    [self.phoneLoginView.accountLoginLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self.phoneLoginView.registLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        @strongify(self);
        RegisterVC *registerVC = [RegisterVC new];
        [self.navigationController pushViewController:registerVC animated:YES];
    }];
}

- (void)codeBtHandle
{
    self.phoneLoginView.codeTF.sendCode.enabled = NO;
    @weakify(self);
    self.disposable = [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
        @strongify(self);
        self.time --;
        if (self.time > 0)
        {
            [self.phoneLoginView.codeTF.sendCode setTitle:[NSString stringWithFormat:@"%dS后重新获取",self.time] forState:UIControlStateDisabled];
        }
        else
        {
            [self.disposable dispose];
            self.time = 60;
            [self.phoneLoginView.codeTF.sendCode setTitle:@"重新发送" forState:UIControlStateNormal];
            self.phoneLoginView.codeTF.sendCode.enabled = YES;
        }
    }];
}

- (PhoneLoginVM *)phoneLoginVM
{
    if (!_phoneLoginVM)
    {
        _phoneLoginVM = [PhoneLoginVM new];
    }
    return _phoneLoginVM;
}

- (PhoneLoginView *)phoneLoginView
{
    if (!_phoneLoginView)
    {
        _phoneLoginView = [PhoneLoginView new];
    }
    return _phoneLoginView;
}

- (void)customerUI
{
    [self.view addSubview:self.phoneLoginView];
    [_phoneLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

@end
