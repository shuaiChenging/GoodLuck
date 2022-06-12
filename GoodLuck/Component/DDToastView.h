//
//  DDToastView.h
//  DDGameSDKDemo
//
//  Created by MHJZ on 2022/2/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDToastView : UIView
- (void)toastWithMessage:(NSString *)message;
- (void)showToastOnWindowWithMessage:(NSString *)message;
@end

NS_ASSUME_NONNULL_END
