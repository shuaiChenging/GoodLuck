//
//  UniltListCell.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/8.
//

#import <UIKit/UIKit.h>
#import "CompanyListResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface UniltListCell : UITableViewCell
+ (instancetype)cellWithCollectionView:(UITableView *)tableView;

- (void)loadViewWithModel:(CompanyListResponse *)model;
@end

NS_ASSUME_NONNULL_END
