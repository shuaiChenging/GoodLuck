//
//  WorkOrderApproveCell.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/15.
//

#import <UIKit/UIKit.h>
#import "ApplyDeleteResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface WorkOrderApproveCell : UITableViewCell
@property (nonatomic, strong) RACSubject *subject;
@property (nonatomic, strong) UILabel *detailLb;
+ (instancetype)cellWithCollectionView:(UITableView *)tableView;
- (void)loadViewWithModel:(ApplyDeleteResponse *)model;
@end

NS_ASSUME_NONNULL_END
