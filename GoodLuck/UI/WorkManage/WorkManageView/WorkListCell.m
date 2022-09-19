//
//  WorkListCell.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/4.
//

#import "WorkListCell.h"
#import "WorkInfoView.h"
#import "LoginInfoManage.h"
@interface WorkListCell ()
@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILabel *addressLb;
@property (nonatomic, strong) UILabel *workTimeLb;
@property (nonatomic, strong) UILabel *manageLb;
@property (nonatomic, strong) WorkInfoView *finishView; /// 今日完成
@property (nonatomic, strong) WorkInfoView *enterView; /// 今日进场
@property (nonatomic, strong) WorkInfoView *allView; /// 累计完成
@property (nonatomic, strong) WorkInfoView *workView; /// 已开工
@end
@implementation WorkListCell

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
    WorkListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    return cell;
}

- (UIImageView *)iconImg
{
    if (!_iconImg)
    {
        _iconImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_location_defalut"]];
    }
    return _iconImg;
}

- (UILabel *)addressLb
{
    if (!_addressLb)
    {
        _addressLb = [UILabel labelWithText:@"嘻嘻印象城"
                                       font:[UIFont systemFontOfSize:font_14]
                                  textColor:[UIColor jk_colorWithHexString:COLOR_3677FE]
                                  alignment:NSTextAlignmentLeft];
    }
    return _addressLb;
}

- (UILabel *)workTimeLb
{
    if (!_workTimeLb)
    {
        _workTimeLb = [UILabel labelWithText:@"开工时间：未开工"
                                       font:[UIFont systemFontOfSize:font_12]
                                  textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                  alignment:NSTextAlignmentLeft];
    }
    return _workTimeLb;
}

- (WorkInfoView *)finishView
{
    if (!_finishView)
    {
        _finishView = [WorkInfoView new];
        _finishView.numberLb.textColor = [UIColor jk_colorWithHexString:COLOR_9B9B9B];
    }
    return _finishView;
}

- (WorkInfoView *)enterView
{
    if (!_enterView)
    {
        _enterView = [WorkInfoView new];
        _enterView.numberLb.textColor = [UIColor jk_colorWithHexString:COLOR_9B9B9B];
        
    }
    return _enterView;
}

- (WorkInfoView *)allView
{
    if (!_allView)
    {
        _allView = [WorkInfoView new];
        _allView.numberLb.textColor = [UIColor jk_colorWithHexString:COLOR_9B9B9B];
        
    }
    return _allView;
}

- (WorkInfoView *)workView
{
    if (!_workView)
    {
        _workView = [WorkInfoView new];
        _workView.numberLb.textColor = [UIColor jk_colorWithHexString:COLOR_9B9B9B];
    }
    return _workView;
}

- (UILabel *)manageLb
{
    if (!_manageLb)
    {
        _manageLb = [UILabel labelWithText:@"管理"
                                      font:[UIFont systemFontOfSize:font_13]
                                 textColor:[UIColor jk_colorWithHexString:COLOR_8D8D90]
                                 alignment:NSTextAlignmentRight];
    }
    return _manageLb;
}

- (void)customerUI
{
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.masksToBounds = YES;
    backView.layer.cornerRadius = 5;
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-14);
    }];
    
    [backView addSubview:self.iconImg];
    [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(18);
        make.left.top.equalTo(backView).offset(16);
    }];
    
    [backView addSubview:self.addressLb];
    [_addressLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.mas_right).offset(8);
        make.centerY.equalTo(self.iconImg);
    }];
    
    UIImageView *rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_right_arrow"]];
    [backView addSubview:rightArrow];
    [rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-16);
        make.width.height.equalTo(16);
        make.centerY.equalTo(self.iconImg);
    }];
    
    [backView addSubview:self.manageLb];
    [_manageLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(rightArrow.mas_left).offset(-4);
        make.centerY.equalTo(self.iconImg);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [backView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(backView);
        make.top.equalTo(self.iconImg.mas_bottom).offset(12);
        make.height.equalTo(0.5);
    }];
    
    [backView addSubview:self.finishView];
    [_finishView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView);
        make.width.equalTo(backView).multipliedBy(1.0/4);
        make.top.equalTo(lineView.mas_bottom);
        make.height.equalTo(76);
    }];
    
    [backView addSubview:self.enterView];
    [_enterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.finishView.mas_right);
        make.width.equalTo(backView).multipliedBy(1.0/4);
        make.top.equalTo(lineView.mas_bottom);
        make.height.equalTo(76);
    }];
    
    [backView addSubview:self.allView];
    [_allView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.enterView.mas_right);
        make.width.equalTo(backView).multipliedBy(1.0/4);
        make.top.equalTo(lineView.mas_bottom);
        make.height.equalTo(76);
    }];
    
    [backView addSubview:self.workView];
    [_workView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.allView.mas_right);
        make.width.equalTo(backView).multipliedBy(1.0/4);
        make.top.equalTo(lineView.mas_bottom);
        make.height.equalTo(76);
    }];
    
    [backView addSubview:self.workTimeLb];
    [_workTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg);
        make.top.equalTo(self.finishView.mas_bottom).offset(2);
    }];
}

