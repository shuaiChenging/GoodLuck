//
//  WorkConfigManageResponse.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/11.
//

#import "WorkConfigManageResponse.h"

@implementation WorkConfigManageResponse
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"workId":@"id"};
}
@end
