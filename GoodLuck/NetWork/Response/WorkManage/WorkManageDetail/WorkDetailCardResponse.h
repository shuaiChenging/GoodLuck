//
//  WorkDetailCardResponse.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/1.
//

#import "BaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface WorkDetailCardItemResponse : BaseResponse
@property (nonatomic, copy) NSString *plateNumber;
@property (nonatomic, copy) NSString *orderCount;
@end

@interface WorkDetailCardResponse : BaseResponse
@property (nonatomic, copy) NSString *carCount;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *fleetCount;
@property (nonatomic, copy) NSString *orderCount;
@property (nonatomic, copy) NSString *workType;
@property (nonatomic, copy) NSString *inReleaseDate;
@property (nonatomic, strong) NSArray *plateNumberMap;
@end

NS_ASSUME_NONNULL_END
