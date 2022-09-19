//
//  GLImageView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/2.
//

#import "GLImageView.h"

@implementation GLImageView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    // 点击区域上下左右各扩大10像素
    CGRect bounds = CGRectInset(self.bounds, -10, -10);
    return CGRectContainsPoint(bounds, point);
}

@end
