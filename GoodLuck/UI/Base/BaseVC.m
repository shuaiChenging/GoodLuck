//
//  BaseVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/5/31.
//

 
#import "BaseVCNoNavBar.h"
@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self adjustIOS15Navigationbar];
    if (self.navigationController.viewControllers.count > 1 || self.presentingViewController != nil)
    {
        [self addBackBt];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)addBackBt
{
    ExpendImageView *backArrow = [ExpendImageView new];
    backArrow.image = [UIImage imageNamed:@"navigation_back_arrow"];
    WeakSelf(self)
    [backArrow jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself back];
    }];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backArrow];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)adjustIOS15Navigationbar
{
    if (@available(iOS 13.0,*))
    {
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
        appearance.backgroundColor = [UIColor whiteColor];
        appearance.shadowColor = [UIColor whiteColor];
        appearance.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor jk_colorWithHexString:@"#333333"],
                                           NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Medium" size:18]};
        self.navigationController.navigationBar.standardAppearance = appearance;
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
    }
    else
    {
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor jk_colorWithHexString:@"#333333"],
                                                   NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Medium" size:18]};
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    }
}

- (void)back
{
    if (self.navigationController.viewControllers.count > 1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (self.presentingViewController != nil)
    {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
