//
//  Tools.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/6.
//

#import <Foundation/Foundation.h>
#import "CarSizeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface Tools : NSObject
+ (void)showToast:(NSString *)str;
+ (UIWindow *)getCurrentWindow;
+ (UIViewController *)getTopMostController;
+ (BOOL)isEmpty:(NSString *)str;
+ (NSString*)getCurrentTime;
+ (NSString *)getCurrentDate;
+ (void)logout;
+ (void)addViewWithTitle:(NSString *)title
             placeholder:(NSString *)placeholder
                textback:(AddCompentBack)back;

+ (NSDate *)stringTodate:(NSString *)string;

/// 一维数组切割成n维数组
/// @param number number description
/// @param array array description
+ (NSMutableArray *)cutArry:(int)number array:(NSArray *)array;

+ (void)showErrorWorkPlace:(NSString *)workPlace distance:(NSString *)distance block:(void (^)(NSString *))block;
+ (void)showSeletedWokrType:(void (^)(NSString *))block;
+ (void)showCancelAlert:(NSString *)time carNo:(NSString *)carNo admin:(NSString *)admin block:(void (^)(NSString *))block;
/// 获取用户信息
+ (void)getUserInfo;

+ (NSString *)dateToString:(NSDate *)date withDateFormat:(NSString *)format;

+ (void)showAddSoilCompent:(NSArray<CarSizeModel *> *)array name:(NSString *)name back:(void (^)(NSString *))back;

+ (void)showAlertWithTitle:(NSString *)titleStr
                   content:(NSString *)contentStr
                      left:(NSString *)leftStr
                     right:(NSString *)rightStr
                     block:(void (^)(void))block;

+ (NSString *)getAppVersion;

+ (void)showCarNoChangeView:(NSString *)carNo
                      image:(UIImage *)image
                     rescan:(void (^)(void))recan
                       sure:(void (^)(NSString *))sure;

+ (void)printWithProjectName:(NSString *)projectName
                  codeString:(NSString *)codeString
                       carNo:(NSString *)carNo
                     company:(NSString *)company
                     orderNo:(NSString *)orderNo
                     soilWay:(NSString *)soilWay
                       ztWay:(NSString *)ztWay
                 carTeamName:(NSString *)carTeamName
                   outPeople:(NSString *)outPeople
                     classNo:(NSString *)classNo
                     outTime:(NSString *)outTime
                   printTime:(NSString *)printTime
                       count:(int)count
                       price:(NSString *)price
                 isShowPrice:(BOOL)isShowPrice;

+ (NSString *)getNowTimeStamp;
@end

NS_ASSUME_NONNULL_END
