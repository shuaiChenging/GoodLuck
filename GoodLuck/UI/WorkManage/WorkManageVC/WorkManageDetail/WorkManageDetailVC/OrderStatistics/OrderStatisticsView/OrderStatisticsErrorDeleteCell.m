//
//  OrderStatisticsErrorDeleteCell.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/9/9.
//

#import "OrderStatisticsErrorDeleteCell.h"
@interface OrderStatisticsErrorDeleteCell ()
@property (nonatomic, strong) UILabel *carName;
@property (nonatomic, strong) UILabel *outManage;
@property (nonatomic, strong) UILabel *classLb;
@property (nonatomic, strong) UILabel *typeLb;
@property (nonatomic, strong) UILabel *enterLb;
@property (nonatomic, strong) UILabel *outLb;
@property (nonatomic, strong) UILabel *dateLb;
@property (nonatomic, strong) UILabel *deletePeopleLb;
@property (nonatomic, strong) UILabel *deleteTimeLb;
@property (nonatomic, strong) UILabel *deleteReasonLb;

@property (nonatomic, strong) UILabel *errorLb;
@end
@implementation OrderStatisticsErrorDeleteCell

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
    OrderStatisticsErrorDeleteCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    return cell;
}

- (UILabel *)errorLb
{
    if (!_errorLb)
    {
        _errorLb = [UILabel labelWithText:@"异常原因："
                                     font:[UIFont systemFontOfSize:13]
                                textColor:[UIColor redColor]
                                alignment:NSTextAlignmentLeft];
    }
    return _errorLb;
}

- (UILabel *)carName
{
    if (!_carName)
    {
        _carName = [UILabel labelWithText:@"浙A8x957"
                                     font:[UIFont boldSystemFontOfSize:font_17]
                                textColor:[UIColor blackColor]
                                alignment:NSTextAlignmentLeft];
    }
    return _carName;
}

- (UILabel *)outManage
{
    if (!_outManage)
    {
        _outManage = [UILabel labelWithText:@"放行管理员：Andy"
                                       font:[UIFont systemFontOfSize:13]
                                  textColor:[UIColor blackColor]
                                  alignment:NSTextAlignmentLeft];
    }
    return _outManage;
}

- (UILabel *)classLb
{
    if (!_classLb)
    {
        _classLb = [UILabel labelWithText:@"班次：白班"
                                     font:[UIFont systemFontOfSize:13]
                                textColor:[UIColor blackColor]
                                alignment:NSTextAlignmentLeft];
    }
    return _classLb;
}

- (UILabel *)typeLb
{
    if (!_typeLb)
    {
        _typeLb = [UILabel labelWithText:@"自倒"
                                    font:[UIFont systemFontOfSize:14]
                               textColor:[UIColor jk_colorWithHexString:COLOR_BLUE]
                               alignment:NSTextAlignmentRight];
    }
    return _typeLb;
}

- (UILabel *)enterLb
{
    if (!_enterLb)
    {
        _enterLb = [UILabel labelWithText:@"进场："
                                     font:[UIFont systemFontOfSize:13]
                                textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                alignment:NSTextAlignmentRight];
    }
    return _enterLb;
}

- (UILabel *)outLb
{
    if (!_outLb)
    {
        _outLb = [UILabel labelWithText:@"出场："
                                   font:[UIFont systemFontOfSize:13]
                              textColor:[UIColor jk_colorWithHexString:@"#989898"]
                              alignment:NSTextAlignmentRight];
    }
    return _outLb;
}

- (UILabel *)dateLb
{
    if (!_dateLb)
    {
        _dateLb = [UILabel labelWithText:@"日期："
                                    font:[UIFont systemFontOfSize:13]
                               textColor:[UIColor jk_colorWithHexString:@"#989898"]
                               alignment:NSTextAlignmentRight];
    }
    return _dateLb;
}

- (UILabel *)deletePeopleLb
{
    if (!_deletePeopleLb)
    {
        _deletePeopleLb = [UILabel labelWithText:@"删除人："
                                            font:[UIFont systemFontOfSize:13]
                                       textColor:[UIColor redColor]
                                       alignment:NSTextAlignmentLeft];
    }
    return _deletePeopleLb;
}

