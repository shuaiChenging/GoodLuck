//
//  UILabel+Extent.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/5/31.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Extent)
+ (UILabel *_Nonnull)labelWithText:(NSString *_Nonnull)text
                              font:(UIFont *_Nullable)font
                         textColor:(UIColor *_Nullable)textColor
                         alignment:(NSTextAlignment )alignment;
@end

NS_ASSUME_NONNULL_END
