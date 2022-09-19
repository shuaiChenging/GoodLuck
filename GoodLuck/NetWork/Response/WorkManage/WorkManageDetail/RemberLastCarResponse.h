//
//  RemberLastCarResponse.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/9/1.
//

#import "BaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface RemberLastCarResponse : BaseResponse
@property (nonatomic, copy) NSString *fleetName;
@property (nonatomic, copy) NSString *tlxName;
@property (nonatomic, copy) NSString *ztcName;
@property (nonatomic, copy) NSString *bodySzie;
@property (nonatomic, copy) NSString *ztcId;
@property (nonatomic, copy) NSString *fleetId;
@property (nonatomic, copy) NSString *tlxId;
@end

NS_ASSUME_NONNULL_END
