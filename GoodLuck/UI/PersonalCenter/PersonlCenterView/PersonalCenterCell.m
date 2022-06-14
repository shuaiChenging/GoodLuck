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
                                     font:[UIFont systemFontOfSize:14]
                                textColor:[UIColor blackColor]
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
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
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
