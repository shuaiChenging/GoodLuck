//
//  WorkManageCarHeaderView.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/15.
//

#import <UIKit/UIKit.h>
#import "CarstatisticsResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface WorkManageCarHeaderView : UITableViewHeaderFooterView
+ (instancetype)cellWithTableViewHeaderFooterView:(UITableView *)tableView;
- (void)loadViewWithModel:(CarstatisticsResponse *)model;
@end

NS_ASSUME_NONNULL_END
