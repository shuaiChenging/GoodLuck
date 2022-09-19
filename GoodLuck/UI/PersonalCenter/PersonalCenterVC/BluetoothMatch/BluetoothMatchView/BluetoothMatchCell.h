//
//  BluetoothMatchCell.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BluetoothMatchCell : UITableViewCell
+ (instancetype)cellWithCollectionView:(UITableView *)tableView;

- (void)loadViewWithName:(NSString *)name subName:(NSString *)subName;
@end

NS_ASSUME_NONNULL_END
