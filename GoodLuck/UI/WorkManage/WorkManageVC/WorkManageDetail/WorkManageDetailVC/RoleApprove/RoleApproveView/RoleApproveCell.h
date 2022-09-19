//
//  RoleApproveCell.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/15.
//

#import <UIKit/UIKit.h>
#import "RoleApproveResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface RoleApproveCell : UITableViewCell
@property (nonatomic, strong) RACSubject *subject;
+ (instancetype)cellWithCollectionView:(UITableView *)tableView;
- (void)loadViewWithModel:(RoleApproveResponse *)model;
@end

NS_ASSUME_NONNULL_END
