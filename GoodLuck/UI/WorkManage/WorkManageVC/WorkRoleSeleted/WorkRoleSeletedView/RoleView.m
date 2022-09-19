//
//  RoleView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/4.
//

#import "RoleView.h"
@interface RoleView ()
@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UIImageView *seletedImg;
@end
@implementation RoleView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self customerUI];
    }
    return self;
}

- (UIImageView *)seletedImg
{
    if (!_seletedImg)
    {
        _seletedImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"manage_detail_seleted"]];
        _seletedImg.hidden = YES;
    }
    return _seletedImg;
}

- (UIImageView *)iconImg
{
    if (!_iconImg)
    {
        _iconImg = [UIImageView new];
    }
    return _iconImg;
}

- (UILabel *)nameLb
{
    if (!_nameLb)
    {
        _nameLb = [UILabel labelWithText:@"工地老板"
                                    font:[UIFont systemFontOfSize:font_14]
                                textColor:[UIColor jk_colorWithHexString:COLOR_7F7F7F]
                               alignment:NSTextAlignmentCenter];
    }
    return _nameLb;
}

- (void)customerUI
{
    [self addSubview:self.iconImg];
    [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(90);
        make.centerX.equalTo(self);
        make.top.equalTo(self);
    }];
    
    [self addSubview:self.seletedImg];
    [_seletedImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(18);
        make.right.equalTo(self.iconImg).offset(-6);
        make.top.equalTo(self.iconImg);
    }];
    
    [self addSubview:self.nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImg.mas_bottom).offset(20);
        make.centerX.equalTo(self);
    }];
}

- (void)setRole:(UIImage *)image name:(NSString *)name isSeleted:(BOOL)isSeleted
{
    self.iconImg.image = image;
    self.nameLb.text = name;
    self.iconImg.alpha = isSeleted ? 1.0 : 0.5;
    self.seletedImg.hidden = !isSeleted;
    self.nameLb.textColor = isSeleted ? [UIColor blackColor] : [UIColor jk_colorWithHexString:COLOR_7F7F7F];
}

@end
