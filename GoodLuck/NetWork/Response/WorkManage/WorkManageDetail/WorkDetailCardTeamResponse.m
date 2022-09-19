//
//  WorkDetailCardTeamResponse.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/1.
//

#import "WorkDetailCardTeamResponse.h"

@implementation WorkDetailCardItem

@end

@implementation WorkDetailCardTeamListResponse
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"fleetDetails":[WorkDetailCardItem class]};
}
@end

@implementation WorkDetailCardTeamResponse
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"list":[WorkDetailCardTeamListResponse class]};
}
@end
