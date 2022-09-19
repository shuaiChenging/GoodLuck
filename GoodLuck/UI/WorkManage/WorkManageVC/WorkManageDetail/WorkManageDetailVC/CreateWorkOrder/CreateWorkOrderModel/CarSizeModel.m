//
//  CarSizeModel.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/17.
//

#import "CarSizeModel.h"

@implementation CarSizeModel
- (instancetype)initWithName:(NSString *)name isSeleted:(BOOL)isSeleted size:(NSString *)size
{
    self = [super init];
    if (self)
    {
        self.name = name;
        self.isSeleted = isSeleted;
        self.size = size;
    }
    return self;
}
@end
