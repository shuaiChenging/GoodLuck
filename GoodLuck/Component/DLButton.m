//
//  DLButton.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/5/31.
//

#import "DLButton.h"

@implementation DLButton

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.layer.masksToBounds = YES;
        self.titleLabel.textColor = [UIColor whiteColor];
    }
    return self;
}

@end
