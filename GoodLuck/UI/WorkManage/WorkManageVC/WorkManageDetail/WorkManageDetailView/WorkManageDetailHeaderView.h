//
//  WorkManageDetailHeaderView.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/5.
//

#import <UIKit/UIKit.h>
#import "WorkManageHandleView.h"
#import "WorkManageDetalAdmiView.h"
#import "WorkOrderResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface WorkManageDetailHeaderView : UIView
@property (nonatomic, strong) WorkManageHandleView *handleView;
@property (nonatomic, strong) WorkManageDetalAdmiView *admiView;
@property (nonatomic, strong) UILabel *currentPeople;
@property (nonatomic, strong) UIView *scanView;

- (void)loadOrderWithModel:(WorkOrderResponse *)response;
@end

NS_ASSUME_NONNULL_END
