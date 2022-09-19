//
//  WorkConfigSwitchCell.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/9.
//

#import "WorkConfigSwitchCell.h"
#import "LoginInfoManage.h"
@interface WorkConfigSwitchCell ()
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *describeLb;
@property (nonatomic, strong) UISwitch *customerSwitch;
@property (nonatomic, strong) WorkConfigDetailModel *detailModel;
@end
@implementation WorkConfigSwitchCell

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
    WorkConfigSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    return cell;
}

- (UISwitch *)customerSwitch
{
    if (!_customerSwitch)
    {
        _customerSwitch = [UISwitch new];
        [_customerSwitch addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _customerSwitch;
}

- (UILabel *)nameLb
{
    if (!_nameLb)
    {
        _nameLb = [UILabel labelWithText:@"账号与安全"
                                    font:[UIFont systemFontOfSize:15]
                               textColor:[UIColor blackColor]
                               alignment:NSTextAlignmentLeft];
    }
    return _nameLb;
}

- (UILabel *)describeLb
{
    if (!_describeLb)
    {
        _describeLb = [UILabel labelWithText:@"账号与安全"
                                        font:[UIFont systemFontOfSize:font_13]
                                   textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                   alignment:NSTextAlignmentLeft];
    }
    return _describeLb;
}

- (void)switchChange:(UISwitch *)sw
{
    NSString *key = @"isRememberLastConfig";
    if ([self.detailModel.name isEqualToString:@"车牌识别辅助提醒"])
    {
        key = @"isWarnByIdentify";
    }
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:configedit argument:@{@"key":key,@"value":sw.isOn ? @"true" : @"false",@"projectId":self.projectId}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            if ([self.detailModel.name isEqualToString:@"车牌识别辅助提醒"])
            {
                [LoginInfoManage shareInstance].workConfigResponse.isWarnByIdentify = sw.isOn;
            }
            else
            {
                [LoginInfoManage shareInstance].workConfigResponse.isRememberLastConfig = sw.isOn;
            }
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

- (void)customerUI
{
    [self.contentView addSubview:self.nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.top.equalTo(self.contentView).offset(16);
    }];
    
    [self.contentView addSubview:self.describeLb];
    [_describeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLb);
        make.top.equalTo(self.nameLb.mas_bottom).offset(10);
    }];
    
    [self.contentView addSubview:self.customerSwitch];
    [_customerSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-16);
        make.centerY.equalTo(self.nameLb);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(0.5);
    }];
}

- (void)loadViewWithModel:(WorkConfigDetailModel *)model projectId:(NSString *)projectId
{
    BOOL status = [LoginInfoManage shareInstance].workConfigResponse.isRememberLastConfig;
    if ([model.name isEqualToString:@"车牌识别辅助提醒"])
    {
        status = [LoginInfoManage shareInstance].workConfigResponse.isWarnByIdentify;
    }
    self.projectId = projectId;
    self.customerSwitch.on = status;
    self.detailModel = model;
    self.nameLb.text = model.name;
    self.describeLb.text = model.describe;
}

@end
