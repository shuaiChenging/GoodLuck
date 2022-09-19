//
//  WorkManageReleaseCell.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/2.
//

#import <UIKit/UIKit.h>
#import "WorkDetailReleaseResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface WorkManageReleaseCell : UITableViewCell
+ (instancetype)cellWithCollectionView:(UITableView *)tableView;
- (void)loadViewWithModel:(WorkDetailReleaseResponse *)model;
@end

NS_ASSUME_NONNULL_END
