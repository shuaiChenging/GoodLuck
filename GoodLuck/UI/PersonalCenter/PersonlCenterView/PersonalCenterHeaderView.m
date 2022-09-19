//
//  PersonalCenterHeaderView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/4.
//

#import "PersonalCenterHeaderView.h"
#import "LoginInfoManage.h"
@interface PersonalCenterHeaderView ()
@property (nonatomic, strong) UIImageView *iconImg;
@end
@implementation PersonalCenterHeaderView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
        [self customerUI];
    }
    return self;
}

- (UIImageView *)iconImg
{
    if (!_iconImg)
    {
        _iconImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personal_icon"]];
        _iconImg.layer.masksToBounds = YES;
        _iconImg.layer.cornerRadius = 30;
    }
    return _iconImg;
}

- (UILabel *)nameLb
{
    if (!_nameLb)
    {
        _nameLb = [UILabel labelWithText:[LoginInfoManage shareInstance].personalResponse.name
                                    font:[UIFont systemFontOfSize:16]
                               textColor:[UIColor whiteColor]
                               alignment:NSTextAlignmentLeft];
    }
    return _nameLb;
}

- (UILabel *)phoneLb
{
    if (!_phoneLb)
    {
        _phoneLb = [UILabel labelWithText:[LoginInfoManage shareInstance].personalResponse.phone
                                     font:[UIFont systemFontOfSize:font_14]
                                textColor:[UIColor whiteColor]
                                alignment:NSTextAlignmentLeft];
    }
    return _phoneLb;
}

- (void)customerUI
{
    [self addSubview:self.iconImg];
    [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(60);
        make.top.left.equalTo(20);
    }];
    
    [self addSubview:self.nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.mas_right).offset(20);
        make.top.equalTo(self.iconImg).offset(8);
    }];
    
    [self addSubview:self.phoneLb];
    [_phoneLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLb);
        make.bottom.equalTo(self.iconImg.mas_bottom).offset(-8);
    }];
}

@end
