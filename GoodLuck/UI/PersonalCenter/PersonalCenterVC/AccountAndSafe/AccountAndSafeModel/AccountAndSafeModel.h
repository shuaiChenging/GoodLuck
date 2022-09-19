//
//  AccountAndSafeModel.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccountAndSafeModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *content;
- (instancetype)initWithName:(NSString *)name content:(NSString *)content;
@end

NS_ASSUME_NONNULL_END
