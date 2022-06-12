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

#define BASEURL @"http://47.104.76.23:8089"

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

// iPhoneX底部距离
#define CS_FooterHeight (kIsBangsScreen ? 34.f : 0.f)

//状态栏高度
#define CS_StatusBarHeight (kIsBangsScreen ? 44.f : 20.f)

#define TOKENKEY @"token"

#define ROLETYPE @"role"


#endif /* Config_h */
