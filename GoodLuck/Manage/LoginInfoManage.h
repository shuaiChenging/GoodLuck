//
//  LoginInfoManage.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/7.
//

#import <Foundation/Foundation.h>
#import "PersonalCenterResponse.h"
#import "WorkConfigResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface LoginInfoManage : NSObject
+ (instancetype)shareInstance;

@property (nonatomic, copy) NSString *token;

@property (nonatomic, assign) BOOL isBoss;

@property (nonatomic, strong) PersonalCenterResponse *personalResponse;
/// 蓝牙是否连接
@property (nonatomic, assign) BOOL isConnect;

@property (nonatomic, strong) WorkConfigResponse *workConfigResponse;

@property (nonatomic, assign) BOOL errorWorkOrder; /// 异常工单
@end

NS_ASSUME_NONNULL_END
