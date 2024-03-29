//
//  WorkConfigSwitchCell.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/9.
//

#import <UIKit/UIKit.h>
#import "WorkConfigModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface WorkConfigSwitchCell : UITableViewCell
@property (nonatomic, copy) NSString *projectId;
+ (instancetype)cellWithCollectionView:(UITableView *)tableView;
- (void)loadViewWithModel:(WorkConfigDetailModel *)model projectId:(NSString *)projectId;

@end

NS_ASSUME_NONNULL_END
