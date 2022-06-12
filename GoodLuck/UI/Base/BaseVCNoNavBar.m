//
//  BaseVCNoNavBar.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/6.
//

#import "BaseVCNoNavBar.h"

@interface BaseVCNoNavBar ()

@end

@implementation BaseVCNoNavBar

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

@end
