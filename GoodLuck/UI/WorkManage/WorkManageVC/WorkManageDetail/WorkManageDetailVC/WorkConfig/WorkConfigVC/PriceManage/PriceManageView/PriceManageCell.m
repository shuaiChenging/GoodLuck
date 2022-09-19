//
//  PriceManageCell.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/27.
//

#import "PriceManageCell.h"
@interface PriceManageCell ()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *contentLb;
@property (nonatomic, strong) UITextField *priceTF;
@end
@implementation PriceManageCell

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
    PriceManageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    return cell;
}

- (UILabel *)nameLb
{
    if (!_nameLb)
    {
        _nameLb = [UILabel labelWithText:@"南庄码头"
                                    font:[UIFont systemFontOfSize:font_12]
                               textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                               alignment:NSTextAlignmentCenter];
    }
    return _nameLb;
}

- (UITextField *)priceTF
{
    if (!_priceTF)
    {
        _priceTF = [UITextField new];
        _priceTF.textAlignment = NSTextAlignmentCenter;
        _priceTF.text = @"0";
        _priceTF.keyboardType = UIKeyboardTypeDecimalPad;
        _priceTF.delegate = self;
        _priceTF.font = [UIFont systemFontOfSize:font_12];
        _priceTF.textColor = [UIColor jk_colorWithHexString:COLOR_242424];
    }
    return _priceTF;
}

- (UILabel *)contentLb
{
    if (!_contentLb)
    {
        _contentLb = [UILabel labelWithText:@"10.6"
                                       font:[UIFont systemFontOfSize:font_12]
                                  textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                  alignment:NSTextAlignmentCenter];
    }
    return _contentLb;
}

- (GLImageView *)closeImg
{
    if (!_closeImg)
    {
        _closeImg = [[GLImageView alloc] initWithImage:[UIImage imageNamed:@"manage_detail_close"]];
        _closeImg.userInteractionEnabled = YES;
    }
    return _closeImg;
}

- (void)customerUI
{
    UIView *backView = [UIView new];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.top.bottom.equalTo(self.contentView);
    }];
    
    UIView *leftView = [UIView new];
    [backView addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(backView);
        make.width.equalTo((kScreenWidth - 32)/3);
    }];
    
    [leftView addSubview:self.nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(leftView);
    }];
    
    UIView *middleView = [UIView new];
    [backView addSubview:middleView];
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftView.mas_right);
        make.top.bottom.equalTo(backView);
        make.width.equalTo((kScreenWidth - 32)/3);
    }];
    [middleView addSubview:self.contentLb];
    [_contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(middleView);
    }];
    
    UIView *rightView = [UIView new];
    [backView addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(middleView.mas_right);
        make.top.bottom.equalTo(backView);
        make.width.equalTo((kScreenWidth - 32)/3);
    }];
    
    [rightView addSubview:self.priceTF];
    [_priceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(rightView);
        make.top.bottom.equalTo(rightView);
        make.width.equalTo(50);
    }];
    
    [rightView addSubview:self.closeImg];
    [_closeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(rightView).offset(-8);
        make.centerY.equalTo(rightView);
        make.width.height.equalTo(20);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [backView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.bottom.right.equalTo(backView);
    }];
}

- (void)loadViewWithModel:(WorkDetailPriceResponse *)model change:(SeletedChange)change
{
    self.change = change;
    self.nameLb.text = [Tools isEmpty:model.tlxName] ? model.ztcName : model.tlxName;
    self.contentLb.text = model.bodySize;
    self.priceTF.text = model.price;
}

#pragma mark -- UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.change(textField.text);
}

@end
