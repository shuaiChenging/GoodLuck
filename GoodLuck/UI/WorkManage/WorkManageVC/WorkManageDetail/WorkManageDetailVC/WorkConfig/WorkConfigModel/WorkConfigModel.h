//
//  WorkConfigModel.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WorkConfigDetailModel : NSObject
@property (nonatomic, assign) WorkConfigType type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *describe;
@property (nonatomic, assign) WorkSettingType settingType;

- (instancetype)initWithType:(WorkConfigType )type
                 settingType:(WorkSettingType)settingType
                        name:(NSString *)name
                    describe:(NSString * _Nullable)describe;
@end

@interface WorkConfigModel : NSObject
@property (nonatomic, copy) NSString *header;
@property (nonatomic, strong) NSArray *content;
@end

NS_ASSUME_NONNULL_END
