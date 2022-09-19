//
//  AccountAndSafeModel.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/5.
//

#import "AccountAndSafeModel.h"

@implementation AccountAndSafeModel
- (instancetype)initWithName:(NSString *)name content:(NSString *)content
{
    self = [super init];
    if (self)
    {
        self.name = name;
        self.content = content;
    }
    return self;
}
@end
