//
//  CompanyListResponse.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/8.
//

#import "CompanyListResponse.h"

@implementation CompanyListResponse
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"companyId":@"id"};
}
@end
