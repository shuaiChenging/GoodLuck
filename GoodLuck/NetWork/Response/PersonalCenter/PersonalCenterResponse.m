//
//  PersonalCenterResponse.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/24.
//

#import "PersonalCenterResponse.h"

@implementation PersonalCenterResponse
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"tenantId":@"id"};
}
@end
