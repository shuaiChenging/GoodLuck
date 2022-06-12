//
//  ApplyWorkPlaceVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/5.
//

#import "ApplyWorkPlaceVC.h"
#import "InfoInputMiddleCompent.h"
#import "DLButton.h"
#import "AddressBookVC.h"
#import "BaseNavigationVC.h"
@interface ApplyWorkPlaceVC ()

@end

@implementation ApplyWorkPlaceVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"加入工地项目";
    self.view.backgroundColor = [UIColor whiteColor];
    [self customerUI];
}

- (void)customerUI
{
    UIView *firstLine = [UIView new];
    firstLine.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [self.view addSubview:firstLine];
    [firstLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    }];
    
    UIView *nameView = [UIView new];
    [self.view addSubview:nameView];
    [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(46);
        make.left.right.equalTo(self.view);
        make.top.equalTo(firstLine.mas_bottom);
    }];
    
    UILabel *nameLb = [UILabel labelWithText:@"请输入工地老板手机号"
                                        font:[UIFont systemFontOfSize:15]
                                   textColor:[UIColor blueColor]
                                   alignment:NSTextAlignmentLeft];
    [nameView addSubview:nameLb];
    [nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameView).offset(16);
        make.centerY.equalTo(nameView);
    }];
    
    UIView *secondLine = [UIView new];
    secondLine.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [self.view addSubview:secondLine];
    [secondLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(self.view);
        make.top.equalTo(nameView.mas_bottom);
    }];
    
    InfoInputMiddleCompent *bossInput = [InfoInputMiddleCompent new];
    [bossInput setName:@"老板手机" placeholder:@"移动电话号码" imageName:@"1"];
    WeakSelf(self)
    [bossInput.rightImg jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself presentAddressBookVC];
    }];
    [self.view addSubview:bossInput];
    [bossInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(46);
        make.left.right.equalTo(self.view);
        make.top.equalTo(secondLine.mas_bottom);
    }];
    
    UIView *thirdLine = [UIView new];
    thirdLine.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [self.view addSubview:thirdLine];
    [thirdLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(self.view);
        make.top.equalTo(bossInput.mas_bottom);
    }];
    
    InfoInputMiddleCompent *contentInput = [InfoInputMiddleCompent new];
    [contentInput setName:@"申请内容" placeholder:@"备注" imageName:nil];
    [self.view addSubview:contentInput];
    [contentInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(46);
        make.left.right.equalTo(self.view);
        make.top.equalTo(thirdLine.mas_bottom);
    }];
    
    UIView *fourthLime = [UIView new];
    fourthLime.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [self.view addSubview:fourthLime];
    [fourthLime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(self.view);
        make.top.equalTo(contentInput.mas_bottom);
    }];
    
    UIView *bottomView = [UIView new];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(78);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
    
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [bottomView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(bottomView);
        make.height.equalTo(0.5);
    }];
    
    UIButton *button = [UIButton new];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [button setTitle:@"发送申请" forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.backgroundColor = [UIColor blueColor];
    [bottomView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(16);
        make.right.equalTo(bottomView).offset(-16);
        make.center.equalTo(bottomView);
        make.height.equalTo(46);
    }];
    
}

- (void)presentAddressBookVC
{
    AddressBookVC *addressBookVC = [AddressBookVC new];
    [addressBookVC.subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    BaseNavigationVC *addressNavi = [[BaseNavigationVC alloc] initWithRootViewController:addressBookVC];
    [self presentViewController:addressNavi animated:YES completion:nil];
}

@end
