//
//  WorkOrderDetailResponse.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/29.
//

#import "WorkOrderDetailResponse.h"

@implementation WorkOrderDetailResponse
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"orderId":@"id"};
}
@end
