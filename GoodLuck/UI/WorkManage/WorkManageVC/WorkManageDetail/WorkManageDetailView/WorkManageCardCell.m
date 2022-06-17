//
//  WorkManageCardCell.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/15.
//

#import "WorkManageCardCell.h"
@interface WorkManageCardCell ()
@property (nonatomic, strong) UILabel *serialLeftLb;
@property (nonatomic, strong) UILabel *numberLeftLb;
@property (nonatomic, strong) UILabel *workNoLeftLb;

@property (nonatomic, strong) UILabel *serialRightLb;
@property (nonatomic, strong) UILabel *numberRightLb;
@property (nonatomic, strong) UILabel *workNoRightLb;
@end
@implementation WorkManageCardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
        [self customerUI];
    }
    
    return self;
}

+ (instancetype)cellWithCollectionView:(UITableView *)tableView
{
    WorkManageCardCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    return cell;
}

- (UILabel *)serialLeftLb
{
    if (!_serialLeftLb)
    {
        _serialLeftLb = [UILabel labelWithText:@"1"
                                          font:[UIFont systemFontOfSize:12]
                                     textColor:[UIColor jk_colorWithHexString:@"#333333"]
                                     alignment:NSTextAlignmentLeft];
    }
    return _serialLeftLb;
}

- (UILabel *)numberLeftLb
{
    if (!_numberLeftLb)
    {
        _numberLeftLb = [UILabel labelWithText:@"浙A23344"
                                          font:[UIFont systemFontOfSize:12]
                                     textColor:[UIColor jk_colorWithHexString:@"#333333"]
                                     alignment:NSTextAlignmentCenter];
    }
    return _numberLeftLb;
}

- (UILabel *)workNoLeftLb
{
    if (!_workNoLeftLb)
    {
        _workNoLeftLb = [UILabel labelWithText:@"1"
                                          font:[UIFont systemFontOfSize:12]
                                     textColor:[UIColor jk_colorWithHexString:@"#333333"]
                                     alignment:NSTextAlignmentRight];
    }
    return _workNoLeftLb;
}

- (UILabel *)serialRightLb
{
    if (!_serialRightLb)
    {
        _serialRightLb = [UILabel labelWithText:@"1"
                                           font:[UIFont systemFontOfSize:12]
                                      textColor:[UIColor jk_colorWithHexString:@"#333333"]
                                      alignment:NSTextAlignmentLeft];
    }
    return _serialRightLb;
}

- (UILabel *)numberRightLb
{
    if (!_numberRightLb)
    {
        _numberRightLb = [UILabel labelWithText:@"浙A23344"
                                           font:[UIFont systemFontOfSize:12]
                                      textColor:[UIColor jk_colorWithHexString:@"#333333"]
                                      alignment:NSTextAlignmentCenter];
    }
    return _numberRightLb;
}

- (UILabel *)workNoRightLb
{
    if (!_workNoRightLb)
    {
        _workNoRightLb = [UILabel labelWithText:@"1"
                                           font:[UIFont systemFontOfSize:12]
                                      textColor:[UIColor jk_colorWithHexString:@"#333333"]
                                      alignment:NSTextAlignmentRight];
    }
    return _workNoRightLb;
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
    
    UIView *leftView = [UIView new];
    [backView addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(backView);
        make.right.equalTo(backView.mas_centerX);
    }];
    
    UIView *rightView = [UIView new];
    [backView addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_centerX);
        make.top.right.bottom.equalTo(backView);
    }];
    
    [leftView addSubview:self.serialLeftLb];
    [_serialLeftLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftView).offset(16);
        make.centerY.equalTo(leftView);
    }];
    
    [leftView addSubview:self.numberLeftLb];
    [_numberLeftLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(leftView);
    }];
    
    [leftView addSubview:self.workNoLeftLb];
    [_workNoLeftLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(leftView).offset(-16);
        make.centerY.equalTo(leftView);
    }];
    
    UIView *middleView = [UIView new];
    middleView.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [backView addSubview:middleView];
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(0.5);
        make.top.bottom.equalTo(backView);
        make.centerX.equalTo(backView);
    }];
    
    [rightView addSubview:self.serialRightLb];
    [_serialRightLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rightView).offset(16);
        make.centerY.equalTo(rightView);
    }];
    
    [leftView addSubview:self.numberRightLb];
    [_numberRightLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(rightView);
    }];
    
    [leftView addSubview:self.workNoRightLb];
    [_workNoRightLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(rightView).offset(-16);
        make.centerY.equalTo(rightView);
    }];
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [backView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(backView);
        make.height.equalTo(0.5);
    }];
    
}

@end
