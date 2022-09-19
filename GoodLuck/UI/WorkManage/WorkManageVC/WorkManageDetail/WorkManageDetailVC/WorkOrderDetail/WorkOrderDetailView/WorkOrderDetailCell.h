//
//  WorkOrderDetailCell.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/16.
//

#import <UIKit/UIKit.h>
#import "OrderDetailResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface WorkOrderDetailCell : UITableViewCell
@property (nonatomic, copy) SeletedChange seletedChange;
+ (instancetype)cellWithCollectionView:(UITableView *)tableView;
- (void)loadViewWithModel:(OrderDetailResponse *)response change:(SeletedChange)change isDelete:(BOOL)isDelete;
@end

NS_ASSUME_NONNULL_END
