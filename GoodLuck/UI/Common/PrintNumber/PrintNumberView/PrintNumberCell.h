//
//  PrintNumberCell.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/8.
//

#import <UIKit/UIKit.h>
#import "PrintNumberModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PrintNumberCell : UITableViewCell
+ (instancetype)cellWithCollectionView:(UITableView *)tableView;
- (void)loadViewWithModel:(PrintNumberModel *)model;
@end

NS_ASSUME_NONNULL_END
