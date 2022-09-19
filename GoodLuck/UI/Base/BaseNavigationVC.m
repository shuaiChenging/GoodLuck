//
//  BaseNavigationVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/5/31.
//

#import "BaseNavigationVC.h"

@interface BaseNavigationVC ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createNaviUI];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (@available(iOS 13.0,*))
    {
        return UIStatusBarStyleDarkContent;
    }
    else
    {
        return UIStatusBarStyleDefault;
    }
}

- (void)createNaviUI
{
    [UINavigationBar appearance].barTintColor = [UIColor whiteColor];
    if (@available(iOS 13.0,*))
    {
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
        [appearance configureWithOpaqueBackground];
        appearance.backgroundImage = [UIImage new];
        appearance.shadowImage = [UIImage new];
        appearance.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor jk_colorWithHexString:@"#333333"],
                                           NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Medium" size:18]};
        self.navigationController.navigationBar.standardAppearance = appearance;
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance;

    }
    else
    {
        self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor jk_colorWithHexString:@"#333333"],
                                                   NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Medium" size:18]};
        [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.navigationBar.shadowImage = [UIImage new];
    }
    self.interactivePopGestureRecognizer.delegate = self;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}
@end
