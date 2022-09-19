//
//  DatePointManage.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/8/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DatePointManage : NSObject
@property (nonatomic, strong) NSArray *dateArr;
+ (instancetype)shareInstance;
- (void)getPointDate:(NSString *)projectId;
@end

NS_ASSUME_NONNULL_END
