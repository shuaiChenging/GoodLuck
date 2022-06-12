//
//  WorkStatisticsView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/5.
//

#import "WorkStatisticsView.h"
#import "WorkManageItemView.h"
#import "SeletedItemCompent.h"
@implementation WorkStatisticsView

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

- (void)customerUI
{
    WorkManageItemView *workManggeItemView = [WorkManageItemView new];
    [self addSubview:workManggeItemView];
    [workManggeItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
    }];
    
    SeletedItemCompent *itemCompent = [[SeletedItemCompent alloc] initScrollWithArray:@[@"车辆",@"土类型",@"卡牌",@"渣土场",@"自倒",@"车队",@"挖机"]];
    [self addSubview:itemCompent];
    [itemCompent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(workManggeItemView.mas_bottom);
    }];
}

@end
