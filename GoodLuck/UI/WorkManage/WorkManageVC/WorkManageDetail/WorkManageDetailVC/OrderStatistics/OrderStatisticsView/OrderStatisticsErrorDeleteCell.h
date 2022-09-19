//
//  OrderStatisticsErrorDeleteCell.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/9/9.
//

#import <UIKit/UIKit.h>
#import "WorkOrderDetailResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrderStatisticsErrorDeleteCell : UITableViewCell
+ (instancetype)cellWithCollectionView:(UITableView *)tableView;
- (void)loadViewWithModel:(WorkOrderDetailResponse *)model;
@end

NS_ASSUME_NONNULL_END
