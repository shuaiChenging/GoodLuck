//
//  Config.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/5/31.
//

#ifndef Config_h
#define Config_h

// 定义这个常量，就可以不用在开发过程中使用mas_前缀。
#define MAS_SHORTHAND
// 定义这个常量，就可以让Masonry帮我们自动把基础数据类型的数据，自动装箱为对象类型。
#define MAS_SHORTHAND_GLOBALS

#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

#define BASEURL @"https://muck.chenfanyunshu.com" ///https://muck.orgvts.com

/// 用户注册协议
#define SERVICEURL @"https://lucky-earth-cube.oss-cn-hangzhou.aliyuncs.com/customer/mobile/%E7%94%A8%E6%88%B7%E6%B3%A8%E5%86%8C%E5%8D%8F%E8%AE%AE.pdf?OSSAccessKeyId=LTAI5tEvVJ3EttHquPcrjJxM&Expires=37656655983&Signature=kENi%2FXtd%2FNHKRoiLoLnTgkuyr7A%3D"

#define PRIVACY @"https://lucky-earth-cube.oss-cn-hangzhou.aliyuncs.com/customer/mobile/%E9%9A%90%E7%A7%81%E5%8D%8F%E8%AE%AE.pdf?OSSAccessKeyId=LTAI5tEvVJ3EttHquPcrjJxM&Expires=1692656027&Signature=ixe2UCe9KlQOTF02Z8kKFy9lDZ4%3D"

// 判断是否是刘海屏
#define kIsBangsScreen ({\
    BOOL isBangsScreen = NO; \
    if (@available(iOS 11.0, *)) { \
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject]; \
    isBangsScreen = window.safeAreaInsets.bottom > 0; \
    } \
    isBangsScreen; \
})

#define WeakSelf(type) __weak typeof(type) weak##type = type;

#define StrongSelf(type) __strong typeof(type) strong##type = type;

// iPhoneX底部距离
#define CS_FooterHeight (kIsBangsScreen ? 34.f : 0.f)

//状态栏高度
#define CS_StatusBarHeight (kIsBangsScreen ? 44.f : 20.f)

#define TOKENKEY @"token"

#define INFOKEY @"info"

#define ROLETYPE @"role"

#define MODELTYPE @"model"

#define PRINTNUMBER @"printNo"

#define REMBERLASTSETTING @"remberlastsetting"

#define CARALERT @"caralert"


#endif /* Config_h */
