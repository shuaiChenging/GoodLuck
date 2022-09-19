//
//  TableSeletedCell.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/8/29.
//

#import "TableSeletedCell.h"

@implementation TableSeletedCell

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

- (UILabel *)label
{
    if (!_label)
    {
        _label = [UILabel labelWithText:@""
                                   font:[UIFont systemFontOfSize:font_14]
                              textColor:[UIColor blackColor]
                              alignment:NSTextAlignmentCenter];
    }
    return _label;
}

+ (instancetype)cellWithCollectionView:(UITableView *)tableView
{
    TableSeletedCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    return cell;
}

- (void)customerUI
{
    [self.contentView addSubview:self.label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
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
