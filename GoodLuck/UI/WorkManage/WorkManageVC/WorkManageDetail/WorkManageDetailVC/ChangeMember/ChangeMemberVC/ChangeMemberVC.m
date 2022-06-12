//
//  ChangeMemberVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/6.
//

#import "ChangeMemberVC.h"

@interface ChangeMemberVC ()
@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILabel *nameLb;
@end

@implementation ChangeMemberVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"修改工地管理员";
    self.view.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [self customerUI];
}

- (UIImageView *)iconImg
{
    if (!_iconImg)
    {
        _iconImg = [UIImageView new];
        _iconImg.backgroundColor = [UIColor grayColor];
    }
    return _iconImg;
}

- (UILabel *)nameLb
{
    if (!_nameLb)
    {
        _nameLb = [UILabel labelWithText:@"Andy"
                                     font:[UIFont systemFontOfSize:14]
                                textColor:nil
                               alignment:NSTextAlignmentLeft];
    }
    return _nameLb;
}

- (void)customerUI
{
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.right.equalTo(self.view).offset(-16);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(14);
        make.height.equalTo(80);
    }];
    
    UIButton *button = [UIButton new];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [button setTitle:@"移除" forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.backgroundColor = [UIColor blueColor];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.right.equalTo(self.view).offset(-16);
        make.top.equalTo(backView.mas_bottom).offset(40);
        make.height.equalTo(46);
    }];
    
    [backView addSubview:self.iconImg];
    [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(40);
        make.left.equalTo(backView).offset(16);
        make.centerY.equalTo(backView);
    }];
    
    [backView addSubview:self.nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.mas_right).offset(20);
        make.centerY.equalTo(backView);
    }];
    
}

@end
