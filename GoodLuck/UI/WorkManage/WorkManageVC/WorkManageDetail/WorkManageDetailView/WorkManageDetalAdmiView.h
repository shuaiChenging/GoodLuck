//
//  WorkManageDetalAdmiView.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WorkManageDetalAdmiView : UIView
@property (nonatomic, strong) UILabel *printerStateLb;
//@property (nonatomic, strong) UILabel *modelLb;
@property (nonatomic, strong) UILabel *offficeStateLb;

- (void)changeState:(BOOL)isDay;
@end

NS_ASSUME_NONNULL_END