- (UILabel *)deleteTimeLb
{
    if (!_deleteTimeLb)
    {
        _deleteTimeLb = [UILabel labelWithText:@"删除时间："
                                          font:[UIFont systemFontOfSize:13]
                                     textColor:[UIColor redColor]
                                     alignment:NSTextAlignmentLeft];
    }
    return _deleteTimeLb;
}

- (UILabel *)deleteReasonLb
{
    if (!_deleteReasonLb)
    {
        _deleteReasonLb = [UILabel labelWithText:@"删除原因："
                                            font:[UIFont systemFontOfSize:13]
                                       textColor:[UIColor redColor]
                                       alignment:NSTextAlignmentLeft];
    }
    return _deleteReasonLb;
}

- (void)customerUI
{
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-20);
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
    }];
    
    [backView addSubview:self.carName];
    [_carName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(16);
        make.top.equalTo(backView).offset(20);
    }];
    
    [backView addSubview:self.outManage];
    [_outManage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.carName);
        make.top.equalTo(self.carName.mas_bottom).offset(6);
    }];
    
    [backView addSubview:self.classLb];
    [_classLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.outManage);
        make.top.equalTo(self.outManage.mas_bottom).offset(6);
    }];
    
    [backView addSubview:self.typeLb];
    [_typeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-16);
        make.centerY.equalTo(self.carName);
    }];
    
    [backView addSubview:self.enterLb];
    [_enterLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-16);
        make.centerY.equalTo(self.outManage);
    }];
    
    [backView addSubview:self.outLb];
    [_outLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-16);
        make.centerY.equalTo(self.classLb);
    }];
    
    [backView addSubview:self.dateLb];
    [_dateLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.outLb.mas_bottom).offset(6);
        make.right.equalTo(backView).offset(-16);
    }];
    
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [backView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(backView);
        make.height.equalTo(0.5);
        make.top.equalTo(self.dateLb.mas_bottom).offset(6);
    }];
    
    [backView addSubview:self.deletePeopleLb];
    [_deletePeopleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(16);
        make.top.equalTo(bottomLine.mas_bottom).offset(6);
    }];
    
    [backView addSubview:self.deleteTimeLb];
    [_deleteTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(16);
        make.top.equalTo(self.deletePeopleLb.mas_bottom).offset(6);
    }];
    
    [backView addSubview:self.deleteReasonLb];
    [_deleteReasonLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(16);
        make.top.equalTo(self.deleteTimeLb.mas_bottom).offset(6);
    }];
    
    UIView *bottomLineTwo = [UIView new];
    bottomLineTwo.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [backView addSubview:bottomLineTwo];
    [bottomLineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(backView);
        make.height.equalTo(0.5);
        make.top.equalTo(self.deleteReasonLb.mas_bottom).offset(6);
    }];
    
    [backView addSubview:self.errorLb];
    [_errorLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(16);
        make.top.equalTo(bottomLineTwo.mas_bottom).offset(6);
    }];
}

- (void)loadViewWithModel:(WorkOrderDetailResponse *)model
{
    self.carName.text = model.plateNumber;
    self.outManage.text = [NSString stringWithFormat:@"放行管理员:%@",[Tools isEmpty:model.outReleaser] ? @"-" : model.outReleaser];
    self.classLb.text = [NSString stringWithFormat:@"班次:%@",[model.workType isEqualToString:@"NIGHT_WORK"] ? @"晚班" : @"白班"];
    self.typeLb.text = model.ztcName;
    self.enterLb.text = [NSString stringWithFormat:@"进场:%@",[Tools isEmpty:model.inReleaserTime] ? @"-" : model.inReleaserTime];
    self.outLb.text = [NSString stringWithFormat:@"出场:%@",[Tools isEmpty:model.outReleaserTime] ? @"-" : model.outReleaserTime];
    self.dateLb.text = [NSString stringWithFormat:@"日期:%@",[model.created substringToIndex:10]];
    self.deletePeopleLb.text = [NSString stringWithFormat:@"删除人:%@",model.updater];
    self.deleteTimeLb.text = [NSString stringWithFormat:@"删除时间:%@",model.updated];
    self.deleteReasonLb.text = [NSString stringWithFormat:@"删除原因:%@",model.modifyReason];
    self.errorLb.text = [NSString stringWithFormat:@"异常原因:%@",model.exception];
}


@end
