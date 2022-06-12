//
//  PersonalCenterCell.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonalCenterCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLb;
+ (instancetype)cellWithCollectionView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
