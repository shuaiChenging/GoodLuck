//
//  WorkOrderApproveCell.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/15.
//

#import "WorkOrderApproveCell.h"
#import "LoginInfoManage.h"
@interface WorkOrderApproveCell ()
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *applyTimeLb;
@property (nonatomic, strong) UILabel *projectLb;
@property (nonatomic, strong) UILabel *deleteResonLb;
@property (nonatomic, strong) UIButton *refuseBt;
@property (nonatomic, strong) UIButton *agreeBt;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) ApplyDeleteResponse *applyDeleteResponse;
@end
@implementation WorkOrderApproveCell

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
    WorkOrderApproveCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    return cell;
}

- (RACSubject *)subject
{
    if (!_subject)
    {
        _subject = [RACSubject new];
    }
    return _subject;
}

- (UILabel *)nameLb
{
    if (!_nameLb)
    {
        _nameLb = [UILabel labelWithText:@"Andy申请成为泥头车老板"
                                    font:[UIFont systemFontOfSize:15]
                               textColor:[UIColor blackColor]
                               alignment:NSTextAlignmentLeft];
    }
    return _nameLb;
}

- (UILabel *)projectLb
{
    if (!_projectLb)
    {
        _projectLb = [UILabel labelWithText:@"申请项目：嘻嘻龙湖天街"
                                       font:[UIFont systemFontOfSize:14]
                                  textColor:[UIColor blackColor]
                                  alignment:NSTextAlignmentLeft];
    }
    return _projectLb;
}

- (UILabel *)applyTimeLb
{
    if (!_applyTimeLb)
    {
        _applyTimeLb = [UILabel labelWithText:@"申请时间："
                                         font:[UIFont systemFontOfSize:14]
                                    textColor:[UIColor blackColor]
                                    alignment:NSTextAlignmentLeft];
    }
    return _applyTimeLb;
}

- (UILabel *)deleteResonLb
{
    if (!_deleteResonLb)
    {
        _deleteResonLb = [UILabel labelWithText:@"申请项目：嘻嘻龙湖天街"
                                           font:[UIFont systemFontOfSize:14]
                                      textColor:[UIColor blackColor]
                                      alignment:NSTextAlignmentLeft];
    }
    return _deleteResonLb;
}

- (UILabel *)detailLb
{
    if (!_detailLb)
    {
        _detailLb = [UILabel labelWithText:@"查看工单详情 >"
                                      font:[UIFont systemFontOfSize:13]
                                 textColor:[UIColor jk_colorWithHexString:COLOR_BLUE]
                                 alignment:NSTextAlignmentLeft];
        _detailLb.userInteractionEnabled = YES;
    }
    return _detailLb;
}

- (UIButton *)refuseBt
{
    if (!_refuseBt)
    {
        _refuseBt = [UIButton buttonWithType:UIButtonTypeCustom];
        _refuseBt.backgroundColor = [UIColor whiteColor];
        _refuseBt.layer.borderColor = [UIColor jk_colorWithHexString:COLOR_D2D3E0].CGColor;
        [_refuseBt setTitleColor:[UIColor jk_colorWithHexString:COLOR_D2D3E0] forState:UIControlStateNormal];
        _refuseBt.layer.borderWidth = 1;
        _refuseBt.layer.masksToBounds = YES;
        _refuseBt.layer.cornerRadius = 15;
        [_refuseBt.titleLabel setFont:[UIFont systemFontOfSize:font_14]];
        [_refuseBt setTitle:@"拒绝" forState:UIControlStateNormal];
    }
    return _refuseBt;
}

