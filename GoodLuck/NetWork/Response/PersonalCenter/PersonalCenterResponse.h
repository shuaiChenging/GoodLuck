//
//  PersonalCenterResponse.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/24.
//

#import "BaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonalCenterResponse : BaseResponse
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *tenantId;
@property (nonatomic, copy) NSString *approveStatus;
@end

NS_ASSUME_NONNULL_END
