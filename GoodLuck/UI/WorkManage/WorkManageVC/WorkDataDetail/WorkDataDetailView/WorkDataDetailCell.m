//
//  WorkDataDetailCell.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/4.
//

#import "WorkDataDetailCell.h"
@interface WorkDataDetailCell ()
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *numberLb;
@end
@implementation WorkDataDetailCell

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

- (UILabel *)nameLb
{
    if (!_nameLb)
    {
        _nameLb = [UILabel labelWithText:@"场"
                                    font:[UIFont systemFontOfSize:font_12]
                               textColor:[UIColor jk_colorWithHexString:@"#989898"]
                               alignment:NSTextAlignmentLeft];
    }
    return _nameLb;
}

- (UILabel *)numberLb
{
    if (!_numberLb)
    {
        _numberLb = [UILabel labelWithText:@"1车"
                                      font:[UIFont systemFontOfSize:font_12]
                                 textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                 alignment:NSTextAlignmentRight];
    }
    return _numberLb;
}

+ (instancetype)cellWithCollectionView:(UITableView *)tableView
{
    WorkDataDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    return cell;
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
    
    [backView addSubview:self.nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(16);
        make.centerY.equalTo(backView);
    }];
    
    [backView addSubview:self.numberLb];
    [_numberLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-16);
        make.centerY.equalTo(backView);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [backView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(backView);
        make.height.equalTo(0.5);
    }];
}

- (void)loadViewWithModel:(WorkerItem *)model
{
    self.nameLb.text = [Tools isEmpty:model.tlxName] ? model.ztcName : model.tlxName;
    self.numberLb.text = [NSString stringWithFormat:@"%@车",model.count];
}

@end
