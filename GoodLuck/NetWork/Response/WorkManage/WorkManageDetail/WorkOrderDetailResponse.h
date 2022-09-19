//
//  WorkOrderDetailResponse.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/29.
//

#import "BaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface WorkOrderDetailResponse : BaseResponse
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *orderNo;
@property (nonatomic, copy) NSString *plateNumber;
@property (nonatomic, copy) NSString *inReleaser;
@property (nonatomic, copy) NSString *fleetName;
@property (nonatomic, copy) NSString *workType;
@property (nonatomic, copy) NSString *deleteFlag; /// DELETED 删除 NORMAL 正常
@property (nonatomic, copy) NSString *isException; /// FALSE 正常 TURE异常

@property (nonatomic, copy) NSString *updater; /// 删除人
@property (nonatomic, copy) NSString *updated; /// 删除时间

@property (nonatomic, copy) NSString *inReleaserTime; /// 入场日期
@property (nonatomic, copy) NSString *outReleaserTime; /// 出场日期
///
@property (nonatomic, copy) NSString *workTypeDate; /// 班次时间
@property (nonatomic, copy) NSString *ztcName;
@property (nonatomic, copy) NSString *exception; /// 异常原因
@property (nonatomic, copy) NSString *outReleaser;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *created;
@property (nonatomic, copy) NSString *modifyReason;
@end

NS_ASSUME_NONNULL_END
