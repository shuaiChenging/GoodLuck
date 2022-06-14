//
//  BossListResponse.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/14.
//

#import "BossListResponse.h"

@implementation BossListResponse
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"projectId":@"id"};
}
@end
