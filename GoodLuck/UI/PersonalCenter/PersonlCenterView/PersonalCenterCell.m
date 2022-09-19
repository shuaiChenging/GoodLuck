//
//  PersonalCenterCell.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/4.
//

#import "PersonalCenterCell.h"
@interface PersonalCenterCell ()

@end
@implementation PersonalCenterCell

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
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.bottom.equalTo(self.contentView);
    }];
}

+ (instancetype)cellWithCollectionView:(UITableView *)tableView
{
    PersonalCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    return cell;
}

@end
