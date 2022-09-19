//
//  OrderStatisticsDeleteCell.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/18.
//

#import <UIKit/UIKit.h>
#import "WorkOrderDetailResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrderStatisticsDeleteCell : UITableViewCell
+ (instancetype)cellWithCollectionView:(UITableView *)tableView;
- (void)loadViewWithModel:(WorkOrderDetailResponse *)model;
@end

NS_ASSUME_NONNULL_END
