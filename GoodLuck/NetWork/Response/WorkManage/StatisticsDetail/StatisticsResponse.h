//
//  StatisticsResponse.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/6.
//

#import "BaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface WorkerItem : BaseResponse
@property (nonatomic, copy) NSString *ztcName;
@property (nonatomic, copy) NSString *tlxName;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *ztcId;
@end

@interface WorkerItemType : BaseResponse
@property (nonatomic, copy) NSString *workType;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, strong) NSArray *details;
@end

@interface WorkerTypeResponse : BaseResponse
@property (nonatomic, copy) NSString *workerOrderCount;
@property (nonatomic, strong) NSArray *details;
@end

@interface CustomtcStatisticsResponse : BaseResponse
@property (nonatomic, copy) NSString *ztcCount;
@property (nonatomic, copy) NSString *workerOrderCount;
@property (nonatomic, strong) NSArray *details;
@end

@interface InnerMobileResponse : BaseResponse
@property (nonatomic, copy) NSString *zdCount;
@property (nonatomic, copy) NSString *ztcCount;
@property (nonatomic, copy) NSString *ytCount;
@property (nonatomic, copy) NSString *sumBodySize;
@property (nonatomic, copy) NSString *finishCount;
@property (nonatomic, copy) NSString *projectName;
@property (nonatomic, copy) NSString *projectId;
@property (nonatomic, strong) CustomtcStatisticsResponse *customtcStatistics;
@property (nonatomic, strong) WorkerTypeResponse *workerTypeStatistics;
@end

@interface StatisticsResponse : BaseResponse
@property (nonatomic, copy) NSString *sumBodySize;
@property (nonatomic, copy) NSString *finishCount;
@property (nonatomic, copy) NSString *openCount;
@property (nonatomic, copy) NSString *ytCount;
@property (nonatomic, strong) NSArray *innerMobileProjectStatistics;
@end

NS_ASSUME_NONNULL_END
