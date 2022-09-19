//
//  WorkManageZDHeaderView.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/8/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WorkManageZDHeaderView : UITableViewHeaderFooterView
+ (instancetype)cellWithTableViewHeaderFooterView:(UITableView *)tableView;
- (void)loadViewWithName:(NSString *)name number:(NSString *)number;
@end

NS_ASSUME_NONNULL_END
