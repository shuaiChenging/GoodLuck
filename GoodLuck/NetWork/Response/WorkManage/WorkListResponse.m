//
//  WorkListResponse.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/7.
//

#import "WorkListResponse.h"
@implementation ProjectListResponse
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"projectId":@"id"};
}
@end
@implementation WorkListResponse
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"projectList":[ProjectListResponse class]};
}
@end

