//
//  WorkConfigResponse.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/11.
//

#import "BaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface WorkConfigResponse : BaseResponse
@property (nonatomic, assign) int pointCount;
@property (nonatomic, assign) BOOL isWarnByIdentify;
@property (nonatomic, assign) BOOL isRememberLastConfig;
@property (nonatomic, assign) BOOL inTwoOnWork; /// 管理员不在工地2公里范围，无法上班
@end

NS_ASSUME_NONNULL_END
