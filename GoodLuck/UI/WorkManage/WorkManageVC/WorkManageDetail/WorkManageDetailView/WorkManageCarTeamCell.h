//
//  WorkManageCarTeamCell.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/1.
//

#import <UIKit/UIKit.h>
#import "WorkDetailCardTeamResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface WorkManageCarTeamCell : UITableViewCell
+ (instancetype)cellWithCollectionView:(UITableView *)tableView;
- (void)loadViewWithModel:(WorkDetailCardTeamResponse *)model;
@end

NS_ASSUME_NONNULL_END
