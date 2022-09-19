//
//  EchartCell.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/15.
//

#import <UIKit/UIKit.h>
#import "WorkDetailZTResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface EchartCell : UITableViewCell
+ (instancetype)cellWithCollectionView:(UITableView *)tableView;
- (void)loadViewWithModel:(WorkDetailZTResponse *)model;
@end

NS_ASSUME_NONNULL_END
