//
//  WorkOrderApproveCell.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/15.
//

#import "WorkOrderApproveCell.h"
@interface WorkOrderApproveCell ()
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *applyTimeLb;
@property (nonatomic, strong) UILabel *projectLb;
@property (nonatomic, strong) UILabel *deleteResonLb;
@property (nonatomic, strong) UILabel *detailLb;
@property (nonatomic, strong) UIButton *refuseBt;
@property (nonatomic, strong) UIButton *agreeBt;
@end
@implementation WorkOrderApproveCell

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
    WorkOrderApproveCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    return cell;
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
                                 textColor:[UIColor blueColor]
                                 alignment:NSTextAlignmentLeft];
    }
    return _detailLb;
}

- (UIButton *)refuseBt
{
    if (!_refuseBt)
    {
        _refuseBt = [UIButton buttonWithType:UIButtonTypeCustom];
        _refuseBt.backgroundColor = [UIColor redColor];
        _refuseBt.layer.masksToBounds = YES;
        _refuseBt.layer.cornerRadius = 15;
    }
    return _refuseBt;
}

- (UIButton *)agreeBt
{
    if (!_agreeBt)
    {
        _agreeBt = [UIButton buttonWithType:UIButtonTypeCustom];
        _agreeBt.backgroundColor = [UIColor blueColor];
        _agreeBt.layer.masksToBounds = YES;
        _agreeBt.layer.cornerRadius = 15;
    }
    return _agreeBt;
}

- (void)customerUI
{
    UIView *backView = [UIView new];
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
    }];
    
    UIImageView *phoneImg = [UIImageView new];
    phoneImg.backgroundColor = [UIColor grayColor];
    [backView addSubview:phoneImg];
    [phoneImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(20);
        make.right.equalTo(backView).offset(-16);
        make.centerY.equalTo(self.nameLb);
    }];
    
    UIView *firstLine = [UIView new];
    firstLine.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
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
    secondLine.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [backView addSubview:secondLine];
    [secondLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailLb.mas_bottom).offset(16);
        make.left.right.equalTo(backView);
        make.height.equalTo(0.5);
    }];
    
    [backView addSubview:self.agreeBt];
    [_agreeBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(70);
        make.height.equalTo(30);
        make.bottom.equalTo(backView).offset(-10);
        make.right.equalTo(backView).offset(-16);
    }];
    
    [backView addSubview:self.refuseBt];
    [_refuseBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(70);
        make.height.equalTo(30);
        make.bottom.equalTo(backView).offset(-10);
        make.right.equalTo(self.agreeBt.mas_left).offset(-40);
    }];
}

@end
