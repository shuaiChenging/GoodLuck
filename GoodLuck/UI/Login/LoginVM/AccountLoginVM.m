//
//  AccountLoginVM.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/3.
//

#import "AccountLoginVM.h"
#import "LoginInfoManage.h"
@implementation AccountLoginVM
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
    self.btnEnableSignal = [RACSignal combineLatest:@[RACObserve(self,account),RACObserve(self, password)] reduce:^id _Nonnull(NSString *account,NSString *password) {
        return @(account.length && password.length);
    }];
    
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSString *phoneNo = input[@"phoneNo"];
        NSString *code = input[@"code"];
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            PostRequest *request = [[PostRequest alloc] initWithRequestUrl:phonelogin argument:@{@"phone":phoneNo,@"password":code}];
            [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
                if (success)
                {
                    [LoginInfoManage shareInstance].token = result[@"data"];
                    [DDDataStorageManage userDefaultsSaveObject:result[@"data"] forKey:TOKENKEY];
                    [subscriber sendNext:@"1"];
                }
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
}
@end
