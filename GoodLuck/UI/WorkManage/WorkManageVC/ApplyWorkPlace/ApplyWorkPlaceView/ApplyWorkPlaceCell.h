//
//  ApplyWorkPlaceCell.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/14.
//

#import <UIKit/UIKit.h>
#import "BossListResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface ApplyWorkPlaceCell : UITableViewCell
+ (instancetype)cellWithCollectionView:(UITableView *)tableView;
- (void)loadViewWithModel:(BossListResponse *)model;
@end

NS_ASSUME_NONNULL_END
