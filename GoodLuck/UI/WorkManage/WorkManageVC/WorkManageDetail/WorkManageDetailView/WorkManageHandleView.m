//
//  WorkManageHandleView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/5.
//

#import "WorkManageHandleView.h"

@implementation WorkManageHandleView
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        [self customerUI];
    }
    return self;
}

- (IconNameView *)infoView
{
    if (!_infoView)
    {
        _infoView = [IconNameView new];
        [_infoView setImageName:@"" name:@"详细信息"];
    }
    return _infoView;
}

- (IconNameView *)memberView
{
    if (!_memberView)
    {
        _memberView = [IconNameView new];
        [_memberView setImageName:@"" name:@"人员管理"];
    }
    return _memberView;
}

- (IconNameView *)roleView
{
    if (!_roleView)
    {
        _roleView = [IconNameView new];
        [_roleView setImageName:@"" name:@"角色审批"];
    }
    return _roleView;
}

- (IconNameView *)workOrderView
{
    if (!_workOrderView)
    {
        _workOrderView = [IconNameView new];
        [_workOrderView setImageName:@"" name:@"工单审批"];
    }
    return _workOrderView;
}

- (void)customerUI
{
    [self addSubview:self.infoView];
    [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self);
        make.width.equalTo(self).multipliedBy(1.0/4);
    }];
    
    [self addSubview:self.memberView];
    [_memberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoView);
        make.left.equalTo(self.infoView.mas_right);
        make.width.equalTo(self).multipliedBy(1.0/4);
    }];
    
    [self addSubview:self.roleView];
    [_roleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoView);
        make.left.equalTo(self.memberView.mas_right);
        make.width.equalTo(self).multipliedBy(1.0/4);
    }];
    
   
    [self addSubview:self.workOrderView];
    [_workOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoView);
        make.left.equalTo(self.roleView.mas_right);
        make.width.equalTo(self).multipliedBy(1.0/4);
    }];
}
@end
