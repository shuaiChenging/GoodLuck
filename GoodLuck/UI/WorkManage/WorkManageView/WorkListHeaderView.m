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
#import "TodayCompent.h"
#import "DateSeletedCompent.h"
@interface WorkListHeaderView ()
@property (nonatomic, strong) WorkInfoView *travelView; /// 放行工单
@property (nonatomic, strong) WorkInfoView *muckView; /// 渣土场工地
@property (nonatomic, strong) WorkInfoView *fallView; /// 自倒工单
@property (nonatomic, strong) WorkInfoView *errorView; /// 异常工单
@property (nonatomic, assign) DataSeletedType type;
@property (nonatomic, strong) UILabel *myDataLb;

@property (nonatomic, strong) TodayCompent *todayCompent;

@end
@implementation WorkListHeaderView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        self.userInteractionEnabled = YES;
        [self customerUI];
    }
    return self;
}

- (UILabel *)myDataLb
{
    if (!_myDataLb)
    {
        _myDataLb = [UILabel labelWithText:@"我的数据"
                                      font:[UIFont systemFontOfSize:font_14]
                                 textColor:[UIColor whiteColor]
                                 alignment:NSTextAlignmentLeft];
    }
    return _myDataLb;
}

- (TodayCompent *)todayCompent
{
    if (!_todayCompent)
    {
        _todayCompent = [TodayCompent new];
    }
    return _todayCompent;
}

- (void)setDateStr:(NSString *)dateStr
{
    self.todayCompent.todyLb.text = dateStr;
}

- (UILabel *)detailLb
{
    if (!_detailLb)
    {
        _detailLb = [UILabel labelWithText:@"详情"
                                      font:[UIFont boldSystemFontOfSize:font_12]
                                 textColor:[UIColor whiteColor]
                                 alignment:NSTextAlignmentCenter];
        _detailLb.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
        _detailLb.layer.masksToBounds = YES;
        _detailLb.layer.cornerRadius = 12;
        _detailLb.layer.borderColor = [UIColor whiteColor].CGColor;
        _detailLb.layer.borderWidth = 1;
        _detailLb.userInteractionEnabled = YES;
    }
    return _detailLb;
}

- (RACSubject *)subject
{
    if (!_subject)
    {
        _subject = [RACSubject new];
    }
    return _subject;
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
    headerView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
    [self addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(150);
    }];
    
    [headerView addSubview:self.myDataLb];
    [_myDataLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(headerView).offset(16);
    }];
    
    if ([LoginInfoManage shareInstance].isBoss)
    {
        [headerView addSubview:self.detailLb];
        [_detailLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(headerView).offset(-16);
            make.width.equalTo(60);
            make.height.equalTo(24);
            make.centerY.equalTo(self.myDataLb);
        }];
        
        [headerView addSubview:self.todayCompent];
        [_todayCompent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(24);
            make.right.equalTo(self.detailLb.mas_left).offset(-14);
            make.centerY.equalTo(self.myDataLb);
        }];
    }
    else
    {
        [headerView addSubview:self.todayCompent];
        [_todayCompent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(24);
            make.right.equalTo(headerView).offset(-16);
            make.centerY.equalTo(self.myDataLb);
        }];
    }
    WeakSelf(self)
    [_todayCompent jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself addDataList];
    }];

    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor jk_colorWithHexString:@"#5292ff"];
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
                                            font:[UIFont boldSystemFontOfSize:font_16]
                                       textColor:[UIColor jk_colorWithHexString:COLOR_33353D]
                                       alignment:NSTextAlignmentLeft];
    [self addSubview:workListLb];
    [workListLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.top.equalTo(headerView.mas_bottom).offset(20);
    }];
    
    [self addSubview:self.workAddView];
    [_workAddView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-16);
        make.centerY.equalTo(workListLb);
    }];
    
}

- (void)addDataList
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor clearColor];
    [window addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(window);
    }];
    
    DateSeletedCompent *compent = [DateSeletedCompent new];
    [compent loadWithType:self.type];
    WeakSelf(self)
    [compent.subject subscribeNext:^(id  _Nullable x) {
        weakself.type = [x intValue];
        switch (weakself.type)
        {
            case Today:
            {
                weakself.todayCompent.todyLb.text = @"今天";
                break;
            }
            case YesterDay:
            {
                weakself.todayCompent.todyLb.text = @"昨天";
                break;
            }
            case SevenDay:
            {
                weakself.todayCompent.todyLb.text = @"过去七天";
                break;
            }
        }
        [weakself.subject sendNext:weakself.todayCompent.todyLb.text];
        [backView removeFromSuperview];
    }];
    [window addSubview:compent];
    [compent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.todayCompent.mas_bottom).offset(4);
        make.right.equalTo(self.todayCompent.mas_right);
        make.width.equalTo(100);
        make.height.equalTo(120);
    }];
    WeakSelf(backView)
    [backView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakbackView removeFromSuperview];
        [compent removeFromSuperview];
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
        
        _travelView.itemLb.text = @"放行工单";
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
