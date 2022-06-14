//
//  WorkManageLeftItemView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/7.
//

#import "WorkManageLeftItemView.h"
@interface WorkManageLeftItemView ()
@property (nonatomic, strong) UIImageView *imgIcon;
@property (nonatomic, strong) UILabel *nameLb;
@end
@implementation WorkManageLeftItemView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.userInteractionEnabled = YES;
//        [self customerUI];
    }
    return self;
}

- (UIImageView *)imgIcon
{
    if (!_imgIcon)
    {
        _imgIcon = [UIImageView new];
        _imgIcon.backgroundColor = [UIColor grayColor];
    }
    return _imgIcon;
}

- (UILabel *)nameLb
{
    if (!_nameLb)
    {
        _nameLb = [UILabel labelWithText:@"老板"
                                    font:[UIFont systemFontOfSize:14]
                               textColor:[UIColor blackColor]
                               alignment:NSTextAlignmentLeft];
    }
    return _nameLb;
}

- (void)customerUI
{
    [self addSubview:self.imgIcon];
    [_imgIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(30);
        make.centerY.equalTo(self);
        make.left.equalTo(self);
    }];
    
    [self addSubview:self.nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgIcon.mas_right).offset(6);
        make.centerY.equalTo(self);
    }];
}

- (void)setImageName:(NSString *)imageName name:(NSString *)name
{
    self.imgIcon.image = [UIImage imageNamed:imageName];
    self.nameLb.text = name;
}

@end
