//
//  PriceManageFooterView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/29.
//

#import "PriceManageFooterView.h"
@implementation PriceManageFooterView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        [self customerUI];
    }
    return self;
}

- (UILabel *)nameLb
{
    if (!_nameLb)
    {
        _nameLb = [UILabel labelWithText:@"南庄码头"
                                    font:[UIFont systemFontOfSize:font_12]
                               textColor:[UIColor jk_colorWithHexString:@"#989898"]
                               alignment:NSTextAlignmentCenter];
    }
    return _nameLb;
}


- (void)customerUI
{
    UIView *backView = [UIView new];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.top.bottom.equalTo(self);
    }];
    
    [backView addSubview:self.nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(backView);
        make.height.equalTo(44);
        make.width.equalTo((kScreenWidth - 32)/3);
    }];
    
    UIView *sizeBack = [UIView new];
    sizeBack.backgroundColor = [UIColor whiteColor];
    [backView addSubview:sizeBack];
    [sizeBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLb.mas_right);
        make.height.equalTo(44);
        make.top.equalTo(backView);
        make.width.equalTo((kScreenWidth - 32)/3);
    }];
    
    UILabel *sizeLb = [UILabel labelWithText:@"车斗方"
                                        font:[UIFont systemFontOfSize:font_12]
                                   textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                   alignment:NSTextAlignmentCenter];
    [sizeBack addSubview:sizeLb];
    [sizeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(sizeBack);
    }];
    
    UIImageView *downImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"manage_detail_time_select"]];
    [sizeBack addSubview:downImg];
    [downImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sizeLb);
        make.left.equalTo(sizeLb.mas_right).offset(2);
        make.width.equalTo(9);
        make.height.equalTo(9.0/13 * 9);
    }];
    
    UILabel *priceLb = [UILabel labelWithText:@"0"
                                         font:[UIFont systemFontOfSize:font_12]
                                    textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                    alignment:NSTextAlignmentCenter];
    [backView addSubview:priceLb];
    [priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sizeBack.mas_right);
        make.centerY.equalTo(self.nameLb);
        make.width.equalTo((kScreenWidth - 32)/3);
    }];
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [backView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(backView);
        make.top.equalTo(self.nameLb.mas_bottom);
    }];
    
    UIView *backLine = [UIView new];
    backLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
    [self addSubview:backLine];
    [backLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView).offset(20);
        make.left.right.bottom.equalTo(self);
    }];
}
@end
