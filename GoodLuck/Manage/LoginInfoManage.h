//
//  LoginInfoManage.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginInfoManage : NSObject
+ (instancetype)shareInstance;

@property (nonatomic, copy) NSString *token;

@property (nonatomic, assign) BOOL isBoss;
@end

NS_ASSUME_NONNULL_END
