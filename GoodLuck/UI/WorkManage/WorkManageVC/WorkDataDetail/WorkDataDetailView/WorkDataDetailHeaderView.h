//
//  WorkDataDetailHeaderView.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/4.
//

#import <UIKit/UIKit.h>
#import "StatisticsResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface WorkDataDetailHeaderView : UIView
@property (nonatomic, strong) UILabel *myDataLb;
@property (nonatomic, strong) RACSubject *subject;
- (void)loadViewWithModel:(StatisticsResponse *)model isFirstLoad:(BOOL)isFirstLoad;
- (void)loadViewWithInnerModel:(InnerMobileResponse *)model;
@end

NS_ASSUME_NONNULL_END
