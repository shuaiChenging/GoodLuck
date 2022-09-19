//
//  AccountAndSafeCell.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/4.
//

#import "AccountAndSafeCell.h"
@interface AccountAndSafeCell ()
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *rightLb;
@end
@implementation AccountAndSafeCell

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
    AccountAndSafeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    return cell;
}

- (UILabel *)titleLb
{
    if (!_titleLb)
    {
        _titleLb = [UILabel labelWithText:@"账号与安全"
                                     font:[UIFont systemFontOfSize:font_14]
                                textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                alignment:NSTextAlignmentLeft];
    }
    return _titleLb;
}

- (UILabel *)rightLb
{
    if (!_rightLb)
    {
        _rightLb = [UILabel labelWithText:@"账号与安全"
                                     font:[UIFont systemFontOfSize:font_14]
                                textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                alignment:NSTextAlignmentLeft];
    }
    return _rightLb;
}

- (void)customerUI
{
    [self.contentView addSubview:self.titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.centerY.equalTo(self.contentView);
    }];
    
    UIImageView *arrowImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_right_arrow"]];
    [self.contentView addSubview:arrowImg];
    [arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.rightLb];
    [_rightLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(arrowImg.mas_left).offset(-10);
        make.centerY.equalTo(self.contentView);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.bottom.equalTo(self.contentView);
    }];
}

- (void)loadViewWithName:(NSString *)nameStr content:(NSString *)contentStr
{
    self.titleLb.text = nameStr;
    self.rightLb.text = contentStr;
    self.rightLb.hidden = [Tools isEmpty:contentStr];
}

@end
