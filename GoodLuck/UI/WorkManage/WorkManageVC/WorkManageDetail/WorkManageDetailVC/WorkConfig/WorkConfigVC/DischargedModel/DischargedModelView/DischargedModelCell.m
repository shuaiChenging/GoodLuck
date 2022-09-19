//
//  DischargedModelCell.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/19.
//

#import "DischargedModelCell.h"
@interface DischargedModelCell ()
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *describeLb;
@property (nonatomic, strong) UIImageView *img;
@end
@implementation DischargedModelCell

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
    DischargedModelCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
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

- (UILabel *)nameLb
{
    if (!_nameLb)
    {
        _nameLb = [UILabel labelWithText:@"在线"
                                    font:[UIFont systemFontOfSize:16]
                               textColor:[UIColor blackColor]
                               alignment:NSTextAlignmentLeft];
    }
    return _nameLb;
}

- (UILabel *)describeLb
{
    if (!_describeLb)
    {
        _describeLb = [UILabel labelWithText:@"有网状态下才能放行"
                                        font:[UIFont systemFontOfSize:12]
                                   textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                   alignment:NSTextAlignmentLeft];
    }
    return _describeLb;
}

- (void)customerUI
{
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.describeLb];
    [_describeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLb.mas_right).offset(20);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.img];
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(20);
        make.right.equalTo(self.contentView).offset(-16);
        make.centerY.equalTo(self.contentView);
    }];
    
    UIView *bottomeLine = [UIView new];
    bottomeLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [self.contentView addSubview:bottomeLine];
    [bottomeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.contentView);
        make.height.equalTo(0.5);
    }];
}

- (void)loadViewWithModel:(DischargedModelModel *)model
{
    self.nameLb.text = model.item;
    self.describeLb.text = model.describe;
    self.img.image = [UIImage imageNamed: model.isSeleted ? @"manage_detail_seleted":@"manage_detail_selete_default"];
}
@end
