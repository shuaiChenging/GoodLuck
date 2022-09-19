//
//  WorkManageCarTeamHeaderView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/25.
//

#import "WorkManageCarTeamHeaderView.h"
@interface WorkManageCarTeamHeaderView ()
@property (nonatomic, strong) UILabel *timeLb;
@property (nonatomic, strong) UILabel *enterNumber;
@property (nonatomic, strong) UILabel *carNumber;

@property (nonatomic, strong) UILabel *serialLeftLb;
@property (nonatomic, strong) UILabel *numberLeftLb;
@property (nonatomic, strong) UILabel *workNoLeftLb;

@property (nonatomic, strong) UILabel *serialRightLb;
@property (nonatomic, strong) UILabel *numberRightLb;
@property (nonatomic, strong) UILabel *workNoRightLb;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UILabel *allNumberLb;
@property (nonatomic, strong) UILabel *allCarLb;

@end
@implementation WorkManageCarTeamHeaderView

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
    WorkManageCarTeamHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(self)];
    return headerView;
}

- (UIView *)backView
{
    if (!_backView)
    {
        _backView = [UIView new];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

- (UIView *)topView
{
    if (!_topView)
    {
        _topView = [UIView new];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
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

- (UILabel *)allNumberLb
{
    if (!_allNumberLb)
    {
        _allNumberLb = [UILabel labelWithText:@"2"
                                         font:[UIFont boldSystemFontOfSize:font_16]
                                    textColor:[UIColor jk_colorWithHexString:COLOR_BLUE]
                                    alignment:NSTextAlignmentCenter];
    }
    return _allNumberLb;
}

- (UILabel *)allCarLb
{
    if (!_allCarLb)
    {
        _allCarLb = [UILabel labelWithText:@"3"
                                      font:[UIFont boldSystemFontOfSize:font_16]
                                 textColor:[UIColor jk_colorWithHexString:COLOR_BLUE]
                                 alignment:NSTextAlignmentCenter];
    }
    return _allCarLb;
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
    [self addSubview:self.topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.height.equalTo(74);
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
    }];
    
    UIView *topLeftView = [UIView new];
    [_topView addSubview:topLeftView];
    [topLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.topView);
        make.right.equalTo(self.topView.mas_centerX);
    }];
    
    UIView *topRightView = [UIView new];
    [_topView addSubview:topRightView];
    [topRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.topView);
        make.left.equalTo(self.topView.mas_centerX);
    }];
    
    [topLeftView addSubview:self.allNumberLb];
    [_allNumberLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topLeftView);
        make.top.equalTo(topLeftView).offset(12);
    }];
    
    UILabel *allNumberDesLb = [UILabel labelWithText:@"总工单数"
                                                font:[UIFont systemFontOfSize:font_12]
                                           textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                           alignment:NSTextAlignmentCenter];
    [topLeftView addSubview:allNumberDesLb];
    [allNumberDesLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(topLeftView).offset(-12);
        make.centerX.equalTo(topLeftView);
    }];
    
    [topRightView addSubview:self.allCarLb];
    [_allCarLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topRightView).offset(12);
        make.centerX.equalTo(topRightView);
    }];
    
    UILabel *allCarDesLb = [UILabel labelWithText:@"车辆数"
                                             font:[UIFont systemFontOfSize:font_12]
                                        textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                        alignment:NSTextAlignmentCenter];
    [topRightView addSubview:allCarDesLb];
    [allCarDesLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(topRightView).offset(-12);
        make.centerX.equalTo(topRightView);
    }];
    
    
    [self addSubview:self.backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.top.equalTo(self);
        make.bottom.equalTo(self).offset(-40);
    }];
    
    UIView *circleView = [UIView new];
    circleView.layer.masksToBounds = YES;
    circleView.layer.cornerRadius = 5;
    circleView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
    [_backView addSubview:circleView];
    [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(10);
        make.left.equalTo(_backView).offset(16);
        make.top.equalTo(_backView).offset(20);
    }];
    
    [_backView addSubview:self.timeLb];
    [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(circleView.mas_right).offset(10);
        make.centerY.equalTo(circleView);
    }];
    
    [_backView addSubview:self.enterNumber];
    [_enterNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView).offset(16);
        make.bottom.equalTo(_backView).offset(-16);
    }];
    
    [_backView addSubview:self.carNumber];
    [_carNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_backView).offset(-16);
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

- (void)loadViewWithModel:(WorkDetailCardTeamListResponse *)model indexRow:(NSInteger)row response:(WorkDetailCardTeamResponse *)response
{
    self.enterNumber.text = [NSString stringWithFormat:@"工单数：%@",model.orderCount];
    self.carNumber.text = [NSString stringWithFormat:@"车辆：%@",model.carCount];
    self.timeLb.text = model.fleetName;
    
    [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(row == 0 ? 90 : 0);
    }];
    
    self.topView.hidden = row != 0;
    
    self.allCarLb.text = response.carCount;
    self.allNumberLb.text = response.orderCount;
}

@end
