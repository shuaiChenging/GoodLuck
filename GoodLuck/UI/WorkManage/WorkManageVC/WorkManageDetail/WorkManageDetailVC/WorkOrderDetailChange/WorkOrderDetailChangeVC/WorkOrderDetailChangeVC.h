//
//  WorkOrderDetailChangeVC.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/4.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"
#import "OrderDetailResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface WorkOrderDetailChangeVC : BaseVC
@property (nonatomic, copy) NSString *projectId;
@property (nonatomic, strong) OrderDetailResponse *orderDetailResponse;
@property (nonatomic, strong) RACSubject *subject;
@end

NS_ASSUME_NONNULL_END
