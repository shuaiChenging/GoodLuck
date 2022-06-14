//
//  InfoSeletedCompent.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/6.
//

#import "InfoSeletedCompent.h"
@interface InfoSeletedCompent ()
@property (nonatomic, strong) UILabel *nameLb;
@end
@implementation InfoSeletedCompent

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        [self customerUI];
    }
    return self;
}

- (UILabel *)nameLb
{
    if (!_nameLb)
    {
        _nameLb = [UILabel labelWithText:@""
                                    font:[UIFont systemFontOfSize:15]
                               textColor:[UIColor blackColor]
                               alignment:NSTextAlignmentLeft];
    }
    return _nameLb;
}

- (UILabel *)infoLb
{
    if (!_infoLb)
    {
        _infoLb = [UILabel labelWithText:@""
                                    font:[UIFont systemFontOfSize:15]
                               textColor:[UIColor jk_colorWithHexString:@"#cccccc"]
                               alignment:NSTextAlignmentRight];
    }
    return _infoLb;
}

- (void)customerUI
{
    [self addSubview:self.nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.centerY.equalTo(self);
    }];
    
    UIImageView *arrowImg = [UIImageView new];
    arrowImg.image = [UIImage imageNamed:@"common_right_arrow"];
    [self addSubview:arrowImg];
    [arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(16);
        make.right.equalTo(self).offset(-16);
        make.centerY.equalTo(self);
    }];
    
    [self addSubview:self.infoLb];
    [_infoLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(100);
        make.right.equalTo(arrowImg.mas_left).offset(-2);
        make.centerY.equalTo(self);
    }];
}

- (void)setName:(NSString *)name info:(NSString *)info defaultInfo:(NSString *)defaultInfo
{
    self.nameLb.text = name;
    self.infoLb.text = defaultInfo;
    if (![Tools isEmpty:info])
    {
        self.infoLb.text = info;
        self.infoLb.textColor = [UIColor blackColor];
    }
    
}

@end
