//
//  ApplyDeleteResponse.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/27.
//

#import "BaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface ApplyDeleteResponse : BaseResponse
@property (nonatomic, copy) NSString *applicant;
@property (nonatomic, copy) NSString *applicantId;
@property (nonatomic, copy) NSString *createBy;
@property (nonatomic, copy) NSString *created;
@property (nonatomic, copy) NSString *orderNo;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *projectId;
@property (nonatomic, copy) NSString *projectName;
@property (nonatomic, copy) NSString *reason;
@property (nonatomic, copy) NSString *status; /// NORMAL  DELETE  REJECT
@end

NS_ASSUME_NONNULL_END
