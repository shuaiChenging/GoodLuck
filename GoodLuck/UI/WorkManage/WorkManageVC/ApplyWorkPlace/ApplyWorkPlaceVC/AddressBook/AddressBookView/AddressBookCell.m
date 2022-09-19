//
//  AddressBookCell.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/5.
//

#import "AddressBookCell.h"
@interface AddressBookCell ()
@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, strong) UILabel *name;
@end
@implementation AddressBookCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        [self customerUI];
    }
    
    return self;
}
+ (instancetype)cellWithCollectionView:(UITableView *)tableView
{
    AddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    return cell;
}

- (UILabel *)name
{
    if (!_name)
    {
        _name = [UILabel labelWithText:@"" font:[UIFont systemFontOfSize:font_14]
                             textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                             alignment:NSTextAlignmentLeft];
    }
    return _name;
}

- (UIImageView *)img
{
    if (!_img)
    {
        _img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mange_detail_connect"]];
        _img.layer.masksToBounds = YES;
        _img.layer.cornerRadius = 20;
    }
    return _img;
}

- (void)customerUI
{
    [self.contentView addSubview:self.img];
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.width.height.equalTo(40);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.img.mas_right).offset(20);
        make.centerY.equalTo(self.contentView);
    }];
    
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.bottom.equalTo(self.contentView);
    }];
}

- (void)loadViewWithName:(NSString *)name image:(UIImage *)image
{
    self.img.image = image;
    self.name.text = name;
}

@end
