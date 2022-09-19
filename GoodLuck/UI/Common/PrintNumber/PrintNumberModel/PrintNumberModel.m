//
//  PrintNumberModel.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/8.
//

#import "PrintNumberModel.h"

@implementation PrintNumberModel
- (instancetype)initWithName:(NSString *)name
                  isSelected:(BOOL)isSelected
{
    self = [super init];
    if (self)
    {
        self.name = name;
        self.isSelected = isSelected;
    }
    return self;
}
@end
