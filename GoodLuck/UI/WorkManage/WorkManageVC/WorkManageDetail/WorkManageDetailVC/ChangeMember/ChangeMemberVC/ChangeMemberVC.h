//
//  ChangeMemberVC.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/6.
//

#import "BaseVC.h"
#import "MemberManageResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface ChangeMemberVC : BaseVC
@property (nonatomic, strong) MemberManageResponse *response;
@property (nonatomic, copy) NSString *projectId;
@property (nonatomic, strong) RACSubject *subject;
@end

NS_ASSUME_NONNULL_END
