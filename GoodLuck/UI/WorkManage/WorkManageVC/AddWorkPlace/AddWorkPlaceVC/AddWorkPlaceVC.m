//
//  AddWorkPlaceVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/5.
//

#import "AddWorkPlaceVC.h"
#import "InfoInputRightCompent.h"
#import "InfoInputCountCompent.h"
#import "InfoSeletedCompent.h"
#import "UnlitListVC.h"
@interface AddWorkPlaceVC ()

@end

@implementation AddWorkPlaceVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [self customerUI];
}

- (void)customerUI
{
    UIView *baseView = [UIView new];
    [self.view addSubview:baseView];
    [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(46);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.left.right.equalTo(self.view);
    }];
    UILabel *baseLb = [UILabel labelWithText:@"基本配置（必填）"
                                        font:[UIFont systemFontOfSize:16]
                                   textColor:[UIColor jk_colorWithHexString:@"#666666"]
                                   alignment:NSTextAlignmentLeft];
    [baseView addSubview:baseLb];
    [baseLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(baseView).offset(16);
        make.centerY.equalTo(baseView);
    }];
    
    InfoInputRightCompent *projectName = [InfoInputRightCompent new];
    [projectName setName:@"项目名称" placeholder:@"请输入项目名称"];
    [self.view addSubview:projectName];
    [projectName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(46);
        make.top.equalTo(baseView.mas_bottom);
        make.left.right.equalTo(self.view);
    }];
    
    UIView *firstLine = [UIView new];
    firstLine.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [self.view addSubview:firstLine];
    [firstLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(self.view);
        make.top.equalTo(projectName.mas_bottom);
    }];
    
    WeakSelf(self)
    
    InfoSeletedCompent *projectAddress = [InfoSeletedCompent new];
    [projectAddress setName:@"项目地址" info:@"浙江省西湖区"];
    [projectAddress jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        NSLog(@"来了，老弟");
    }];
    [self.view addSubview:projectAddress];
    [projectAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(46);
        make.top.equalTo(firstLine.mas_bottom);
        make.left.right.equalTo(self.view);
    }];
    
    UIView *secondLine = [UIView new];
    secondLine.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [self.view addSubview:secondLine];
    [secondLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(self.view);
        make.top.equalTo(projectAddress.mas_bottom);
    }];
    
    InfoInputCountCompent *detailAddress = [InfoInputCountCompent new];
    [detailAddress setName:@"详细地址" placeholder:@"请输入详细地址"];
    [self.view addSubview:detailAddress];
    [detailAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(56);
        make.top.equalTo(secondLine.mas_bottom);
        make.left.right.equalTo(self.view);
    }];
    
    UIView *thirdLine = [UIView new];
    thirdLine.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [self.view addSubview:thirdLine];
    [thirdLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(self.view);
        make.top.equalTo(detailAddress.mas_bottom);
    }];
    
    InfoSeletedCompent *companyAddress = [InfoSeletedCompent new];
    [companyAddress setName:@"土方单位" info:@"浙江省西湖区"];
    [companyAddress jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself showUnlitListVC];
    }];
    [self.view addSubview:companyAddress];
    [companyAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(46);
        make.top.equalTo(thirdLine.mas_bottom);
        make.left.right.equalTo(self.view);
    }];
    
    UIView *fourthLine = [UIView new];
    fourthLine.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [self.view addSubview:fourthLine];
    [fourthLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(self.view);
        make.top.equalTo(companyAddress.mas_bottom);
    }];
    
    UIButton *button = [UIButton new];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.backgroundColor = [UIColor blueColor];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.right.equalTo(self.view).offset(-16);
        make.top.equalTo(fourthLine).offset(60);
        make.height.equalTo(46);
    }];
}

- (void)showUnlitListVC
{
    UnlitListVC *unlitListVC = [UnlitListVC new];
    [self presentViewController:unlitListVC animated:YES completion:nil];
}

@end
