//
//  AddressBookCell.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressBookCell : UITableViewCell
+ (instancetype)cellWithCollectionView:(UITableView *)tableView;
- (void)loadViewWithName:(NSString *)name image:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
