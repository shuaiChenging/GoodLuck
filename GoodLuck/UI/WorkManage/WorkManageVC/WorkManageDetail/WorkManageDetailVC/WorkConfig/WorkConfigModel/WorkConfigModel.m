//
//  WorkConfigModel.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/9.
//

#import "WorkConfigModel.h"

@implementation WorkConfigDetailModel
- (instancetype)initWithType:(WorkConfigType )type
                 settingType:(WorkSettingType)settingType
                        name:(NSString *)name
                    describe:(NSString * _Nullable)describe
{
    self = [super init];
    if (self)
    {
        self.type = type;
        self.name = name;
        self.settingType = settingType;
        if (describe)
        {
            self.describe = describe;
        }
    }
    return self;
}
@end

@implementation WorkConfigModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"content":[WorkConfigDetailModel class]};
}
@end
