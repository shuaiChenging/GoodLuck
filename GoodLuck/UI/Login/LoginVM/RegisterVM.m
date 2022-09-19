//
//  RegistVM.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/4.
//

#import "RegisterVM.h"

@implementation RegisterVM
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setUp];
    }
    return self;
}
- (void)setUp
{
    self.btnEnableSignal = [RACSignal combineLatest:@[RACObserve(self,account),RACObserve(self,code),RACObserve(self,setPassword),RACObserve(self,reSetPassword)] reduce:^id _Nonnull(NSString *account,NSString *code,NSString *setPassword,NSString *reSetPassword) {
        return @(account.length && code.length && setPassword.length && reSetPassword.length);
    }];
    
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSString *phoneNo = input[@"phoneNo"];
        NSString *code = input[@"code"];
        NSString *password = input[@"password"];
        NSString *rePassword = input[@"rePassword"];
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            PostRequest *request = [[PostRequest alloc] initWithRequestUrl:registerurl argument:@{@"phone":phoneNo,@"code":code,@"confirmPassword":rePassword,@"password":password}];
            [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
                [subscriber sendNext:@"1"];
                [subscriber sendCompleted];
            } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
                [subscriber sendCompleted];
            }];
            
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"结束了");
            }];
        }];
    }];
    
    [[self.loginCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue])
        {
            NSLog(@"正在执行中。。。");
        }
        else
        {
            NSLog(@"执行结束了");
        }
    }];
    
    self.sendCodeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSString *phoneNo = input[@"phoneNo"];
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [SVProgressHUD showWithStatus:@"发送中..."];
            GetRequest *request = [[GetRequest alloc] initWithRequestUrl:smscode argument:@{@"phone":phoneNo,@"type":@"REGISTER"}];
            [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
                if (success)
                {
                    [subscriber sendNext:@"1"];
                    [SVProgressHUD dismiss];
                }
                [subscriber sendCompleted];
            } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
                [subscriber sendCompleted];
                [SVProgressHUD dismiss];
            }];
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"结束了");
            }];
        }];
    }];
    
    [[self.sendCodeCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue])
        {
            NSLog(@"正在执行中。。。");
        }
        else
        {
            NSLog(@"执行结束了");
        }
    }];
}
@end