- (UIButton *)agreeBt
{
    if (!_agreeBt)
    {
        _agreeBt = [UIButton buttonWithType:UIButtonTypeCustom];
        _agreeBt.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
        _agreeBt.layer.masksToBounds = YES;
        _agreeBt.layer.cornerRadius = 15;
        [_agreeBt setTitle:@"同意" forState:UIControlStateNormal];
        [_agreeBt.titleLabel setFont:[UIFont systemFontOfSize:font_14]];
        [_agreeBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _agreeBt;
}

- (void)customerUI
{
    UIView *backView = [UIView new];
    self.backView = backView;
    backView.layer.masksToBounds = YES;
    backView.layer.cornerRadius = 5;
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-20);
    }];
    
    [backView addSubview:self.nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(16);
        make.top.equalTo(backView).offset(10);
        make.right.equalTo(backView).offset(-32 - 30);
    }];
    
    UIImageView *phoneImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"manage_detail_phone_default"]];
    phoneImg.userInteractionEnabled = YES;
    WeakSelf(self)
    [phoneImg jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",weakself.applyDeleteResponse.phone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
    }];
    [backView addSubview:phoneImg];
    [phoneImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(24);
        make.right.equalTo(backView).offset(-16);
        make.centerY.equalTo(self.nameLb);
    }];
    
    UIView *firstLine = [UIView new];
    firstLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [backView addSubview:firstLine];
    [firstLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(backView);
        make.top.equalTo(self.nameLb.mas_bottom).offset(10);
        make.height.equalTo(0.5);
    }];
    
    [backView addSubview:self.applyTimeLb];
    [_applyTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLb);
        make.top.equalTo(firstLine.mas_bottom).offset(16);
    }];
    
    [backView addSubview:self.projectLb];
    [_projectLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLb);
        make.top.equalTo(self.applyTimeLb.mas_bottom).offset(16);
    }];
    
    [backView addSubview:self.deleteResonLb];
    [_deleteResonLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLb);
        make.top.equalTo(self.projectLb.mas_bottom).offset(16);
    }];
    
    [backView addSubview:self.detailLb];
    [_detailLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLb);
        make.top.equalTo(self.deleteResonLb.mas_bottom).offset(16);
    }];
    
    UIView *secondLine = [UIView new];
    secondLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [backView addSubview:secondLine];
    [secondLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailLb.mas_bottom).offset(16);
        make.left.right.equalTo(backView);
        make.height.equalTo(0.5);
    }];
    
    [backView addSubview:self.agreeBt];
    [[self.agreeBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself.subject sendNext:@"1"];
    }];
    [_agreeBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(80);
        make.height.equalTo(30);
        make.bottom.equalTo(backView).offset(-10);
        make.right.equalTo(backView).offset(-16);
    }];
    
    [backView addSubview:self.refuseBt];
    [[self.refuseBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if ([weakself.applyDeleteResponse.status isEqualToString:@"NORMAL"] && [LoginInfoManage shareInstance].isBoss)
        {
            [weakself.subject sendNext:@"2"];
        }
    }];
    [_refuseBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(80);
        make.height.equalTo(30);
        make.bottom.equalTo(backView).offset(-10);
        make.right.equalTo(backView).offset(-116);
    }];
}

- (void)loadViewWithModel:(ApplyDeleteResponse *)model
{
    self.applyDeleteResponse = model;
    self.nameLb.text = [NSString stringWithFormat:@"管理员%@申请删除工单%@",model.applicant,model.orderNo];
    self.applyTimeLb.text = [NSString stringWithFormat:@"申请时间:%@",model.created];
    self.projectLb.text = [NSString stringWithFormat:@"项目名称:%@",model.projectName];
    self.deleteResonLb.text = [NSString stringWithFormat:@"删除原因:%@",model.reason];
    if ([model.status isEqualToString:@"DELETE"]) /// 已同意
    {
        self.agreeBt.hidden = YES;
        [_refuseBt setTitle:@"已同意" forState:UIControlStateNormal];
        [_refuseBt mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.backView).offset(-16);
        }];
    }
    else if ([model.status isEqualToString:@"REJECT"]) /// 已拒绝
    {
        self.agreeBt.hidden = YES;
        [_refuseBt setTitle:@"已拒绝" forState:UIControlStateNormal];
        [_refuseBt mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.backView).offset(-16);
        }];
    }
    else
    {
        self.agreeBt.hidden = ![LoginInfoManage shareInstance].isBoss;
        [_refuseBt setTitle:[LoginInfoManage shareInstance].isBoss ? @"拒绝" : @"审核中" forState:UIControlStateNormal];
        CGFloat right = [LoginInfoManage shareInstance].isBoss ? -116 : -16;
        [_refuseBt mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.backView).offset(right);
        }];
    }
}

@end
