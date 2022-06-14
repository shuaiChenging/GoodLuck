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
        self.contentView.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
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
        _iconImg = [UIImageView new];
        _iconImg.backgroundColor = [UIColor grayColor];
    }
    return _iconImg;
}

- (UILabel *)addressLb
{
    if (!_addressLb)
    {
        _addressLb = [UILabel labelWithText:@"嘻嘻印象城"
                                       font:[UIFont systemFontOfSize:16]
                                  textColor:[UIColor blackColor]
                                  alignment:NSTextAlignmentLeft];
    }
    return _addressLb;
}

- (UILabel *)workTimeLb
{
    if (!_workTimeLb)
    {
        _workTimeLb = [UILabel labelWithText:@"开工时间：未开工"
                                       font:[UIFont systemFontOfSize:12]
                                  textColor:[UIColor blackColor]
                                  alignment:NSTextAlignmentLeft];
    }
    return _workTimeLb;
}

- (WorkInfoView *)finishView
{
    if (!_finishView)
    {
        _finishView = [WorkInfoView new];
    }
    return _finishView;
}

- (WorkInfoView *)enterView
{
    if (!_enterView)
    {
        _enterView = [WorkInfoView new];
        
    }
    return _enterView;
}

- (WorkInfoView *)allView
{
    if (!_allView)
    {
        _allView = [WorkInfoView new];
        
    }
    return _allView;
}

- (WorkInfoView *)workView
{
    if (!_workView)
    {
        _workView = [WorkInfoView new];
    }
    return _workView;
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
        make.height.equalTo(174);
    }];
    
    [backView addSubview:self.iconImg];
    [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(20);
        make.left.top.equalTo(backView).offset(18);
    }];
    
    [backView addSubview:self.addressLb];
    [_addressLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.mas_right).offset(18);
        make.centerY.equalTo(self.iconImg);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [backView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(backView);
        make.top.equalTo(self.iconImg.mas_bottom).offset(18);
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
        make.top.equalTo(self.finishView.mas_bottom).offset(10);
    }];
}

- (void)loadViewWithModel:(ProjectListResponse *)model
{
    self.addressLb.text = model.name;
    if ([LoginInfoManage shareInstance].isBoss)
    {
        _finishView.itemLb.text = @"已完成(车)";
        _finishView.numberLb.text = model.finishCount;
        
        _enterView.itemLb.text = @"渣土场(车)";
        _enterView.numberLb.text = model.ztcCount;
        
        _allView.itemLb.text = @"自倒(车)";
        _allView.numberLb.text = model.zdCount;
        
        _workView.itemLb.text = @"历史总工单(车)";
        _workView.numberLb.text = model.lsgdCount;
        
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
    }
}

@end
