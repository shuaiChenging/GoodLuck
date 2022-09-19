//
//  AccountAndSafeCell.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccountAndSafeCell : UITableViewCell
+ (instancetype)cellWithCollectionView:(UITableView *)tableView;
- (void)loadViewWithName:(NSString *)nameStr content:(NSString *)contentStr;
@end

NS_ASSUME_NONNULL_END
