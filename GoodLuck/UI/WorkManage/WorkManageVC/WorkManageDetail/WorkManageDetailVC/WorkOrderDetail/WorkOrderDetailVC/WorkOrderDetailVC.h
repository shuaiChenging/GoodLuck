//
//  WorkOrderDetailVC.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/16.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface WorkOrderDetailVC : BaseVC
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *projectId;
@property (nonatomic, strong) RACSubject *subject;

@property (nonatomic, copy) NSString *plateNumber;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, copy) NSString *workType;
@end

NS_ASSUME_NONNULL_END
