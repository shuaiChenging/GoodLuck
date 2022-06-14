//
//  ApplyWorkPlaceHeaderView.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/14.
//

#import <UIKit/UIKit.h>
#import "InfoInputMiddleCompent.h"
NS_ASSUME_NONNULL_BEGIN

@interface ApplyWorkPlaceHeaderView : UIView
@property (nonatomic, strong) InfoInputMiddleCompent *bossInput;
@property (nonatomic, strong) InfoInputMiddleCompent *bossNameInput;
@property (nonatomic, strong) InfoInputMiddleCompent *contentInput;
- (void)showBossName;
- (void)hiddenBossName;
@end

NS_ASSUME_NONNULL_END
