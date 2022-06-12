//
//  MemberManageFooterView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/6.
//

#import "MemberManageFooterView.h"

@implementation MemberManageFooterView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
        [self customerUI];
    }
    return self;
}

- (UIView *)addView
{
    if (!_addView)
    {
        _addView = [UIView new];
        _addView.backgroundColor = [UIColor whiteColor];
    }
    return _addView;
}

- (UIView *)inviteView
{
    if (!_inviteView)
    {
        _inviteView = [UIView new];
        _inviteView.backgroundColor = [UIColor whiteColor];
    }
    return _inviteView;
}

- (void)customerUI
{
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.top.bottom.equalTo(self);
    }];
    
    [backView addSubview:self.addView];
    [_addView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(backView);
        make.right.equalTo(backView.mas_centerX);
        make.height.equalTo(46);
    }];
    
    UILabel *addLb = [UILabel labelWithText:@"添加成员"
                                       font:[UIFont systemFontOfSize:14]
                                  textColor:[UIColor blueColor]
                                  alignment:NSTextAlignmentCenter];
    [self.addView addSubview:addLb];
    [addLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.addView);
    }];
    
    [backView addSubview:self.inviteView];
    [_inviteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_centerX);
        make.top.right.equalTo(backView);
        make.height.equalTo(self.addView);
    }];
    
    UILabel *inviteLb = [UILabel labelWithText:@"邀请链接"
                                          font:[UIFont systemFontOfSize:14]
                                     textColor:[UIColor blueColor]
                                     alignment:NSTextAlignmentCenter];
    [self.inviteView addSubview:inviteLb];
    [inviteLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.inviteView);
    }];
    
    UIView *topLine = [UIView new];
    topLine.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [backView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.top.left.right.equalTo(backView);
    }];
    
    UIView *middleLine = [UIView new];
    middleLine.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [backView addSubview:middleLine];
    [middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(0.5);
        make.top.bottom.centerX.equalTo(backView);
    }];
}

@end
