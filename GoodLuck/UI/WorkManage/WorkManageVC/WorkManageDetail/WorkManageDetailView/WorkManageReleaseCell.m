//
//  WorkManageReleaseCell.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/2.
//

#import "WorkManageReleaseCell.h"
@interface WorkManageReleaseCell ()
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *carLb;
@property (nonatomic, strong) UILabel *allLb;
@property (nonatomic, strong) UILabel *driveLb;
@property (nonatomic, strong) UILabel *typeLb;
@property (nonatomic, strong) UILabel *timeLb;
@end
@implementation WorkManageReleaseCell

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
    WorkManageReleaseCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    return cell;
}

- (UIImageView *)image
{
    if (!_image)
    {
        _image = [UIImageView new];
        _image.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
    }
    return _image;
}

- (UILabel *)carLb
{
    if (!_carLb)
    {
        _carLb = [UILabel labelWithText:@"浙E"
                                   font:[UIFont boldSystemFontOfSize:16]
                              textColor:[UIColor blackColor]
                              alignment:NSTextAlignmentLeft];
    }
    return _carLb;
}

- (UILabel *)allLb
{
    if (!_allLb)
    {
        _allLb = [UILabel labelWithText:@"累计："
                                   font:[UIFont systemFontOfSize:14]
                              textColor:[UIColor jk_colorWithHexString:@"#989898"]
                              alignment:NSTextAlignmentLeft];
    }
    return _allLb;
}

- (UILabel *)driveLb
{
    if (!_driveLb)
    {
        _driveLb = [UILabel labelWithText:@"司机："
                                     font:[UIFont systemFontOfSize:12]
                                textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                alignment:NSTextAlignmentLeft];
    }
    return _driveLb;
}

- (UILabel *)typeLb
{
    if (!_typeLb)
    {
        _typeLb = [UILabel labelWithText:@"自倒"
                                    font:[UIFont systemFontOfSize:14]
                               textColor:[UIColor jk_colorWithHexString:COLOR_BLUE]
                               alignment:NSTextAlignmentLeft];
    }
    return _typeLb;
}

- (UILabel *)timeLb
{
    if (!_timeLb)
    {
        _timeLb = [UILabel labelWithText:@"时间"
                                    font:[UIFont systemFontOfSize:12]
                               textColor:[UIColor jk_colorWithHexString:@"#989898"]
                               alignment:NSTextAlignmentLeft];
    }
    return _timeLb;
}

- (void)customerUI
{
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.top.bottom.equalTo(self.contentView);
    }];
    
    [backView addSubview:self.image];
    [_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(100);
        make.height.equalTo(70);
        make.left.equalTo(backView).offset(16);
        make.centerY.equalTo(backView);
    }];
    
    [backView addSubview:self.carLb];
    [_carLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.top.equalTo(self.image);
        make.left.equalTo(self.image.mas_right).offset(10);
    }];
    
    [backView addSubview:self.allLb];
    [_allLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.carLb);
        make.centerY.equalTo(self.image);
    }];
    
    [backView addSubview:self.driveLb];
    [_driveLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.carLb);
        make.bottom.equalTo(self.image);
    }];
    
    [backView addSubview:self.typeLb];
    [_typeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-16);
        make.centerY.equalTo(self.allLb);
    }];
    
    [backView addSubview:self.timeLb];
    [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-16);
        make.bottom.equalTo(self.driveLb);
    }];
    
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [backView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.bottom.right.equalTo(backView);
    }];
}

- (void)loadViewWithModel:(WorkDetailReleaseResponse *)model
{
    [_image sd_setImageWithURL:[NSURL URLWithString:model.outCarHeaderImg]];
    _carLb.text = model.plateNumber;
    _allLb.text = [NSString stringWithFormat:@"累计:%@车",model.count];
    _driveLb.text = [NSString stringWithFormat:@"司机:%@",model.driverName];
    _typeLb.text = model.ztcName;
    _timeLb.text = [NSString stringWithFormat:@"最后出场:%@",model.outReleaserDate];
}

@end
