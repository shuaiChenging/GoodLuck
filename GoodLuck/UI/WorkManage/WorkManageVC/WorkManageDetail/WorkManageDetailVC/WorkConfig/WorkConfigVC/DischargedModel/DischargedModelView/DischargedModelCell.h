//
//  DischargedModelCell.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/19.
//

#import <UIKit/UIKit.h>
#import "DischargedModelModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DischargedModelCell : UITableViewCell
+ (instancetype)cellWithCollectionView:(UITableView *)tableView;
- (void)loadViewWithModel:(DischargedModelModel *)model;
@end

NS_ASSUME_NONNULL_END