- (void)loadViewWithModel:(ProjectListResponse *)model
{
    self.addressLb.text = model.name;
    NSString *openTime = [Tools isEmpty:model.openTime] ? @"未开工" : model.openTime;
    self.workTimeLb.text = [NSString stringWithFormat:@"开工时间：%@",openTime];
    if ([LoginInfoManage shareInstance].isBoss)
    {
        BOOL isOff = [model.status isEqualToString:@"NOT_OPEN"];
        _finishView.itemLb.text = @"已完成(车)";
        _finishView.numberLb.text = model.finishCount;
        
        _enterView.itemLb.text = @"渣土场(车)";
        _enterView.numberLb.text = model.ztcCount;
        
        _allView.itemLb.text = @"自倒(车)";
        _allView.numberLb.text = model.zdCount;
        
        _workView.itemLb.text = @"历史总工单(车)";
        _workView.numberLb.text = model.lsgdCount;
        
        _manageLb.text = @"管理";
        _manageLb.textColor = isOff ? [UIColor jk_colorWithHexString:COLOR_8D8D90] : [UIColor jk_colorWithHexString:COLOR_60C691];
        
        _iconImg.image = [UIImage imageNamed: isOff ? @"home_location_defalut" : @"home_location_hight"];
        
        _addressLb.textColor = isOff ? [UIColor jk_colorWithHexString:COLOR_9B9B9B] : [UIColor jk_colorWithHexString:COLOR_242424];
        
        _finishView.numberLb.textColor = [UIColor jk_colorWithHexString: isOff ? COLOR_9B9B9B : COLOR_BLUE];
        _enterView.numberLb.textColor = [UIColor jk_colorWithHexString:isOff ? COLOR_9B9B9B : COLOR_BLUE];
        _allView.numberLb.textColor = [UIColor jk_colorWithHexString:isOff ? COLOR_9B9B9B : COLOR_BLUE];
        _workView.numberLb.textColor = [UIColor jk_colorWithHexString:isOff ? COLOR_9B9B9B : COLOR_BLUE];
        
    }
    else
    {
        _finishView.itemLb.text = @"今日完成(车)";
        _finishView.numberLb.text = model.finishTodayCount;
        
        _enterView.itemLb.text = @"今日进场(车)";
        _enterView.numberLb.text = model.inCount;
        
        _allView.itemLb.text = @"累计完成(车)";
        _allView.numberLb.text = model.finishCount;
        
        _workView.itemLb.text = @"已开工(小时)";
        _workView.numberLb.text = model.openProjectCount;
        
        BOOL isOff = [model.workType isEqualToString:@"OFF_WORK"];
        
        _manageLb.text = isOff ? @"管理" : @"上班中";
        _manageLb.textColor = isOff ? [UIColor jk_colorWithHexString:COLOR_8D8D90] : [UIColor jk_colorWithHexString:COLOR_60C691];
        
        _iconImg.image = [UIImage imageNamed: isOff ? @"home_location_defalut" : @"home_location_hight"];
        
        _addressLb.textColor = isOff ? [UIColor jk_colorWithHexString:COLOR_9B9B9B] : [UIColor jk_colorWithHexString:COLOR_242424];
        
        _finishView.numberLb.textColor = [UIColor jk_colorWithHexString: isOff ? COLOR_9B9B9B : COLOR_BLUE];
        _enterView.numberLb.textColor = [UIColor jk_colorWithHexString:isOff ? COLOR_9B9B9B : COLOR_BLUE];
        _allView.numberLb.textColor = [UIColor jk_colorWithHexString:isOff ? COLOR_9B9B9B : COLOR_BLUE];
        _workView.numberLb.textColor = [UIColor jk_colorWithHexString:isOff ? COLOR_9B9B9B : COLOR_BLUE];
    }
}

@end
