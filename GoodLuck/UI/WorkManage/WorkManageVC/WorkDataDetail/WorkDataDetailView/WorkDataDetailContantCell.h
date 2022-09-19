//
//  WorkDataDetailContantCell.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/14.
//

#import <UIKit/UIKit.h>
#import "StatisticsResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface WorkDataDetailContantCell : UITableViewCell
+ (instancetype)cellWithCollectionView:(UITableView *)tableView;
- (void)loadViewWithType:(BOOL)isZTCType ztcArr:(NSArray<WorkerItem *> *)ztcArr classArr:(NSArray<WorkerItemType *> *)classArr;
@end

NS_ASSUME_NONNULL_END
