//
//  WorkDetailSoilResponse.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/1.
//

#import "WorkDetailSoilResponse.h"

@implementation WorkDetailSoilItemResponse

@end

@implementation WorkDetailSoilResponse
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"orderMap":[WorkDetailSoilItemResponse class]};
}
@end
