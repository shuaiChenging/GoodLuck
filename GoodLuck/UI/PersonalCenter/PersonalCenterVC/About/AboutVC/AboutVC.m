//
//  AboutVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/4.
//

#import "AboutVC.h"

@interface AboutVC ()

@end

@implementation AboutVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"关于好运来";
    [self customerUI];
}

- (void)customerUI
{
    UIImageView *iconImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_icon"]];
    [self.view addSubview:iconImg];
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(130);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(80);
    }];
    
    UILabel *label = [UILabel labelWithText:[NSString stringWithFormat:@"当前版本：%@",[Tools getAppVersion]]
                                       font:[UIFont systemFontOfSize:font_14]
                                  textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                  alignment:NSTextAlignmentCenter];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconImg.mas_bottom).offset(40);
        make.centerX.equalTo(self.view);
    }];
}


@end
