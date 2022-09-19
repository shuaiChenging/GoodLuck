//
//  WorkManageDetailNewVC.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/9/5.
//

#import "BaseVC.h"
#import "WorkListResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface WorkManageDetailNewVC : BaseVC
@property (nonatomic, strong) RACSubject *subject;
@property (nonatomic, strong) ProjectListResponse *response;
@end

NS_ASSUME_NONNULL_END
