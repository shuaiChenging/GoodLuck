//
//  WorkListCell.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/4.
//

#import <UIKit/UIKit.h>
#import "WorkListResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface WorkListCell : UITableViewCell
+ (instancetype)cellWithCollectionView:(UITableView *)tableView;
- (void)loadViewWithModel:(ProjectListResponse *)model;
@end

NS_ASSUME_NONNULL_END
