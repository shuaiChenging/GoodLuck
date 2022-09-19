//
//  WorkListResponse.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/7.
//

#import "BaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectListResponse : BaseResponse
@property (nonatomic, copy) NSString *projectId;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *workType; /// NIGHT_WORK 晚班  OFF_WORK 未上班  DAY_WORK 白班

@property (nonatomic, copy) NSString *finishCount;
@property (nonatomic, copy) NSString *ztcCount;
@property (nonatomic, copy) NSString *zdCount;
@property (nonatomic, copy) NSString *lsgdCount;

@property (nonatomic, copy) NSString *finishTodayCount;
@property (nonatomic, copy) NSString *inCount;
@property (nonatomic, copy) NSString *openProjectCount;

@property (nonatomic, copy) NSString *openTime;
@property (nonatomic, copy) NSString *companyId;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *latitude;
@end

@interface WorkListResponse : BaseResponse
@property (nonatomic, copy) NSString *openProjectCount;
@property (nonatomic, copy) NSString *lxgdCount;
@property (nonatomic, copy) NSString *ztcgdCount;
@property (nonatomic, copy) NSString *exceptionCount;
@property (nonatomic, copy) NSString *finishCount;
@property (nonatomic, copy) NSString *ztcCount;
@property (nonatomic, copy) NSString *zdCount;
@property (nonatomic, strong) NSArray *projectList;
@end



NS_ASSUME_NONNULL_END
