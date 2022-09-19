//
//  OrderDeleteCellDeleted.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/19.
//

#import "OrderDeleteCellDeleted.h"
@interface OrderDeleteCellDeleted ()
@property (nonatomic, strong) UILabel *carName;
@property (nonatomic, strong) UILabel *outManage;
@property (nonatomic, strong) UILabel *classLb;
@property (nonatomic, strong) UILabel *carTeamLb;
@property (nonatomic, strong) UILabel *typeLb;
@property (nonatomic, strong) UILabel *enterLb;
@property (nonatomic, strong) UILabel *outLb;
@property (nonatomic, strong) UILabel *dateLb;
@property (nonatomic, strong) UILabel *deleteResonLb;
@end
@implementation OrderDeleteCellDeleted

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
    OrderDeleteCellDeleted *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    return cell;
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

- (UILabel *)deleteResonLb
{
    if (!_deleteResonLb)
    {
        _deleteResonLb = [UILabel labelWithText:@"删除原因：Andy"
                                           font:[UIFont systemFontOfSize:13]
                                      textColor:[UIColor blackColor]
                                      alignment:NSTextAlignmentLeft];
    }
    return _deleteResonLb;
}

- (UILabel *)carTeamLb
{
    if (!_carTeamLb)
    {
        _carTeamLb = [UILabel labelWithText:@"车队：Andy"
                                       font:[UIFont systemFontOfSize:13]
                                  textColor:[UIColor blackColor]
                                  alignment:NSTextAlignmentLeft];
    }
    return _carTeamLb;
}

- (UILabel *)classLb
{
    if (!_classLb)
    {
        _classLb = [UILabel labelWithText:@"删除人：白班"
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
        _typeLb = [UILabel labelWithText:@"已删除"
                                    font:[UIFont systemFontOfSize:13]
                               textColor:[UIColor redColor]
                               alignment:NSTextAlignmentRight];
    }
    return _typeLb;
}

- (UILabel *)enterLb
{
    if (!_enterLb)
    {
        _enterLb = [UILabel labelWithText:@""
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
    
    [backView addSubview:self.carTeamLb];
    [_carTeamLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.carName);
        make.top.equalTo(self.carName.mas_bottom).offset(6);
    }];
    
    [backView addSubview:self.outManage];
    [_outManage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.carName);
        make.top.equalTo(self.carTeamLb.mas_bottom).offset(6);
    }];
    
    [backView addSubview:self.classLb];
    [_classLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.outManage);
        make.top.equalTo(self.outManage.mas_bottom).offset(6);
    }];
    
    [backView addSubview:self.deleteResonLb];
    [_deleteResonLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.outManage);
        make.right.equalTo(backView).offset(-16);
        make.top.equalTo(self.classLb.mas_bottom).offset(6);
    }];
    
    [backView addSubview:self.typeLb];
    [_typeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-16);
        make.centerY.equalTo(self.carName);
    }];
    
    [backView addSubview:self.enterLb];
    [_enterLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-16);
        make.centerY.equalTo(self.carTeamLb);
    }];
    
    [backView addSubview:self.outLb];
    [_outLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-16);
        make.centerY.equalTo(self.outManage);
    }];
    
    [backView addSubview:self.dateLb];
    [_dateLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-16);
        make.centerY.equalTo(self.classLb);
    }];
    
}

- (void)loadViewWithModel:(WorkOrderDetailResponse *)model
{
    self.carName.text = model.plateNumber;
    self.carTeamLb.text = [NSString stringWithFormat:@"车队:%@",model.fleetName];
    self.outManage.text = [NSString stringWithFormat:@"放行管理员:%@",model.outReleaser];
    self.classLb.text = [NSString stringWithFormat:@"删除人:%@",model.updater];
    self.deleteResonLb.text = [NSString stringWithFormat:@"删除原因:%@",model.modifyReason];
    
    self.outLb.text = [NSString stringWithFormat:@"出场:%@",model.outReleaserTime];
    self.dateLb.text = [NSString stringWithFormat:@"日期:%@",[model.created substringToIndex:10]];
}
@end
