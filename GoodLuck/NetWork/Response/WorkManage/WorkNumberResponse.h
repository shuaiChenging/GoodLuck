//
//  WorkNumberResponse.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/8/29.
//

#import "BaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface WorkNumberResponse : BaseResponse
@property (nonatomic, assign) long orderApplyCount;
@property (nonatomic, assign) long roleApplyCount;
@end

NS_ASSUME_NONNULL_END
