//
//  BluetoothMatchCell.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/7.
//

#import "BluetoothMatchCell.h"
@interface BluetoothMatchCell ()
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *subNameLb;
@end
@implementation BluetoothMatchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self customerUI];
    }
    
    return self;
}

- (UILabel *)nameLb
{
    if (!_nameLb)
    {
        _nameLb = [UILabel labelWithText:@""
                                    font:[UIFont systemFontOfSize:font_16]
                               textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                               alignment:NSTextAlignmentLeft];
    }
    return _nameLb;
}

- (UILabel *)subNameLb
{
    if (!_subNameLb)
    {
        _subNameLb = [UILabel labelWithText:@""
                                       font:[UIFont systemFontOfSize:font_14]
                                  textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                  alignment:NSTextAlignmentLeft];
    }
    return _subNameLb;
}

+ (instancetype)cellWithCollectionView:(UITableView *)tableView
{
    BluetoothMatchCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    return cell;
}

- (void)customerUI
{
    [self.contentView addSubview:self.nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.top.equalTo(self.contentView).offset(8);
    }];
    
    [self.contentView addSubview:self.subNameLb];
    [_subNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.top.equalTo(self.nameLb.mas_bottom).offset(4);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.bottom.equalTo(self.contentView);
    }];
}

- (void)loadViewWithName:(NSString *)name subName:(NSString *)subName
{
    self.nameLb.text = name;
    self.subNameLb.text = subName;
}

@end
