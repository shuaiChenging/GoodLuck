//
//  RoleApproveResponse.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/26.
//

#import "RoleApproveResponse.h"

@implementation RoleApproveResponse
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"descrip":@"description",@"itemId":@"id"};
}
@end
