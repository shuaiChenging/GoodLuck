//
//  PersonalCenterHeaderView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/4.
//

#import "PersonalCenterHeaderView.h"
@interface PersonalCenterHeaderView ()
@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILabel *nameLb;
@end
@implementation PersonalCenterHeaderView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor blueColor];
        [self customerUI];
    }
    return self;
}

- (UIImageView *)iconImg
{
    if (!_iconImg)
    {
        _iconImg = [UIImageView new];
        _iconImg.backgroundColor = [UIColor grayColor];
        _iconImg.layer.masksToBounds = YES;
        _iconImg.layer.cornerRadius = 30;
    }
    return _iconImg;
}

- (UILabel *)nameLb
{
    if (!_nameLb)
    {
        _nameLb = [UILabel labelWithText:@"111111"
                                    font:[UIFont systemFontOfSize:16]
                               textColor:[UIColor whiteColor]
                               alignment:NSTextAlignmentLeft];
    }
    return _nameLb;
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
        make.centerY.equalTo(self.iconImg);
    }];
}

@end
