//
//  IconNameView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/5.
//

#import "IconNameView.h"
@interface IconNameView ()
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *label;
@end
@implementation IconNameView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self customerUI];
    }
    return self;
}

- (UIImageView *)iconImage
{
    if (!_iconImage)
    {
        _iconImage = [UIImageView new];
        _iconImage.backgroundColor = [UIColor grayColor];
    }
    return _iconImage;
}

- (UILabel *)label
{
    if (!_label)
    {
        _label = [UILabel labelWithText:@"详细信息"
                                   font:[UIFont systemFontOfSize:12]
                              textColor:nil
                              alignment:NSTextAlignmentCenter];
    }
    return _label;
}

- (void)customerUI
{
    [self addSubview:self.iconImage];
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(30);
        make.top.equalTo(self).offset(20);
        make.centerX.equalTo(self);
    }];
    
    [self addSubview:self.label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.iconImage.mas_bottom).offset(10);
        make.bottom.equalTo(self).offset(-20);
    }];
}

- (void)setImageName:(NSString *)imageName name:(NSString *)name
{
    self.iconImage.image = [UIImage imageNamed:imageName];
    self.label.text = name;
}

@end
