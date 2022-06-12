//
//  Tools.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Tools : NSObject
+ (void)showToast:(NSString *)str;
+ (UIWindow *)getCurrentWindow;
+ (UIViewController *)getTopMostController;
+ (BOOL)isEmpty:(NSString *)str;
+ (NSString*)getCurrentTime;
+ (void)logout;
+ (void)addViewWithTitle:(NSString *)title
             placeholder:(NSString *)placeholder
                textback:(AddCompentBack)back;

/// 一维数组切割成n维数组
/// @param number number description
/// @param array array description
+ (NSMutableArray *)cutArry:(int)number array:(NSArray *)array;
@end

NS_ASSUME_NONNULL_END
