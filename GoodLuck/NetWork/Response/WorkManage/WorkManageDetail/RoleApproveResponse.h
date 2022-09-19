//
//  RoleApproveResponse.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/26.
//

#import "BaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface RoleApproveResponse : BaseResponse
@property (nonatomic, copy) NSString *itemId;
@property (nonatomic, copy) NSString *projectId;
@property (nonatomic, copy) NSString *projectName;
@property (nonatomic, copy) NSString *tenantId;
@property (nonatomic, copy) NSString *tenantName;
@property (nonatomic, copy) NSString *tenantPhone;
@property (nonatomic, copy) NSString *status; /// APPROVED APPROVING REJECT
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *role;
@property (nonatomic, copy) NSString *descrip;
@property (nonatomic, copy) NSString *created;
@property (nonatomic, copy) NSString *bossName;
@end

NS_ASSUME_NONNULL_END
