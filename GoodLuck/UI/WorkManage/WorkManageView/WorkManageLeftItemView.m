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
@property (nonatomic, strong) UIImageView *arrowImg;
@end
@implementation WorkManageLeftItemView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.userInteractionEnabled = YES;
        [self customerUI];
    }
    return self;
}

- (UIImageView *)imgIcon
{
    if (!_imgIcon)
    {
        _imgIcon = [UIImageView new];
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

- (UIImageView *)arrowImg
{
    if (!_arrowImg)
    {
        _arrowImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"manage_detail_time_select"]];
    }
    return _arrowImg;
}

- (void)customerUI
{
    [self addSubview:self.imgIcon];
    _imgIcon.frame = CGRectMake(0, 7, 30, 30);
    
    [self addSubview:self.nameLb];
    _nameLb.frame = CGRectMake(36, 0, 90, 44);
    
    [self addSubview:self.arrowImg];
}

- (void)setImageName:(NSString *)imageName name:(NSString *)name
{
    self.imgIcon.image = [UIImage imageNamed:imageName];
    self.nameLb.text = name;
    CGSize size = [self.nameLb sizeThatFits:CGSizeMake(MAXFLOAT, 44)];
    _arrowImg.frame = CGRectMake(36 + size.width + 2, 18 , 9, 9.0/13 * 9);
}

@end
