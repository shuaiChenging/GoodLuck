//
//  AlertCompent.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlertCompent : UIView
@property (nonatomic, strong) RACSubject *subject;
- (void)loadViewWithTitle:(NSString *)titleStr
                  content:(NSString *)contentStr
                     left:(NSString *)leftStr
                    right:(NSString *)rightStr;
@end

NS_ASSUME_NONNULL_END
