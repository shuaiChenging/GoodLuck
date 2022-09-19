//
//  WorkManageDetalAdmiView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/8.
//

#import "WorkManageDetalAdmiView.h"
@interface WorkManageDetalAdmiView ()
@property (nonatomic, strong) UIImageView *stateImg;
@end

@implementation WorkManageDetalAdmiView

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

- (UIImageView *)stateImg
{
    if (!_stateImg)
    {
        _stateImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"manage_detail_sun"]];
    }
    return _stateImg;
}

- (UILabel *)printerStateLb
{
    if (!_printerStateLb)
    {
        _printerStateLb = [UILabel labelWithText:@"未连接"
                                            font:[UIFont systemFontOfSize:12]
                                       textColor:[UIColor redColor]
                                       alignment:NSTextAlignmentLeft];
        _printerStateLb.userInteractionEnabled = YES;
    }
    return _printerStateLb;
}

- (UILabel *)offficeStateLb
{
    if (!_offficeStateLb)
    {
        _offficeStateLb = [UILabel labelWithText:@"白班"
                                            font:[UIFont systemFontOfSize:12]
                                       textColor:[UIColor blackColor]
                                       alignment:NSTextAlignmentLeft];
    }
    return _offficeStateLb;
}

- (void)customerUI
{
    UIView *topLine = [UIView new];
    topLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [self addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(1);
    }];
    
    UILabel *printState = [UILabel labelWithText:@"打印机状态:"
                                            font:[UIFont systemFontOfSize:12]
                                       textColor:[UIColor blackColor]
                                       alignment:NSTextAlignmentLeft];
    [self addSubview:printState];
    [printState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.centerY.equalTo(self);
    }];
    
    [self addSubview:self.printerStateLb];
    [_printerStateLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(printState.mas_right).offset(6);
        make.centerY.equalTo(self);
    }];
    
    [self addSubview:self.offficeStateLb];
    [_offficeStateLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-16);
        make.centerY.equalTo(self);
    }];

    [self addSubview:self.stateImg];
    [_stateImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(20);
        make.centerY.equalTo(self);
        make.right.equalTo(self.offficeStateLb.mas_left).offset(-8);
    }];
    
}

- (void)changeState:(BOOL)isDay
{
    self.offficeStateLb.text = isDay ? @"白班" : @"晚班";
    _stateImg.image = [UIImage imageNamed:isDay ? @"manage_detail_sun":@"manage_detail_moon"];
}

@end
