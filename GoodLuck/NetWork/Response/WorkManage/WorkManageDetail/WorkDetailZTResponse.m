//
//  WorkDetailZTResponse.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/9.
//

#import "WorkDetailZTResponse.h"
#import "WorkDetailCardResponse.h"
@implementation WorkDetailZTItem
@end


@implementation WorkztcModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"plateNumberMap":[WorkDetailCardItemResponse class]};
}
@end

@implementation WorkDetailZTResponse
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"details":[WorkDetailZTItem class],
             @"ztcDetails":[WorkDetailZTItem class],
             @"totalDetails":[WorkDetailZTItem class],
             @"plateNumberMap":[WorkDetailCardItemResponse class],
             @"ztcPlateNumberMap":[WorkztcModel class]};
}
@end
