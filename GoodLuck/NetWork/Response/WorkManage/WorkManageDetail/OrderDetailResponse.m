//
//  OrderDetailResponse.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/6.
//

#import "OrderDetailResponse.h"

@implementation OrderDetailResponse
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"orderId":@"id"};
}
@end
