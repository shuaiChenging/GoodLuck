//
//  WorkDataDetailSectionHeaderView.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/4.
//

#import <UIKit/UIKit.h>
#import "StatisticsResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface WorkDataDetailSectionHeaderView : UIView
- (void)loadViewWithCustomModel:(CustomtcStatisticsResponse *)customModel
                workerTypeModel:(WorkerTypeResponse *)workerModel
                          isZTC:(BOOL)isZTC;
@end

NS_ASSUME_NONNULL_END
