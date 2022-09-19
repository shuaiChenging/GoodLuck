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
#import "WorkDetailResponse.h"
#import "WorkOrderStatisticsView.h"
#import "WorkStatisticsView.h"
NS_ASSUME_NONNULL_BEGIN

@interface WorkManageDetailHeaderView : UIView
@property (nonatomic, strong) WorkManageHandleView *handleView;
@property (nonatomic, strong) WorkManageDetalAdmiView *admiView;
@property (nonatomic, strong) WorkOrderStatisticsView *workOrderView;
@property (nonatomic, strong) WorkStatisticsView *workStatisicsView;
@property (nonatomic, strong) UILabel *currentPeople;
@property (nonatomic, strong) UIView *scanView;
@property (nonatomic, strong) UIView *carNumberView;

@property (nonatomic, strong) RACSubject *subject;

@property (nonatomic, copy) NSString *projectId;

- (void)loadOrderWithModel:(WorkOrderResponse *)response;

- (void)loadMapInfo:(WorkDetailResponse *)response;
@end

NS_ASSUME_NONNULL_END
