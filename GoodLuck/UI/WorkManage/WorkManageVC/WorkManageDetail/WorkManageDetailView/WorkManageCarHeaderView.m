//
//  WorkManageCarHeaderView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/15.
//

#import "WorkManageCarHeaderView.h"
@interface WorkManageCarHeaderView ()
@property (nonatomic, strong) UILabel *timeLb;
@property (nonatomic, strong) UILabel *enterNumber;
@property (nonatomic, strong) UILabel *outNumber;
@property (nonatomic, strong) UILabel *carNumber;
@end
@implementation WorkManageCarHeaderView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self customerUI];
    }
    return self;
}

- (UILabel *)timeLb
{
    if (!_timeLb)
    {
        _timeLb = [UILabel labelWithText:@""
                                    font:[UIFont boldSystemFontOfSize:13]
                               textColor:[UIColor blueColor]
                               alignment:NSTextAlignmentLeft];
    }
    return _timeLb;
}

- (UILabel *)enterNumber
{
    if (!_enterNumber)
    {
        _enterNumber = [UILabel labelWithText:@"入场车数："
                                         font:[UIFont boldSystemFontOfSize:12]
                                    textColor:[UIColor blackColor]
                                    alignment:NSTextAlignmentLeft];
    }
    return _enterNumber;
}

- (UILabel *)outNumber
{
    if (!_outNumber)
    {
        _outNumber = [UILabel labelWithText:@"出场车数："
                                       font:[UIFont boldSystemFontOfSize:12]
                                  textColor:[UIColor blackColor]
                                  alignment:NSTextAlignmentLeft];
    }
    return _outNumber;
}

- (UILabel *)carNumber
{
    if (!_carNumber)
    {
        _carNumber = [UILabel labelWithText:@"车辆数："
                                       font:[UIFont boldSystemFontOfSize:12]
                                  textColor:[UIColor blackColor]
                                  alignment:NSTextAlignmentLeft];
    }
    return _carNumber;
}

- (void)customerUI
{
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.top.bottom.equalTo(self);
    }];
    
    UIView *circleView = [UIView new];
    circleView.layer.masksToBounds = YES;
    circleView.layer.cornerRadius = 5;
    circleView.backgroundColor = [UIColor blueColor];
    [backView addSubview:circleView];
    [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(10);
        make.left.equalTo(backView).offset(16);
        make.top.equalTo(backView).offset(20);
    }];
    
    [backView addSubview:self.timeLb];
    [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(circleView.mas_right).offset(16);
        make.centerY.equalTo(circleView);
    }];
    
    [backView addSubview:self.enterNumber];
    [_enterNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(16);
        make.bottom.equalTo(backView).offset(-16);
    }];
    
    [backView addSubview:self.outNumber];
    [_outNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.enterNumber);
        make.centerX.equalTo(self);
    }];
    
}

@end
