//
//  UILabel+Extent.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/5/31.
//

#import "UILabel+Extent.h"

@implementation UILabel (Extent)
+ (UILabel *_Nonnull)labelWithText:(NSString *_Nonnull)text
                              font:(UIFont *_Nullable)font
                         textColor:(UIColor *_Nullable)textColor
                         alignment:(NSTextAlignment )alignment
{
    UILabel *lable = [UILabel new];
    lable.text = text;
    if (font)
    {
        lable.font = font;
    }
    if (textColor)
    {
        lable.textColor = textColor;
    }
    lable.textAlignment = alignment;
    return lable;
}
@end
