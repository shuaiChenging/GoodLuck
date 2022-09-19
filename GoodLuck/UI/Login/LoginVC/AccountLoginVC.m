//
//  AccountLoginVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/4.
//

#import "AccountLoginVC.h"
#import "AccountLoginView.h"
#import "AccountLoginVM.h"
#import "AppDelegate.h"
#import "RegisterVC.h"
#import "LoginVC.h"
@interface AccountLoginVC ()
@property (nonatomic, strong) AccountLoginView *accountLoginView;
@property (nonatomic, strong) AccountLoginVM *accountLoginVM;
@end

@implementation AccountLoginVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self customerUI];
    [self accountLoginInit];
}

- (void)accountLoginInit
{
    RAC(self.accountLoginVM,account) = self.accountLoginView.accountTF.textField.rac_textSignal;
    RAC(self.accountLoginVM,password) = self.accountLoginView.passwordTF.textField.rac_textSignal;
    RAC(self.accountLoginView.button,enabled) = self.accountLoginVM.btnEnableSignal;
    @weakify(self);
    [self.accountLoginVM.btnEnableSignal subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.accountLoginView.button setBackgroundColor:[x boolValue] ? [UIColor jk_colorWithHexString:COLOR_BLUE] : [UIColor jk_colorWithHexString:COLOR_94BCF7]];
    }];
    
    [self.accountLoginView.accountTF.textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        if (x.length > 11)
        {
            self.accountLoginView.accountTF.textField.text = [x substringToIndex:11];
        }
    }];
    
    [self.accountLoginVM.loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        [[[UIApplication sharedApplication] delegate] performSelector:@selector(tabbarMainView)];
    }];
    
    [[self.accountLoginView.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.accountLoginView.accountTF.textField.text.length != 11)
        {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入正确的账号"];
            return;
        }
        [self.accountLoginVM.loginCommand execute:@{@"phoneNo":self.accountLoginView.accountTF.textField.text,@"code":self.accountLoginView.passwordTF.textField.text}];
    }];

    [self.accountLoginView.phoneLoginLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        @strongify(self);
        LoginVC *loginVC = [LoginVC new];
        [self.navigationController pushViewController:loginVC animated:YES];
    }];
    
    [self.accountLoginView.regiestLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        @strongify(self);
        RegisterVC *registerVC = [RegisterVC new];
        [self.navigationController pushViewController:registerVC animated:YES];
    }];
}

- (AccountLoginView *)accountLoginView
{
    if (!_accountLoginView)
    {
        _accountLoginView = [AccountLoginView new];
    }
    return _accountLoginView;
}

- (AccountLoginVM *)accountLoginVM
{
    if (!_accountLoginVM)
    {
        _accountLoginVM = [AccountLoginVM new];
    }
    return _accountLoginVM;
}

- (void)customerUI
{
    [self.view addSubview:self.accountLoginView];
    [_accountLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

@end
