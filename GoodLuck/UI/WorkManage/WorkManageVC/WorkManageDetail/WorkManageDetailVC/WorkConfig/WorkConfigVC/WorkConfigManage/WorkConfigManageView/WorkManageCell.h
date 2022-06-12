//
//  WorkManageCell.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WorkManageCell : UITableViewCell
@property (nonatomic, strong) ManageDelete manageDelete;
+ (instancetype)cellWithCollectionView:(UITableView *)tableView;
- (void)loadViewWithArray:(NSArray *)array;
@end

NS_ASSUME_NONNULL_END
