//
//  SeletedComponent.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/8/31.
//

#import "SeletedComponent.h"

@implementation SeletedComponent

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 12;
        self.layer.borderColor = [UIColor jk_colorWithHexString:@"#989898"].CGColor;
        self.layer.borderWidth = 1;
        self.userInteractionEnabled = YES;
        [self customerUI];
    }
    return self;
}

- (UILabel *)label
{
    if (!_label)
    {
        _label = [UILabel labelWithText:@"全部"
                                   font:[UIFont boldSystemFontOfSize:font_12]
                              textColor:[UIColor jk_colorWithHexString:@"#989898"]
                              alignment:NSTextAlignmentCenter];
    }
    return _label;
}

- (void)customerUI
{
    [self addSubview:self.label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
    }];
    
    UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_arrow_down"]];
    [self addSubview:arrow];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(10);
        make.height.equalTo(6);
        make.left.equalTo(self.label.mas_right).offset(8);
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self);
    }];
    
}

@end
