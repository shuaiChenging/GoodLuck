//
//  MemberManageCell.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MemberManageCell : UITableViewCell
+ (instancetype)cellWithCollectionView:(UITableView *)tableView;

- (void)setImageName:(NSString *)imageName name:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
