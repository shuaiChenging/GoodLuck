//
//  OrderDetailResponse.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/6.
//

#import "BaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailResponse : BaseResponse
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *inReleaserDate;
@property (nonatomic, copy) NSString *plateNumber;
@property (nonatomic, copy) NSString *fleetName;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *orderNo;
@property (nonatomic, copy) NSString *projectName;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *driverName;
@property (nonatomic, copy) NSString *workType;
@property (nonatomic, copy) NSString *workTypeDate;
@property (nonatomic, copy) NSString *bodySize;
@property (nonatomic, copy) NSString *remark;

@property (nonatomic, copy) NSString *outReleaser;
@property (nonatomic, copy) NSString *outReleaserTime;

@property (nonatomic, copy) NSString *inReleaser;
@property (nonatomic, copy) NSString *inReleaserTime;

@property (nonatomic, copy) NSString *outCarHeaderImg;
@property (nonatomic, copy) NSString *outCarBodyImg;

@property (nonatomic, copy) NSString *inCarHeaderImg;
@property (nonatomic, copy) NSString *inCarBodyImg;

@property (nonatomic, copy) NSString *ztcName;
@property (nonatomic, copy) NSString *tlxName;

@property (nonatomic, copy) NSString *fleetId;
@property (nonatomic, copy) NSString *exception;
@property (nonatomic, assign) int weight;

@property (nonatomic, copy) NSString *companyName;

@property (nonatomic, copy) NSString *created;

@property (nonatomic, copy) NSString *deleteFlag;
@end

NS_ASSUME_NONNULL_END
