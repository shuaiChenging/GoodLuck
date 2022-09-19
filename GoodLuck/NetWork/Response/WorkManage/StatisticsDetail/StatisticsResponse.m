//
//  StatisticsResponse.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/6.
//

#import "StatisticsResponse.h"

@implementation WorkerItem

@end

@implementation WorkerItemType
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"details":[WorkerItem class]};
}
@end

@implementation WorkerTypeResponse
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"details":[WorkerItemType class]};
}
@end

@implementation CustomtcStatisticsResponse
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"details":[WorkerItem class]};
}
@end

@implementation InnerMobileResponse

@end

@implementation StatisticsResponse
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"innerMobileProjectStatistics":[InnerMobileResponse class]};
}
@end
