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
        _nameLb = [UILabel labelWithText:@"工地老板"
                                    font:[UIFont systemFontOfSize:14]
                                textColor:[UIColor jk_colorWithHexString:@"#666666"]
                               alignment:NSTextAlignmentCenter];
    }
    return _nameLb;
}

- (void)customerUI
{
    [self addSubview:self.iconImg];
    [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(80);
        make.centerX.equalTo(self);
        make.top.equalTo(self);
    }];
    
    [self addSubview:self.nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImg.mas_bottom).offset(6);
        make.centerX.equalTo(self);
    }];
}

- (void)setRole:(UIImage *)image name:(NSString *)name isSeleted:(BOOL)isSeleted
{
    self.iconImg.image = image;
    self.nameLb.text = name;
    self.nameLb.textColor = isSeleted ? [UIColor redColor] : [UIColor jk_colorWithHexString:@"#666666"];
}

@end
