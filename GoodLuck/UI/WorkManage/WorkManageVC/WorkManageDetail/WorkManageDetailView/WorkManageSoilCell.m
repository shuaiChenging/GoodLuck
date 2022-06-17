//
//  WorkManageSoilCell.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/15.
//

#import "WorkManageSoilCell.h"
@interface WorkManageSoilCell ()
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *carLb;
@property (nonatomic, strong) UILabel *orderLb;
@end
@implementation WorkManageSoilCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
        [self customerUI];
    }
    
    return self;
}

+ (instancetype)cellWithCollectionView:(UITableView *)tableView
{
    WorkManageSoilCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    return cell;
}

- (UILabel *)nameLb
{
    if (!_nameLb)
    {
        _nameLb = [UILabel labelWithText:@"小明"
                                    font:[UIFont systemFontOfSize:13]
                               textColor:[UIColor blackColor]
                               alignment:NSTextAlignmentLeft];
    }
    return _nameLb;
}

- (UILabel *)carLb
{
    if (!_carLb)
    {
        _carLb = [UILabel labelWithText:@"车辆数：25"
                                   font:[UIFont systemFontOfSize:12]
                              textColor:[UIColor jk_colorWithHexString:@"#333333"]
                              alignment:NSTextAlignmentLeft];
    }
    return _carLb;
}

- (UILabel *)orderLb
{
    if (!_orderLb)
    {
        _orderLb = [UILabel labelWithText:@"工单数："
                                     font:[UIFont systemFontOfSize:12]
                                textColor:[UIColor jk_colorWithHexString:@"#333333"]
                                alignment:NSTextAlignmentLeft];
    }
    return _orderLb;
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
    
    [backView addSubview:self.nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(16);
        make.centerY.equalTo(backView);
    }];
    
    [backView addSubview:self.orderLb];
    [_orderLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-16);
        make.centerY.equalTo(backView);
    }];
    
    [backView addSubview:self.carLb];
    [_carLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.orderLb.mas_left).offset(-16);
        make.centerY.equalTo(backView);
    }];
}

@end
