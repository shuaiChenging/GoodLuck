//
//  TableSeletedCell.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/8/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableSeletedCell : UITableViewCell
@property (nonatomic, strong) UILabel *label;
+ (instancetype)cellWithCollectionView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
