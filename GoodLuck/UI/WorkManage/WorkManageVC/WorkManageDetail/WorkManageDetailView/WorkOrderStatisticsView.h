//
//  WorkOrderStatisticsView.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/5.
//

#import <UIKit/UIKit.h>
#import "WorkOrderResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface WorkOrderStatisticsView : UIView
- (void)loadOrderWithModel:(WorkOrderResponse *)response;
@end

NS_ASSUME_NONNULL_END
