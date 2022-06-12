//
//  PhoneLoginVM.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/3.
//

#import "PhoneLoginVM.h"
#import "LoginInfoManage.h"
@interface PhoneLoginVM ()

@end
@implementation PhoneLoginVM
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
    self.btnEnableSignal = [RACSignal combineLatest:@[RACObserve(self,account),RACObserve(self, code)] reduce:^id _Nonnull(NSString * account,NSString * code) {
        return @(account.length && code.length);
    }];
    
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSString *phoneNo = input[@"phoneNo"];
        NSString *code = input[@"code"];
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            PostRequest *request = [[PostRequest alloc] initWithRequestUrl:smslogin argument:@{@"phone":phoneNo,@"code":code}];
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
    
    self.sendCodeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSString *phoneNo = input[@"phoneNo"];
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            GetRequest *request = [[GetRequest alloc] initWithRequestUrl:smscode argument:@{@"phone":phoneNo,@"type":@"LOGIN"}];
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
