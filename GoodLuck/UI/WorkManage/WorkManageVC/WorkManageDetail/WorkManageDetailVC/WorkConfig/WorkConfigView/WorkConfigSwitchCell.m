//
//  WorkConfigSwitchCell.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/9.
//

#import "WorkConfigSwitchCell.h"
@interface WorkConfigSwitchCell ()
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *describeLb;
@property (nonatomic, strong) UISwitch *customerSwitch;
@end
@implementation WorkConfigSwitchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self customerUI];
    }
    
    return self;
}

+ (instancetype)cellWithCollectionView:(UITableView *)tableView
{
    WorkConfigSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    return cell;
}

- (UISwitch *)customerSwitch
{
    if (!_customerSwitch)
    {
        _customerSwitch = [UISwitch new];
    }
    return _customerSwitch;
}

- (UILabel *)nameLb
{
    if (!_nameLb)
    {
        _nameLb = [UILabel labelWithText:@"账号与安全"
                                    font:[UIFont systemFontOfSize:15]
                               textColor:nil
                               alignment:NSTextAlignmentLeft];
    }
    return _nameLb;
}

- (UILabel *)describeLb
{
    if (!_describeLb)
    {
        _describeLb = [UILabel labelWithText:@"账号与安全"
                                        font:[UIFont systemFontOfSize:13]
                                   textColor:[UIColor jk_colorWithHexString:@"#333333"]
                                   alignment:NSTextAlignmentLeft];
    }
    return _describeLb;
}

- (void)customerUI
{
    [self.contentView addSubview:self.nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.top.equalTo(self.contentView).offset(16);
    }];
    
    [self.contentView addSubview:self.describeLb];
    [_describeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLb);
        make.top.equalTo(self.nameLb.mas_bottom).offset(10);
    }];
    
    [self.contentView addSubview:self.customerSwitch];
    [_customerSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-16);
        make.centerY.equalTo(self.nameLb);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(0.5);
    }];
}

- (void)loadViewWithModel:(WorkConfigDetailModel *)model
{
    self.nameLb.text = model.name;
    self.describeLb.text = model.describe;
}

@end
