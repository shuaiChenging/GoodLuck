//
//  WorkManageSoilCell.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/15.
//

#import <UIKit/UIKit.h>
#import "WorkDetailSoilResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface WorkManageSoilCell : UITableViewCell
+ (instancetype)cellWithCollectionView:(UITableView *)tableView;
- (void)loadViewWithModel:(WorkDetailSoilItemResponse *)model;
@end

NS_ASSUME_NONNULL_END
