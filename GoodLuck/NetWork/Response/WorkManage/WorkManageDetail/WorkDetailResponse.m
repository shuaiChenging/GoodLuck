//
//  WorkDetailResponse.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/8.
//

#import "WorkDetailResponse.h"

@implementation WorkDetailResponse
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"projectId":@"id"};
}
@end
