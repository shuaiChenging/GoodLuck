//
//  WorkManageSoilHeaderView.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/1.
//

#import <UIKit/UIKit.h>
#import "WorkDetailSoilResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface WorkManageSoilHeaderView : UITableViewHeaderFooterView
+ (instancetype)cellWithTableViewHeaderFooterView:(UITableView *)tableView;
- (void)loadViewWithModel:(WorkDetailSoilResponse *)response;
@end

NS_ASSUME_NONNULL_END
