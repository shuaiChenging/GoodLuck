//
//  WorkDetailCardTeamResponse.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/1.
//

#import "BaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface WorkDetailCardItem : BaseResponse
@property (nonatomic, copy) NSString *orderCount;
@property (nonatomic, copy) NSString *plateNumber;
@end

@interface WorkDetailCardTeamListResponse : BaseResponse
@property (nonatomic, copy) NSString *fleetName;
@property (nonatomic, copy) NSString *carCount;
@property (nonatomic, copy) NSString *orderCount;
@property (nonatomic, strong) NSArray *fleetDetails;
@end

@interface WorkDetailCardTeamResponse : BaseResponse
@property (nonatomic, copy) NSString *carCount;
@property (nonatomic, copy) NSString *orderCount;
@property (nonatomic, strong) NSArray *list;
@end

NS_ASSUME_NONNULL_END
