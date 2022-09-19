//
//  OrderDeleteCellNormal.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/19.
//

#import "OrderDeleteCellNormal.h"

@interface OrderDeleteCellNormal ()
@property (nonatomic, strong) UILabel *carName;
@property (nonatomic, strong) UILabel *outManage;
@property (nonatomic, strong) UILabel *classLb;
@property (nonatomic, strong) UILabel *dateLb;
@property (nonatomic, strong) UILabel *enterLb;
@property (nonatomic, strong) UILabel *outLb;
@property (nonatomic, strong) UILabel *carTeamLb;
@end
@implementation OrderDeleteCellNormal

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
    OrderDeleteCellNormal *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
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

- (UILabel *)carTeamLb
{
    if (!_carTeamLb)
    {
        _carTeamLb = [UILabel labelWithText:@"车队："
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
        _classLb = [UILabel labelWithText:@"工单状态：白班"
                                     font:[UIFont systemFontOfSize:13]
                                textColor:[UIColor blackColor]
                                alignment:NSTextAlignmentLeft];
    }
    return _classLb;
}

- (UILabel *)deleteLb
{
    if (!_deleteLb)
    {
        _deleteLb = [UILabel labelWithText:@"删除"
                                    font:[UIFont systemFontOfSize:13]
                               textColor:[UIColor whiteColor]
                               alignment:NSTextAlignmentCenter];
        _deleteLb.backgroundColor = [UIColor redColor];
        _deleteLb.layer.masksToBounds = YES;
        _deleteLb.layer.cornerRadius = 5;
        _deleteLb.userInteractionEnabled = YES;
    }
    return _deleteLb;
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
        make.left.equalTo(self.carTeamLb);
        make.top.equalTo(self.carTeamLb.mas_bottom).offset(6);
    }];
    
    [backView addSubview:self.classLb];
    [_classLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.outManage);
        make.top.equalTo(self.outManage.mas_bottom).offset(6);
    }];
    
    [backView addSubview:self.deleteLb];
    [_deleteLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-16);
        make.width.equalTo(60);
        make.height.equalTo(26);
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
        make.centerY.equalTo(self.classLb);
        make.right.equalTo(backView).offset(-16);
    }];
}

- (void)loadViewWithModel:(WorkOrderDetailResponse *)model
{
    self.carName.text = model.plateNumber;
    self.carTeamLb.text = [NSString stringWithFormat:@"车队:%@",model.fleetName];
    self.outManage.text = [NSString stringWithFormat:@"放行管理员:%@(%@)",model.outReleaser,[model.workType isEqualToString:@"NIGHT_WORK"] ? @"晚班" : @"白班"];
    self.classLb.text = [NSString stringWithFormat:@"工单状态:%@",[model.status isEqualToString:@"NOT_OUT"] ? @"未出场":@"已出场"];
    
    self.outLb.text = [NSString stringWithFormat:@"出场:%@",model.outReleaserTime];
    self.dateLb.text = [NSString stringWithFormat:@"日期:%@",[model.created substringToIndex:10]];
}


@end
