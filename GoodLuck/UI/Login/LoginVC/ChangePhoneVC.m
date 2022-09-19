//
//  ChangePhoneVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/4.
//

#import "ChangePhoneVC.h"
#import "DLTextFeild.h"
#import "LoginInfoManage.h"
@interface ChangePhoneVC ()
@property (nonatomic, strong) DLTextFeild *codeTF;
@property (nonatomic, strong) DLTextFeild *phoneTF;
@property (nonatomic, strong) DLTextFeild *newCodeTF;
@property (nonatomic, strong) DLButton *button;
@property (nonatomic, assign) int time;
@property (nonatomic, strong) RACDisposable *disposable;
@end

@implementation ChangePhoneVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"修改手机号";
    self.time = 60;
    [self customerUI];
}

- (DLTextFeild *)codeTF
{
    if (!_codeTF)
    {
        _codeTF = [[DLTextFeild alloc] initWithType:UserInput];
        _codeTF.textField.placeholder = @"请输入原手机短信验证码";
    }
    return _codeTF;
}

- (DLTextFeild *)phoneTF
{
    if (!_phoneTF)
    {
        _phoneTF = [[DLTextFeild alloc] initWithType:UserInput];
        _phoneTF.textField.placeholder = @"请输入新手机号";
    }
    return _phoneTF;
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

- (DLTextFeild *)newCodeTF
{
    if (!_newCodeTF)
    {
        _newCodeTF = [[DLTextFeild alloc] initWithType:CodeInput];
        _newCodeTF.textField.placeholder = @"请输入新手机短息验证码";
    }
    return _newCodeTF;
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
        make.height.equalTo(150);
    }];
    
    [backView addSubview:self.codeTF];
    [_codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(50);
        make.top.equalTo(backView);
        make.left.equalTo(backView).offset(16);
        make.right.equalTo(backView).offset(-16);
    }];
    
    [backView addSubview:self.phoneTF];
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(50);
        make.top.equalTo(self.codeTF.mas_bottom);
        make.left.equalTo(backView).offset(16);
        make.right.equalTo(backView).offset(-16);
    }];
    WeakSelf(self)
    
    [backView addSubview:self.newCodeTF];
    [_newCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(50);
        make.top.equalTo(self.phoneTF.mas_bottom);
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
    
    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself sendRequest];
    }];
    
    [[self.newCodeTF.sendCode rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself sendCodeRequest];
    }];
}

- (void)sendCodeRequest
{
    if ([Tools isEmpty:self.phoneTF.textField.text])
    {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入新手机号"];
        return;
    }
    WeakSelf(self)
    [SVProgressHUD showWithStatus:@"发送中..."];
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:smscode argument:@{@"phone":self.phoneTF.textField.text,@"type":@"RESET_PHONE"}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            [weakself codeBtHandle];
            [SVProgressHUD dismiss];
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        [SVProgressHUD dismiss];
    }];
}

- (void)codeBtHandle
{
    self.newCodeTF.sendCode.enabled = NO;
    @weakify(self);
    self.disposable = [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
        @strongify(self);
        self.time --;
        if (self.time > 0)
        {
            [self.newCodeTF.sendCode setTitle:[NSString stringWithFormat:@"%dS后重新获取",self.time] forState:UIControlStateDisabled];
        }
        else
        {
            [self.disposable dispose];
            self.time = 60;
            [self.newCodeTF.sendCode setTitle:@"重新发送" forState:UIControlStateNormal];
            self.newCodeTF.sendCode.enabled = YES;
        }
    }];
}

- (void)sendRequest
{
    if ([Tools isEmpty:self.codeTF.textField.text])
    {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入原手机短信验证码"];
        return;
    }
    
    if ([Tools isEmpty:self.phoneTF.textField.text])
    {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入新手机号"];
        return;
    }
    
    if ([Tools isEmpty:self.newCodeTF.textField.text])
    {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入新手机短信验证码"];
        return;
    }
    WeakSelf(self)
    PostRequest *request = [[PostRequest alloc] initWithRequestUrl:changephone argument:@{@"oldPhone":[LoginInfoManage shareInstance].personalResponse.phone,
                                                                                          @"oldPhoneCode":self.codeTF.textField.text,
                                                                                          @"newPhone":self.phoneTF.textField.text,
                                                                                          @"newPhoneCode":self.newCodeTF.textField.text
                                                                                        }];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            [LoginInfoManage shareInstance].personalResponse.phone = self.phoneTF.textField.text;
            PersonalCenterResponse *respose = [LoginInfoManage shareInstance].personalResponse;
            [DDDataStorageManage userDefaultsSaveObject:@{@"name":respose.name,
                                                          @"phone":respose.phone,
                                                          @"approveStatus":respose.approveStatus,
                                                          @"tenantId":respose.tenantId} forKey:INFOKEY];
            [weakself.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

@end
