//
//  PriceManageCell.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/27.
//

#import <UIKit/UIKit.h>
#import "WorkDetailPriceResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface PriceManageCell : UITableViewCell
@property (nonatomic, strong) GLImageView *closeImg;
@property (nonatomic, copy) SeletedChange change;
+ (instancetype)cellWithCollectionView:(UITableView *)tableView;
- (void)loadViewWithModel:(WorkDetailPriceResponse *)model change:(SeletedChange)change;
@end

NS_ASSUME_NONNULL_END
