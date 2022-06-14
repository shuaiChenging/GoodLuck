//
//  WorkManageHeaderView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/9.
//

#import "WorkManageHeaderView.h"
@implementation WorkManageHeaderView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self customerUI];
    }
    return self;
}

- (UILabel *)nameLb
{
    if (!_nameLb)
    {
        _nameLb = [UILabel labelWithText:@"车队名称"
                                   font:[UIFont boldSystemFontOfSize:15]
                              textColor:[UIColor blackColor]
                              alignment:NSTextAlignmentLeft];
    }
    return _nameLb;
}

- (UIButton *)addBt
{
    if (!_addBt)
    {
        _addBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBt setTitle:@"新增" forState:UIControlStateNormal];
        _addBt.titleLabel.font = [UIFont systemFontOfSize:14];
        [_addBt setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
    return _addBt;
}

- (UIButton *)editBt
{
    if (!_editBt)
    {
        _editBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBt setTitle:@"编辑" forState:UIControlStateNormal];
        _editBt.titleLabel.font = [UIFont systemFontOfSize:14];
        [_editBt setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
    return _editBt;
}

- (void)customerUI
{
    UIView *topLine = [UIView new];
    topLine.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [self addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(0.5);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor blueColor];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(4);
        make.height.equalTo(14);
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(16);
    }];
    
    [self addSubview:self.nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView.mas_right).offset(10);
        make.centerY.equalTo(self);
    }];
    
    [self addSubview:self.editBt];
    [_editBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-30);
        make.centerY.equalTo(self);
    }];
    
    [self addSubview:self.addBt];
    [_addBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.editBt.mas_left).offset(-30);
        make.centerY.equalTo(self);
    }];
}

@end
