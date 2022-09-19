//
//  WorkDetailCardResponse.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/1.
//

#import "WorkDetailCardResponse.h"

@implementation WorkDetailCardItemResponse

@end
@implementation WorkDetailCardResponse
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"plateNumberMap":[WorkDetailCardItemResponse class]};
}
@end
