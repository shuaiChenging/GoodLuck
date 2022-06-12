//
//  AppDelegate.m
//  GoodLuck
//
//  Created by jdd on 2022/5/25.
//

#import "AppDelegate.h"
#import "BaseTabBarVC.h"
#import "LoginVC.h"
#import "IQKeyboardManager.h"
#import "BaseNavigationVC.h"
#import "LoginInfoManage.h"
#import "PPGetAddressBook.h"
@interface AppDelegate ()<UITabBarControllerDelegate, CYLTabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if (@available(iOS 15.0,*))
    {
        [UITableView appearance].sectionHeaderTopPadding = 0;
    }
    /// 请求用户获取通讯录权限
    [PPGetAddressBook requestAddressBookAuthorization];
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self getLocalToken];
    [self customizeInterface];
    [self configKeyboard];
    return YES;
}

- (void)getLocalToken
{
    NSString *token = [DDDataStorageManage userDefaultsGetObjectWithKey:TOKENKEY];
    if ([Tools isEmpty:token])
    {
        [self loginMainView];
    }
    else
    {
        [LoginInfoManage shareInstance].token = token;
        [self tabbarMainView];
    }
}

- (void)tabbarMainView
{
    BaseTabBarVC *baseTabBarVC = [BaseTabBarVC new];
    baseTabBarVC.delegate = self;
    self.window.rootViewController = baseTabBarVC;
    [self.window makeKeyAndVisible];
}

- (void)loginMainView
{
    BaseNavigationVC *loginNavi = [[BaseNavigationVC alloc] initWithRootViewController:[LoginVC new]];
    self.window.rootViewController = loginNavi;
    [self.window makeKeyAndVisible];
}

- (void)configKeyboard
{
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"";
    [IQKeyboardManager sharedManager].shouldShowToolbarPlaceholder = YES;
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 25;
}

//旋转动画
- (void)addRotateAnimationOnView:(UIView *)animationView
{
   [UIView animateWithDuration:0.32 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
       animationView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
   } completion:nil];
   
   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       [UIView animateWithDuration:0.70 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
           animationView.layer.transform = CATransform3DMakeRotation(2 * M_PI, 0, 1, 0);
       } completion:nil];
   });
}

- (void)customizeInterface
{
   // 普通状态下的文字属性
   NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
   normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
   
   // 选中状态下的文字属性
   NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
   selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
   
   // 设置文字属性
   UITabBarItem *tabBar = [UITabBarItem appearance];
   [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
   [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
   
   // 设置背景图片
   UITabBar *tabBarAppearance = [UITabBar appearance];
   [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tabbar_background"]];
}

#pragma mark -- CYLTabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control
{
    UIView *animationView;
    @autoreleasepool {
        for (UIView *subView in control.subviews)
        {
            if ([subView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")])
            {
                animationView = subView;
            }
        }
    }
    [self addRotateAnimationOnView:animationView];
}

@end
