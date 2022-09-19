//
//  UniltListCell.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/8.
//

#import "UniltListCell.h"
@interface UniltListCell ()
@property (nonatomic, strong) UILabel *contentLb;
@property (nonatomic, strong) UIImageView *img;
@end
@implementation UniltListCell

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
    UniltListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    return cell;
}

- (UIImageView *)img
{
    if (!_img)
    {
        _img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"manage_detail_selete_default"]];
    }
    return _img;
}

- (UILabel *)contentLb
{
    if (!_contentLb)
    {
        _contentLb = [UILabel labelWithText:@""
                                       font:[UIFont systemFontOfSize:14]
                                  textColor:[UIColor blackColor]
                                  alignment:NSTextAlignmentLeft];
    }
    return _contentLb;
}

- (void)loadViewWithModel:(CompanyListResponse *)model
{
    self.contentLb.text = model.name;
    self.img.image = [UIImage imageNamed: model.isSeleted ? @"manage_detail_seleted":@"manage_detail_selete_default"];
}

- (void)customerUI
{
    [self.contentView addSubview:self.contentLb];
    [_contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(16);
    }];
    
    [self.contentView addSubview:self.img];
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(20);
        make.right.equalTo(self.contentView).offset(-16);
        make.centerY.equalTo(self.contentView);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.equalTo(0.5);
    }];
}
@end
