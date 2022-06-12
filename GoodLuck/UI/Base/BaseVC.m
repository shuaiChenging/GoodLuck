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
    self.view.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self adjustIOS15Navigationbar];
    if (self.navigationController.viewControllers.count > 1 || self.presentationController != nil)
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
    if (@available(iOS 15.0,*))
    {
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
        appearance.backgroundColor = [UIColor whiteColor];
        appearance.shadowColor = [UIColor whiteColor];
        self.navigationController.navigationBar.standardAppearance = appearance;
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
    }
}

- (void)back
{
    if (self.navigationController.viewControllers.count > 1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (self.presentationController != nil)
    {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
