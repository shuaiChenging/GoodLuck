//
//  CarListCell.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/25.
//

#import <UIKit/UIKit.h>
#import "WorkConfigManageResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface CarListCell : UITableViewCell
+ (instancetype)cellWithCollectionView:(UITableView *)tableView;
- (void)loadViewWithModel:(WorkConfigManageResponse *)response;
@end

NS_ASSUME_NONNULL_END
