//
//  WorkManageCardHeaderView.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/15.
//

#import <UIKit/UIKit.h>
#import "WorkDetailCardResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface WorkManageCardHeaderView : UITableViewHeaderFooterView
+ (instancetype)cellWithTableViewHeaderFooterView:(UITableView *)tableView;
- (void)loadViewWithModel:(WorkDetailCardResponse *)model;
@end

NS_ASSUME_NONNULL_END
