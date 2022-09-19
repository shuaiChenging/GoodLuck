//
//  WorkMainScrollView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/9/5.
//

#import "WorkMainScrollView.h"
#import "WorkContentScrollView.h"
@implementation WorkMainScrollView

/// 支持多手势
/// @param gestureRecognizer gestureRecognizer description
/// @param otherGestureRecognizer otherGestureRecognizer description
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
