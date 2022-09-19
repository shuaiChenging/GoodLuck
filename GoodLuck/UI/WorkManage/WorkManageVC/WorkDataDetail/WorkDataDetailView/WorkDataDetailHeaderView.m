//
//  WorkDataDetailHeaderView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/4.
//

#import "WorkDataDetailHeaderView.h"
#import "WorkInfoView.h"
#import "SeletedItemCompent.h"
@interface WorkDataDetailHeaderView ()
@property (nonatomic, strong) WorkInfoView *travelView; /// 开工数
@property (nonatomic, strong) WorkInfoView *muckView; /// 完成工单数
@property (nonatomic, strong) WorkInfoView *fallView; /// 运土车辆数
@property (nonatomic, strong) WorkInfoView *errorView; /// 总土方量
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSMutableArray *wokInfoViews;
@property (nonatomic, strong) UIView *seletedView;
@end
@implementation WorkDataDetailHeaderView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.array = @[@{@"number":@"0",@"name":@"完工工单"},
                       @{@"number":@"0",@"name":@"自倒工单"},
                       @{@"number":@"0",@"name":@"渣土场工单"},
                       @{@"number":@"0",@"name":@"运土车辆"},
                       @{@"number":@"0",@"name":@"总土方数"}];
        self.wokInfoViews = [NSMutableArray arrayWithCapacity:0];
        [self customerUI];
    }
    return self;
}

- (RACSubject *)subject
{
    if (!_subject)
    {
        _subject = [RACSubject new];
    }
    return _subject;
}

- (UILabel *)myDataLb
{
    if (!_myDataLb)
    {
        _myDataLb = [UILabel labelWithText:[NSString stringWithFormat:@"%@(24小时)",[Tools dateToString:[NSDate date] withDateFormat:@"yyyy-MM-dd"]]
                                      font:[UIFont systemFontOfSize:font_14]
                                 textColor:[UIColor whiteColor]
                                 alignment:NSTextAlignmentLeft];
        _myDataLb.userInteractionEnabled = YES;
    }
    return _myDataLb;
}

- (WorkInfoView *)travelView
{
    if (!_travelView)
    {
        _travelView = [WorkInfoView new];
        _travelView.itemLb.text = @"开工数";
        [_travelView listHeadStyle];
    }
    return _travelView;
}

- (UIView *)seletedView
{
    if (!_seletedView)
    {
        _seletedView = [UIView new];
    }
    return _seletedView;
}

- (WorkInfoView *)muckView
{
    if (!_muckView)
    {
        _muckView = [WorkInfoView new];
        _muckView.itemLb.text = @"完成工单数";
        [_muckView listHeadStyle];
    }
    return _muckView;
}

- (WorkInfoView *)fallView
{
    if (!_fallView)
    {
        _fallView = [WorkInfoView new];
        _fallView.itemLb.text = @"运土车辆数";
        [_fallView listHeadStyle];
    }
    return _fallView;
}

- (WorkInfoView *)errorView
{
    if (!_errorView)
    {
        _errorView = [WorkInfoView new];
        _errorView.itemLb.text = @"总土方量";
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
        make.top.equalTo(headerView).offset(16);
        make.centerX.equalTo(headerView);
    }];
    
    UIImageView *arrowImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_detail_arrow"]];
    [headerView addSubview:arrowImg];
    [arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.myDataLb.mas_right).offset(6);
        make.centerY.equalTo(self.myDataLb);
        make.width.equalTo(9);
        make.height.equalTo(16/27.0 * 9);
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
    
    [self addSubview:self.seletedView];
    [_seletedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(headerView.mas_bottom);
        make.height.equalTo(46);
    }];
    
    UIView *numberBack = [UIView new];
    numberBack.backgroundColor = [UIColor whiteColor];
    [self addSubview:numberBack];
    [numberBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.top.equalTo(self.seletedView.mas_bottom).offset(16);
        make.height.equalTo(80);
    }];
    
    WorkInfoView *lastView;
    for (int i = 0; i < self.array.count; i++)
    {
        WorkInfoView *infoView = [WorkInfoView new];
        infoView.numberLb.text = self.array[i][@"number"];
        infoView.itemLb.text = self.array[i][@"name"];
        [numberBack addSubview:infoView];
        [self.wokInfoViews addObject:infoView];
        [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0)
            {
                make.left.equalTo(numberBack);
            }
            else
            {
                make.left.equalTo(lastView.mas_right);
            }
            make.top.equalTo(numberBack);
            make.bottom.equalTo(numberBack);
            if (i == self.array.count - 1)
            {
                make.right.equalTo(numberBack);
            }
            make.width.equalTo((kScreenWidth - 32)/self.array.count);
            
        }];
        
        lastView = infoView;
    }
}

- (void)loadViewWithInnerModel:(InnerMobileResponse *)model
{
    WorkInfoView *finishView = self.wokInfoViews[0];
    finishView.numberLb.text = model.finishCount;
    
    WorkInfoView *zdView = self.wokInfoViews[1];
    zdView.numberLb.text = model.zdCount;
    
    WorkInfoView *ztcView = self.wokInfoViews[2];
    ztcView.numberLb.text = model.ztcCount;
    
    WorkInfoView *ytView = self.wokInfoViews[3];
    ytView.numberLb.text = model.ytCount;
    
    WorkInfoView *sumView = self.wokInfoViews[4];
    sumView.numberLb.text = [model.sumBodySize isEqualToString:@"0"] ? @"0" : [NSString stringWithFormat:@"%0.2f",[model.sumBodySize floatValue]];
}

- (void)loadViewWithModel:(StatisticsResponse *)model isFirstLoad:(BOOL)isFirstLoad
{
    _travelView.numberLb.text = model.openCount;
    _muckView.numberLb.text = model.finishCount;
    _fallView.numberLb.text = model.ytCount;
    _errorView.numberLb.text = [model.sumBodySize isEqualToString:@"0"] ? @"0" : [NSString stringWithFormat:@"%0.2f",[model.sumBodySize floatValue]];
    
    if (isFirstLoad)
    {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        for (InnerMobileResponse *response in model.innerMobileProjectStatistics)
        {
            [array addObject:response.projectName];
        }
        SeletedItemCompent *itemCompent = [[SeletedItemCompent alloc] initDetailScrollWithArray:array];
        WeakSelf(self)
        [itemCompent.subject subscribeNext:^(id  _Nullable x) {
            [weakself.subject sendNext:x];
        }];
        [self.seletedView addSubview:itemCompent];
        [itemCompent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.seletedView);
        }];
    }
}

@end
