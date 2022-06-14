//
//  WorkOrderStatisticsView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/5.
//

#import "WorkOrderStatisticsView.h"
#import "TimeShowView.h"
#import "WorkManageItemView.h"
#import "WorkInfoView.h"
@interface WorkOrderStatisticsView ()
@property (nonatomic, strong) TimeShowView *timeShowView;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSMutableArray *wokInfoViews;
@end
@implementation WorkOrderStatisticsView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.wokInfoViews = [NSMutableArray arrayWithCapacity:0];
        self.array = @[@{@"number":@"1",@"name":@"全部工单数"},
                       @{@"number":@"1",@"name":@"渣土场工单"},
                       @{@"number":@"1",@"name":@"自倒工单"},
                       @{@"number":@"1",@"name":@"异常工单"},
                       @{@"number":@"1",@"name":@"删除工单"},
                       @{@"number":@"1",@"name":@"历史总工单"}];
        [self customerUI];
    }
    return self;
}

- (TimeShowView *)timeShowView
{
    if (!_timeShowView)
    {
        _timeShowView = [TimeShowView new];
    }
    return _timeShowView;
}

- (void)customerUI
{
    [self addSubview:self.timeShowView];
    [_timeShowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self);
        make.top.equalTo(self).offset(20);
        make.height.equalTo(36);
    }];
    
    WorkManageItemView *workManggeItemView = [WorkManageItemView new];
    [self addSubview:workManggeItemView];
    [workManggeItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeShowView.bottom);
        make.left.right.equalTo(self);
    }];
    
    UIScrollView *scrollView = [UIScrollView new];
    [self addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(workManggeItemView.mas_bottom);
    }];
    WorkInfoView *lastView;
    for (int i = 0; i < self.array.count; i++)
    {
        WorkInfoView *infoView = [WorkInfoView new];
        infoView.numberLb.text = self.array[i][@"number"];
        infoView.itemLb.text = self.array[i][@"name"];
        [scrollView addSubview:infoView];
        [self.wokInfoViews addObject:infoView];
        [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0)
            {
                make.left.equalTo(scrollView);
            }
            else
            {
                make.left.equalTo(lastView.mas_right);
            }
            make.top.equalTo(workManggeItemView.mas_bottom);
            make.bottom.equalTo(self);
            if (i == self.array.count - 1)
            {
                make.right.equalTo(scrollView);
            }
            make.width.equalTo(80);
            
        }];
        
        lastView = infoView;
    }
    
    
}

- (void)loadOrderWithModel:(WorkOrderResponse *)response
{
    for (int i = 0; i < self.wokInfoViews.count; i++)
    {
        WorkInfoView *infoView = self.wokInfoViews[i];
        switch (i) {
            case 0:
            {
                infoView.numberLb.text = response.allCount;
                break;
            }
            case 1:
            {
                infoView.numberLb.text = response.ztcCount;
                break;
            }
            case 2:
            {
                infoView.numberLb.text = response.zdCount;
                break;
            }
            case 3:
            {
                infoView.numberLb.text = response.exceptionCount;
                break;
            }
            case 4:
            {
                infoView.numberLb.text = response.delCount;
                break;
            }
            case 5:
            {
                infoView.numberLb.text = response.historyCount;
                break;
            }
            default:
                break;
        }
    }
}

@end
