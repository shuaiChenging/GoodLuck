//
//  BaseTabBarVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/5/31.
//

#import "BaseTabBarVC.h"
#import "BaseNavigationVC.h"
#import "WorkManageVC.h"
#import "PersonalCenterVC.h"
@interface BaseTabBarVC ()

@end

@implementation BaseTabBarVC

- (instancetype)init
{
    if (!(self = [super init]))
    {
        return nil;
    }
    if (@available(iOS 15.0,*))
    {
        UITabBarAppearance *appearance = [[UITabBarAppearance alloc] init];
        appearance.shadowColor = [UIColor clearColor];
        appearance.backgroundColor = [UIColor whiteColor];
        [UITabBar appearance].scrollEdgeAppearance = appearance;
        [UITabBar appearance].standardAppearance = appearance;
    }
    UIEdgeInsets imageInsets = UIEdgeInsetsZero;
    UIOffset titilePositionAdjustment = UIOffsetMake(0, -3.5);
    CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers
                                                                               tabBarItemsAttributes:self.tabBarItemsAttributesForController
                                                                                         imageInsets:imageInsets
                                                                             titlePositionAdjustment:titilePositionAdjustment];
    self.navigationController.navigationBar.hidden = YES;
    return (self = (BaseTabBarVC *)tabBarController);
}

- (NSArray *)viewControllers
{
    WorkManageVC *workManageVC = [[WorkManageVC alloc] init];
    BaseNavigationVC *workManageNavi = [[BaseNavigationVC alloc] initWithRootViewController:workManageVC];
    [workManageVC cyl_setHideNavigationBarSeparator:YES];
    
    PersonalCenterVC *personalCenterVC = [[PersonalCenterVC alloc] init];
    BaseNavigationVC *personalCenterNavi = [[BaseNavigationVC alloc] initWithRootViewController:personalCenterVC];
    [personalCenterNavi cyl_setHideNavigationBarSeparator:YES];
    NSArray *viewControllers = @[workManageNavi,personalCenterNavi];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForController
{
   NSDictionary *workManageAttributes = @{CYLTabBarItemTitle:@"工作管理",
                                          CYLTabBarItemImage:@"tabBar_home",
                                          CYLTabBarItemSelectedImage:@"tabBar_home_selected"};
    
   NSDictionary *personalCenterAttributes = @{CYLTabBarItemTitle:@"个人中心",
                                              CYLTabBarItemImage:@"tabBar_personal",
                                              CYLTabBarItemSelectedImage:@"tabBar_perseonal_selected"};
   

   NSArray *tabBarItemsAttributes = @[workManageAttributes,personalCenterAttributes];
   return tabBarItemsAttributes;
}

@end
