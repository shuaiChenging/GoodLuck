//
//  WorkManageSoilHeaderView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/1.
//

#import "WorkManageSoilHeaderView.h"
@interface WorkManageSoilHeaderView ()
@property (nonatomic, strong) UILabel *soilTypeLb;
@property (nonatomic, strong) UILabel *carCountLb;
@end
@implementation WorkManageSoilHeaderView

+ (instancetype)cellWithTableViewHeaderFooterView:(UITableView *)tableView
{
    WorkManageSoilHeaderView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(self)];
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
    
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_FORM];
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(headerView);
        make.top.equalTo(headerView.mas_bottom);
        make.bottom.equalTo(self);
    }];
    
    UILabel *carNoLb = [UILabel labelWithText:@"车牌号码"
                                         font:[UIFont systemFontOfSize:font_12]
                                    textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                    alignment:NSTextAlignmentLeft];
    [contentView addSubview:carNoLb];
    [carNoLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(16);
        make.width.equalTo(80);
        make.centerY.equalTo(contentView);
    }];
    
    UILabel *orderLb = [UILabel labelWithText:@"工单"
                                         font:[UIFont systemFontOfSize:font_12]
                                    textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                    alignment:NSTextAlignmentLeft];
    [contentView addSubview:orderLb];
    [orderLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(80);
        make.right.equalTo(contentView);
        make.centerY.equalTo(contentView);
    }];
    
    UILabel *carTeamLb = [UILabel labelWithText:@"车队"
                                           font:[UIFont systemFontOfSize:font_12]
                                      textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                      alignment:NSTextAlignmentLeft];
    [contentView addSubview:carTeamLb];
    [carTeamLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(80);
        make.right.equalTo(orderLb.mas_left).offset(-2);
        make.centerY.equalTo(contentView);
    }];
    
    UILabel *soilTypeLb = [UILabel labelWithText:@"倒土方式"
                                            font:[UIFont systemFontOfSize:font_12]
                                       textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                       alignment:NSTextAlignmentLeft];
    [contentView addSubview:soilTypeLb];
    [soilTypeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(carNoLb.mas_right).offset(2);
        make.right.equalTo(carTeamLb.mas_left);
        make.centerY.equalTo(contentView);
    }];
}

- (void)loadViewWithModel:(WorkDetailSoilResponse *)response
{
    self.carCountLb.text = [NSString stringWithFormat:@"总计：%@",response.orderCount];
    self.soilTypeLb.text = response.key;
}

@end
