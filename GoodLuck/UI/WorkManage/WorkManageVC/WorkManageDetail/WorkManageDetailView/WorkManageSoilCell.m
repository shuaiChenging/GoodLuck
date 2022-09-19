//
//  WorkManageSoilCell.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/15.
//

#import "WorkManageSoilCell.h"
@interface WorkManageSoilCell ()
@property (nonatomic, strong) UILabel *carNoLb;
@property (nonatomic, strong) UILabel *typeLb;
@property (nonatomic, strong) UILabel *carCountLb;
@property (nonatomic, strong) UILabel *teamLb;
@end
@implementation WorkManageSoilCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        [self customerUI];
    }
    
    return self;
}

+ (instancetype)cellWithCollectionView:(UITableView *)tableView
{
    WorkManageSoilCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    return cell;
}

- (UILabel *)carNoLb
{
    if (!_carNoLb)
    {
        _carNoLb = [UILabel labelWithText:@"苏E3445"
                                     font:[UIFont systemFontOfSize:13]
                                textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                alignment:NSTextAlignmentLeft];
    }
    return _carNoLb;
}

- (UILabel *)teamLb
{
    if (!_teamLb)
    {
        _teamLb = [UILabel labelWithText:@"车队"
                                    font:[UIFont systemFontOfSize:font_13]
                               textColor:[UIColor jk_colorWithHexString:@"#989898"]
                               alignment:NSTextAlignmentLeft];
    }
    return _teamLb;
}

- (UILabel *)typeLb
{
    if (!_typeLb)
    {
        _typeLb = [UILabel labelWithText:@"自倒"
                                    font:[UIFont systemFontOfSize:12]
                               textColor:[UIColor jk_colorWithHexString:@"#989898"]
                               alignment:NSTextAlignmentLeft];
    }
    return _typeLb;
}

- (UILabel *)carCountLb
{
    if (!_carCountLb)
    {
        _carCountLb = [UILabel labelWithText:@"1车"
                                        font:[UIFont systemFontOfSize:12]
                                   textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                   alignment:NSTextAlignmentLeft];
    }
    return _carCountLb;
}


- (void)customerUI
{
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.top.equalTo(self.contentView);
        make.height.equalTo(40);
    }];
    
    [backView addSubview:self.carNoLb];
    [_carNoLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(16);
        make.centerY.equalTo(backView);
        make.width.equalTo(80);
    }];
    
    UIView *leftLine = [UIView new];
    leftLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [backView addSubview:leftLine];
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(0.5);
        make.top.bottom.equalTo(backView);
        make.left.equalTo(self.carNoLb.mas_right);
    }];
    
    [backView addSubview:self.carCountLb];
    [_carCountLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView);
        make.centerY.equalTo(backView);
        make.width.equalTo(80);
    }];
    
    UIView *rightLine = [UIView new];
    rightLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [backView addSubview:rightLine];
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(0.5);
        make.top.bottom.equalTo(backView);
        make.right.equalTo(self.carCountLb.mas_left).offset(-2);
    }];
    
    [backView addSubview:self.teamLb];
    [_teamLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(80);
        make.centerY.equalTo(backView);
        make.right.equalTo(rightLine.mas_left);
    }];
    
    UIView *carLine = [UIView new];
    carLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [backView addSubview:carLine];
    [carLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(0.5);
        make.top.bottom.equalTo(backView);
        make.right.equalTo(self.teamLb.mas_left).offset(-2);
    }];
    
    [backView addSubview:self.typeLb];
    [_typeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftLine.mas_right).offset(2);
        make.right.equalTo(carLine.mas_left);
        make.centerY.equalTo(backView);
    }];
}

- (void)loadViewWithModel:(WorkDetailSoilItemResponse *)model
{
    self.carNoLb.text = model.plateNumber;
    self.typeLb.text = model.ztcName;
    self.carCountLb.text = [NSString stringWithFormat:@"%@车",model.orderCount];
    self.teamLb.text = model.fleetName;
}

@end
