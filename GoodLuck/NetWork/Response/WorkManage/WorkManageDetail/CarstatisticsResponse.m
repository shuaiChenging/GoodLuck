//
//  CarstatisticsResponse.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/30.
//

#import "CarstatisticsResponse.h"

@implementation CarstatisticsItemResponse

@end

@implementation CarstatisticsResponse
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"plateNumberMap":[CarstatisticsItemResponse class]};
}
@end
