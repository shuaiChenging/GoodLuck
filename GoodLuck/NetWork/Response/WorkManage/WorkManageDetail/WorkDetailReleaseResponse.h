//
//  WorkDetailReleaseResponse.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/2.
//

#import "BaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface WorkDetailReleaseResponse : BaseResponse
@property (nonatomic, copy) NSString *outCarHeaderImg;
@property (nonatomic, copy) NSString *inCarHeaderImg;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *driverName;
@property (nonatomic, copy) NSString *outReleaserDate;
@property (nonatomic, copy) NSString *plateNumber;
@property (nonatomic, copy) NSString *ztcName;
@end

NS_ASSUME_NONNULL_END
