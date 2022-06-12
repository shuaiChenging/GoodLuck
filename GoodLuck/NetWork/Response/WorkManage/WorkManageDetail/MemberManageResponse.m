//
//  MemberManageResponse.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/8.
//

#import "MemberManageResponse.h"

@implementation MemberManageResponse
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"nameId":@"id"};
}
@end

@implementation MemberHeaderResponse
- (instancetype)initWithName:(NSString *)name describe:(NSString *)describe
{
    self = [super init];
    if (self)
    {
        self.name = name;
        self.describe = describe;
    }
    return self;
}

@end

@implementation ManageResponse
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"content":[MemberManageResponse class]};
}
@end
