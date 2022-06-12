//
//  WorkInfoView.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WorkInfoView : UIView
@property (nonatomic, strong) UILabel *numberLb;
@property (nonatomic, strong) UILabel *itemLb;
- (void)listHeadStyle;
@end

NS_ASSUME_NONNULL_END
