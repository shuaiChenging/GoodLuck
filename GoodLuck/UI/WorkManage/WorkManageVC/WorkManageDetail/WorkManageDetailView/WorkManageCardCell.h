//
//  WorkManageCardCell.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WorkManageCardCell : UITableViewCell
@property (nonatomic, copy) CardCallback callback;
+ (instancetype)cellWithCollectionView:(UITableView *)tableView;
- (void)loadViewWithArray:(NSArray *)array indexRow:(int)indexRow;
@end

NS_ASSUME_NONNULL_END
