//
//  WorkManageZDHeaderView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/8/31.
//

#import "WorkManageZDHeaderView.h"
@interface WorkManageZDHeaderView ()
@property (nonatomic, strong) UILabel *soilTypeLb;
@property (nonatomic, strong) UILabel *carCountLb;

@property (nonatomic, strong) UILabel *serialLeftLb;
@property (nonatomic, strong) UILabel *numberLeftLb;
@property (nonatomic, strong) UILabel *workNoLeftLb;

@property (nonatomic, strong) UILabel *serialRightLb;
@property (nonatomic, strong) UILabel *numberRightLb;
@property (nonatomic, strong) UILabel *workNoRightLb;
@end
@implementation WorkManageZDHeaderView

+ (instancetype)cellWithTableViewHeaderFooterView:(UITableView *)tableView
{
    WorkManageZDHeaderView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(self)];
    return footerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self customerUI];
    }
    return self;
}

- (UILabel *)soilTypeLb
{
    if (!_soilTypeLb)
    {
        _soilTypeLb = [UILabel labelWithText:@"灰土"
                                        font:[UIFont boldSystemFontOfSize:font_14]
                                   textColor:[UIColor jk_colorWithHexString:COLOR_BLUE]
                                   alignment:NSTextAlignmentLeft];
    }
    return _soilTypeLb;
}

- (UILabel *)carCountLb
{
    if (!_carCountLb)
    {
        _carCountLb = [UILabel labelWithText:@"总计：1车"
                                        font:[UIFont boldSystemFontOfSize:font_14]
                                   textColor:[UIColor jk_colorWithHexString:COLOR_BLUE]
                                   alignment:NSTextAlignmentRight];
    }
    return _carCountLb;
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

- (void)customerUI
{
    UIView *headerView = [UIView new];
    headerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.top.equalTo(self);
        make.height.equalTo(44);
    }];
    
    [headerView addSubview:self.soilTypeLb];
    [_soilTypeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(16);
        make.centerY.equalTo(headerView);
    }];
    
    [headerView addSubview:self.carCountLb];
    [_carCountLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.right.equalTo(headerView).offset(-16);
        make.centerY.equalTo(headerView);
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

- (void)loadViewWithName:(NSString *)name number:(NSString *)number
{
    self.soilTypeLb.text = name;
    self.carCountLb.text = [NSString stringWithFormat:@"总计：%@车",number];
}

@end
