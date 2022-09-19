//
//  WorkManageCardHeaderView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/15.
//

#import "WorkManageCardHeaderView.h"
@interface WorkManageCardHeaderView ()
@property (nonatomic, strong) UILabel *timeLb;
@property (nonatomic, strong) UILabel *enterNumber;
@property (nonatomic, strong) UILabel *outNumber;
@property (nonatomic, strong) UILabel *carNumber;

@property (nonatomic, strong) UILabel *serialLeftLb;
@property (nonatomic, strong) UILabel *numberLeftLb;
@property (nonatomic, strong) UILabel *workNoLeftLb;

@property (nonatomic, strong) UILabel *serialRightLb;
@property (nonatomic, strong) UILabel *numberRightLb;
@property (nonatomic, strong) UILabel *workNoRightLb;
@end
@implementation WorkManageCardHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        [self customerUI];
    }
    return self;
}

+ (instancetype)cellWithTableViewHeaderFooterView:(UITableView *)tableView
{
    WorkManageCardHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(self)];
    return headerView;
}

- (UILabel *)serialLeftLb
{
    if (!_serialLeftLb)
    {
        _serialLeftLb = [UILabel labelWithText:@"编号"
                                          font:[UIFont systemFontOfSize:12]
                                     textColor:[UIColor jk_colorWithHexString:@"#333333"]
                                     alignment:NSTextAlignmentLeft];
    }
    return _serialLeftLb;
}

- (UILabel *)numberLeftLb
{
    if (!_numberLeftLb)
    {
        _numberLeftLb = [UILabel labelWithText:@"车牌号码"
                                          font:[UIFont systemFontOfSize:12]
                                     textColor:[UIColor jk_colorWithHexString:@"#333333"]
                                     alignment:NSTextAlignmentCenter];
    }
    return _numberLeftLb;
}

- (UILabel *)workNoLeftLb
{
    if (!_workNoLeftLb)
    {
        _workNoLeftLb = [UILabel labelWithText:@"工单"
                                          font:[UIFont systemFontOfSize:12]
                                     textColor:[UIColor jk_colorWithHexString:@"#333333"]
                                     alignment:NSTextAlignmentRight];
    }
    return _workNoLeftLb;
}

- (UILabel *)serialRightLb
{
    if (!_serialRightLb)
    {
        _serialRightLb = [UILabel labelWithText:@"编号"
                                           font:[UIFont systemFontOfSize:12]
                                      textColor:[UIColor jk_colorWithHexString:@"#333333"]
                                      alignment:NSTextAlignmentLeft];
    }
    return _serialRightLb;
}

- (UILabel *)numberRightLb
{
    if (!_numberRightLb)
    {
        _numberRightLb = [UILabel labelWithText:@"车牌号码"
                                           font:[UIFont systemFontOfSize:12]
                                      textColor:[UIColor jk_colorWithHexString:@"#333333"]
                                      alignment:NSTextAlignmentCenter];
    }
    return _numberRightLb;
}

- (UILabel *)workNoRightLb
{
    if (!_workNoRightLb)
    {
        _workNoRightLb = [UILabel labelWithText:@"工单"
                                           font:[UIFont systemFontOfSize:12]
                                      textColor:[UIColor jk_colorWithHexString:@"#333333"]
                                      alignment:NSTextAlignmentRight];
    }
    return _workNoRightLb;
}

- (UILabel *)timeLb
{
    if (!_timeLb)
    {
        _timeLb = [UILabel labelWithText:@"2022-06-18"
                                    font:[UIFont boldSystemFontOfSize:font_14]
                               textColor:[UIColor jk_colorWithHexString:COLOR_BLUE]
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
        make.top.equalTo(self);
        make.bottom.equalTo(self).offset(-40);
    }];
    
    UIView *circleView = [UIView new];
    circleView.layer.masksToBounds = YES;
    circleView.layer.cornerRadius = 5;
    circleView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
    [backView addSubview:circleView];
    [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(10);
        make.left.equalTo(backView).offset(16);
        make.top.equalTo(backView).offset(20);
    }];
    
    [backView addSubview:self.timeLb];
    [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(circleView.mas_right).offset(10);
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
    
    [backView addSubview:self.carNumber];
    [_carNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-16);
        make.centerY.equalTo(self.enterNumber);
    }];
    
    UIView *bottomBack = [UIView new];
    bottomBack.backgroundColor = [UIColor jk_colorWithHexString:COLOR_FORM];
    [self addSubview:bottomBack];
    [bottomBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.bottom.equalTo(self);
        make.height.equalTo(40);
    }];
    
    UIView *leftView = [UIView new];
    [bottomBack addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(bottomBack);
        make.right.equalTo(bottomBack.mas_centerX);
    }];
    
    UIView *rightView = [UIView new];
    [bottomBack addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomBack.mas_centerX);
        make.top.right.bottom.equalTo(bottomBack);
    }];
    
    [leftView addSubview:self.serialLeftLb];
    [_serialLeftLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftView).offset(16);
        make.centerY.equalTo(leftView);
    }];
    
    [leftView addSubview:self.numberLeftLb];
    [_numberLeftLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(leftView);
    }];
    
    [leftView addSubview:self.workNoLeftLb];
    [_workNoLeftLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(leftView).offset(-16);
        make.centerY.equalTo(leftView);
    }];
    
    UIView *middleView = [UIView new];
    middleView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [bottomBack addSubview:middleView];
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(0.5);
        make.top.bottom.equalTo(bottomBack);
        make.centerX.equalTo(bottomBack);
    }];
    
    [rightView addSubview:self.serialRightLb];
    [_serialRightLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rightView).offset(16);
        make.centerY.equalTo(rightView);
    }];
    
    [leftView addSubview:self.numberRightLb];
    [_numberRightLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(rightView);
    }];
    
    [leftView addSubview:self.workNoRightLb];
    [_workNoRightLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(rightView).offset(-16);
        make.centerY.equalTo(rightView);
    }];
}

- (void)loadViewWithModel:(WorkDetailCardResponse *)model
{
    self.enterNumber.text = [NSString stringWithFormat:@"车队：%@",model.fleetCount];
    self.outNumber.text = [NSString stringWithFormat:@"车辆：%@",model.carCount];
    self.carNumber.text = [NSString stringWithFormat:@"工单数：%@",model.orderCount];
    self.timeLb.text = model.key;
}

@end
