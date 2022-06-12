//
//  MemberManageHeaderView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/6.
//

#import "MemberManageHeaderView.h"
@interface MemberManageHeaderView ()
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *describeLb;
@end
@implementation MemberManageHeaderView

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

- (UILabel *)nameLb
{
    if (!_nameLb)
    {
        _nameLb = [UILabel labelWithText:@""
                                    font:[UIFont boldSystemFontOfSize:15]
                               textColor:[UIColor whiteColor]
                               alignment:NSTextAlignmentLeft];
    }
    return _nameLb;
}

- (UILabel *)describeLb
{
    if (!_describeLb)
    {
        _describeLb = [UILabel labelWithText:@""
                                        font:[UIFont systemFontOfSize:13]
                                   textColor:[UIColor whiteColor]
                                   alignment:NSTextAlignmentLeft];
    }
    return _describeLb;
}

- (void)customerUI
{
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor blueColor];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.top.bottom.equalTo(self);
    }];
    
    [backView addSubview:self.nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(10);
        make.centerY.equalTo(backView);
    }];
    
    [backView addSubview:self.describeLb];
    [_describeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLb.mas_right).offset(10);
        make.centerY.equalTo(backView);
    }];
}

- (void)setName:(NSString *)name describe:(NSString *)describe
{
    self.nameLb.text = name;
    self.describeLb.text = describe;
}

@end
