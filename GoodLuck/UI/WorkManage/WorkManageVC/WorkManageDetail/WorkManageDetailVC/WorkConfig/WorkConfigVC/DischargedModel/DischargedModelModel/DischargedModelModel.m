//
//  DischargedModelModel.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/19.
//

#import "DischargedModelModel.h"

@implementation DischargedModelModel
- (instancetype)initWithItem:(NSString *)item describe:(NSString *)describe isSeleted:(BOOL)isSeleted
{
    self = [super init];
    if (self)
    {
        self.item = item;
        self.describe = describe;
        self.isSeleted = isSeleted;
    }
    return self;
}
@end
