//
//  WorkManageCarCell.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/15.
//

#import <UIKit/UIKit.h>
#import "CarstatisticsResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface WorkManageCarCell : UITableViewCell
+ (instancetype)cellWithCollectionView:(UITableView *)tableView;
- (void)loadViewWithModel:(CarstatisticsItemResponse *)model;
@end

NS_ASSUME_NONNULL_END
