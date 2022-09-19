//
//  WorkManageCarTeamHeaderView.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/25.
//

#import <UIKit/UIKit.h>
#import "WorkDetailCardTeamResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface WorkManageCarTeamHeaderView : UITableViewHeaderFooterView
+ (instancetype)cellWithTableViewHeaderFooterView:(UITableView *)tableView;
- (void)loadViewWithModel:(WorkDetailCardTeamListResponse *)model
                 indexRow:(NSInteger)row
                 response:(WorkDetailCardTeamResponse *)response;
@end

NS_ASSUME_NONNULL_END
