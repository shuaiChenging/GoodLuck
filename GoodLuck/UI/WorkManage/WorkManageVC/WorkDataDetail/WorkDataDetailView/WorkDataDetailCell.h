//
//  WorkDataDetailCell.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/4.
//

#import <UIKit/UIKit.h>
#import "StatisticsResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface WorkDataDetailCell : UITableViewCell
+ (instancetype)cellWithCollectionView:(UITableView *)tableView;
- (void)loadViewWithModel:(WorkerItem *)model;
@end

NS_ASSUME_NONNULL_END
