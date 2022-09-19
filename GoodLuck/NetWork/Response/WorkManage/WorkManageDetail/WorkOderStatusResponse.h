//
//  WorkOderStatusResponse.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/10.
//

#import "BaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface WorkOderStatusResponse : BaseResponse
@property (nonatomic, assign) int scanCount;
@property (nonatomic, copy) NSString *status;
@end

NS_ASSUME_NONNULL_END
