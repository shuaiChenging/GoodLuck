//
//  WorkDetailSoilResponse.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/1.
//

#import "BaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface WorkDetailSoilItemResponse : BaseResponse
@property (nonatomic, copy) NSString *orderCount;
@property (nonatomic, copy) NSString *plateNumber;
@property (nonatomic, copy) NSString *ztcId;
@property (nonatomic, copy) NSString *ztcName;
@property (nonatomic, copy) NSString *fleetName;
@end

@interface WorkDetailSoilResponse : BaseResponse
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *orderCount;
@property (nonatomic, strong) NSArray *orderMap;
@end

NS_ASSUME_NONNULL_END
