//
//  LoginInfoManage.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/7.
//

#import "LoginInfoManage.h"

@implementation LoginInfoManage
+ (instancetype)shareInstance
{
    static LoginInfoManage * _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[LoginInfoManage alloc] init];
    });
    
    return _sharedInstance;
}
@end
