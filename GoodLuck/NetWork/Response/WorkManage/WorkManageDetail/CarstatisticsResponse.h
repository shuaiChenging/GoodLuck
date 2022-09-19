//
//  CarstatisticsResponse.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/30.
//

#import <Foundation/Foundation.h>
#import "BaseResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface CarstatisticsItemResponse : BaseResponse
@property (nonatomic, copy) NSString *plateNumber;
@property (nonatomic, copy) NSString *orderNo;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *driverName;
@property (nonatomic, copy) NSString *ztcId;
@property (nonatomic, copy) NSString *ztcName;
@property (nonatomic, copy) NSString *outTime;
@property (nonatomic, copy) NSString *outCarHeaderImg;
@property (nonatomic, copy) NSString *inCarHeaderImg;
@end

@interface CarstatisticsResponse : BaseResponse
@property (nonatomic, copy) NSString *outCount;
@property (nonatomic, copy) NSString *allCount;
@property (nonatomic, copy) NSString *inReleaseDate;
@property (nonatomic, copy) NSString *inCount;
@property (nonatomic, strong) NSArray *plateNumberMap;
@property (nonatomic, assign) BOOL isSeleted;
@end

NS_ASSUME_NONNULL_END
