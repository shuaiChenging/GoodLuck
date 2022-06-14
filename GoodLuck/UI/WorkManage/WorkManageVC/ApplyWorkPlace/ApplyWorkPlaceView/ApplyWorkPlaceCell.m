//
//  ApplyWorkPlaceCell.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/14.
//

#import "ApplyWorkPlaceCell.h"
@interface ApplyWorkPlaceCell ()
@property (nonatomic, strong) UILabel *contentLb;
@end
@implementation ApplyWorkPlaceCell

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

- (UILabel *)contentLb
{
    if (!_contentLb)
    {
        _contentLb = [UILabel labelWithText:@"111"
                                       font:[UIFont systemFontOfSize:14]
                                  textColor:[UIColor blackColor]
                                  alignment:NSTextAlignmentLeft];
    }
    return _contentLb;
}

+ (instancetype)cellWithCollectionView:(UITableView *)tableView
{
    ApplyWorkPlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    return cell;
}

- (void)customerUI
{
    [self.contentView addSubview:self.contentLb];
    [_contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.centerY.equalTo(self.contentView);
    }];
    
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.bottom.equalTo(self.contentView);
    }];
}

- (void)loadViewWithModel:(BossListResponse *)model
{
    self.contentLb.text = model.name;
    self.contentLb.textColor = model.isSeleted ? [UIColor redColor] : [UIColor blackColor];
}

@end
