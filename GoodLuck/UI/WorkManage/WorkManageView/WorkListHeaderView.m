//
//  WorkListHeaderView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/4.
//

#import "WorkListHeaderView.h"
#import "WorkInfoView.h"
#import "WorkListSearchView.h"
#import "LoginInfoManage.h"
@interface WorkListHeaderView ()
@property (nonatomic, strong) WorkInfoView *travelView; /// 旅行工单
@property (nonatomic, strong) WorkInfoView *muckView; /// 渣土场工地
@property (nonatomic, strong) WorkInfoView *fallView; /// 自倒工单
@property (nonatomic, strong) WorkInfoView *errorView; /// 异常工单

@property (nonatomic, strong) UILabel *myDataLb;

@end
@implementation WorkListHeaderView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
        [self customerUI];
    }
    return self;
}

- (UILabel *)myDataLb
{
    if (!_myDataLb)
    {
        _myDataLb = [UILabel labelWithText:@"我的数据"
                                      font:[UIFont systemFontOfSize:18]
                                 textColor:[UIColor whiteColor]
                                 alignment:NSTextAlignmentLeft];
    }
    return _myDataLb;
}

- (WorkAddView *)workAddView
{
    if (!_workAddView)
    {
        _workAddView = [WorkAddView new];
        
    }
    return _workAddView;
}

- (WorkInfoView *)travelView
{
    if (!_travelView)
    {
        _travelView = [WorkInfoView new];
        
        [_travelView listHeadStyle];
    }
    return _travelView;
}

- (WorkInfoView *)muckView
{
    if (!_muckView)
    {
        _muckView = [WorkInfoView new];
        
        [_muckView listHeadStyle];
    }
    return _muckView;
}

- (WorkInfoView *)fallView
{
    if (!_fallView)
    {
        _fallView = [WorkInfoView new];
        
        [_fallView listHeadStyle];
    }
    return _fallView;
}

- (WorkInfoView *)errorView
{
    if (!_errorView)
    {
        _errorView = [WorkInfoView new];
        
        [_errorView listHeadStyle];
    }
    return _errorView;
}

- (void)customerUI
{
    UIView *headerView = [UIView new];
    headerView.backgroundColor = [UIColor blueColor];
    [self addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(150);
    }];
    
    [headerView addSubview:self.myDataLb];
    [_myDataLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(headerView).offset(16);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(0.5);
        make.top.equalTo(self.myDataLb.mas_bottom).offset(16);
    }];
    
    [headerView addSubview:self.travelView];
    [_travelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView);
        make.width.equalTo(headerView).multipliedBy(1.0/4);
        make.top.equalTo(lineView.mas_bottom).offset(6);
        make.height.equalTo(76);
    }];
    
    [headerView addSubview:self.muckView];
    [_muckView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.travelView.mas_right);
        make.width.equalTo(headerView).multipliedBy(1.0/4);
        make.top.equalTo(self.travelView);
        make.height.equalTo(76);
    }];
    
    [headerView addSubview:self.fallView];
    [_fallView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.muckView.mas_right);
        make.width.equalTo(headerView).multipliedBy(1.0/4);
        make.top.equalTo(self.travelView);
        make.height.equalTo(76);
    }];
    
    [headerView addSubview:self.errorView];
    [_errorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.fallView.mas_right);
        make.width.equalTo(headerView).multipliedBy(1.0/4);
        make.top.equalTo(self.travelView);
        make.height.equalTo(76);
    }];
    
    UILabel *workListLb = [UILabel labelWithText:@"工地项目列表"
                                            font:[UIFont boldSystemFontOfSize:18]
                                       textColor:[UIColor blackColor]
                                       alignment:NSTextAlignmentLeft];
    [self addSubview:workListLb];
    [workListLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.top.equalTo(headerView.mas_bottom).offset(26);
    }];
    
    [self addSubview:self.workAddView];
    [_workAddView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-16);
        make.centerY.equalTo(workListLb);
    }];
    
}

- (void)loadViewWithModel:(WorkListResponse *)model
{
    if ([LoginInfoManage shareInstance].isBoss)
    {
        self.myDataLb.text = @"数据概览";
        
        _travelView.itemLb.text = @"开工项目(个)";
        _travelView.numberLb.text = model.openProjectCount;
        
        _muckView.itemLb.text = @"已完成(车)";
        _muckView.numberLb.text = model.finishCount;
        
        _fallView.itemLb.text = @"渣土场(车)";
        _fallView.numberLb.text = model.ztcCount;
        
        _errorView.itemLb.text = @"自倒(车)";
        _errorView.numberLb.text = model.zdCount;
        
        _workAddView.nameLb.text = @" + 添加工地";
    }
    else
    {
        self.myDataLb.text = @"我的数据";
        
        _travelView.itemLb.text = @"旅行工单";
        _travelView.numberLb.text = model.lxgdCount;
        
        _muckView.itemLb.text = @"渣土场工单";
        _muckView.numberLb.text = model.ztcgdCount;
        
        _fallView.itemLb.text = @"自倒工单";
        _fallView.numberLb.text = model.zdCount;
        
        _errorView.itemLb.text = @"异常工单";
        _errorView.numberLb.text = model.exceptionCount;
        
        _workAddView.nameLb.text = @" + 申请新工地";
    }
}

@end
