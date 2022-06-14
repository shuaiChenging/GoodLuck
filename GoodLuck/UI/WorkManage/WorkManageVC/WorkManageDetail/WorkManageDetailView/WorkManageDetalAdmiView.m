//
//  WorkManageDetalAdmiView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/8.
//

#import "WorkManageDetalAdmiView.h"
@interface WorkManageDetalAdmiView ()
@property (nonatomic, strong) UILabel *printerStateLb;
@property (nonatomic, strong) UILabel *modelLb;
@property (nonatomic, strong) UILabel *offficeStateLb;
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

- (UILabel *)printerStateLb
{
    if (!_printerStateLb)
    {
        _printerStateLb = [UILabel labelWithText:@"未连接"
                                            font:[UIFont systemFontOfSize:12]
                                       textColor:[UIColor redColor]
                                       alignment:NSTextAlignmentLeft];
    }
    return _printerStateLb;
}

- (UILabel *)modelLb
{
    if (!_modelLb)
    {
        _modelLb = [UILabel labelWithText:@"离线"
                                     font:[UIFont systemFontOfSize:12]
                                textColor:[UIColor redColor]
                                alignment:NSTextAlignmentLeft];
    }
    return _modelLb;
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
    topLine.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
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
    
}

@end
