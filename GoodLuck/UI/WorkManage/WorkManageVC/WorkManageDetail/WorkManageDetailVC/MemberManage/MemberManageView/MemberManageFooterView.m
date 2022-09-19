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
        self.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        [self customerUI];
    }
    return self;
}

- (void)customerUI
{
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.top.bottom.equalTo(self);
    }];
    
    UILabel *addLb = [UILabel labelWithText:@"添加成员"
                                       font:[UIFont systemFontOfSize:14]
                                  textColor:[UIColor jk_colorWithHexString:COLOR_BLUE]
                                  alignment:NSTextAlignmentCenter];
    [backView addSubview:addLb];
    [addLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(backView);
    }];
    
    UIView *topLine = [UIView new];
    topLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [backView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.top.left.right.equalTo(backView);
    }];
    
}

@end
