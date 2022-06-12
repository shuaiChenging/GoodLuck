//
//  SeletedItemCompent.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/5.
//

#import "SeletedItemCompent.h"
@interface SeletedItemCompent ()
@property (nonatomic, strong) NSMutableArray *labels;
@property (nonatomic, strong) UIView *lineView;
@end
@implementation SeletedItemCompent

- (instancetype)initWithArray:(NSArray *)array
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (instancetype)initScrollWithArray:(NSArray *)array
{
    self = [super init];
    if (self)
    {
        self.labels = [NSMutableArray arrayWithCapacity:0];
        [self customerScrollWithArray:array];
    }
    return self;
}

- (UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor blueColor];
    }
    return _lineView;
}

- (void)customerScrollWithArray:(NSArray *)array
{
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.userInteractionEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [scrollView addSubview:self.lineView];
    
    UILabel *lastLb;
    for (int i = 0; i < array.count; i++)
    {
        UILabel *label = [UILabel labelWithText:array[i]
                                           font:[UIFont systemFontOfSize:14]
                                      textColor:nil
                                      alignment:NSTextAlignmentCenter];
        label.userInteractionEnabled = YES;
        __weak typeof(self) weakSelf = self;
        [label jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [weakSelf seletedHandle:i];
        }];
        if (i == 0)
        {
            label.textColor = [UIColor blueColor];
        }
        [scrollView addSubview:label];
        [self.labels addObject:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            if (i == 0)
            {
                make.left.equalTo(scrollView);
            }
            else
            {
                make.left.equalTo(lastLb.mas_right);
            }
            make.width.equalTo(64);
            if (i == array.count - 1)
            {
                make.right.equalTo(scrollView);
            }
        }];
        lastLb = label;
    }
    
    UILabel *firstLb = self.labels[0];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.height.equalTo(2);
        make.width.equalTo(40);
        make.centerX.equalTo(firstLb);
    }];
}

- (void)seletedHandle:(int)index
{
    for (int i = 0; i < self.labels.count; i++)
    {
        UILabel *label = self.labels[i];
        label.textColor = [UIColor blackColor];
        if (index == i)
        {
            label.textColor = [UIColor blueColor];
            [_lineView remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self);
                make.height.equalTo(2);
                make.width.equalTo(40);
                make.centerX.equalTo(label);
            }];
        }
    }
}

- (void)customerUI:(NSArray *)array
{
//    UILabel *lastLb;
//    for (int i = 0; i < array.count; i++)
//    {
//        UILabel *label = [UILabel labelWithText:array[i]
//                                           font:[UIFont systemFontOfSize:12]
//                                      textColor:nil
//                                      alignment:NSTextAlignmentCenter];
//        [self addSubview:label];
//        [label mas_makeConstraints:^(MASConstraintMaker *make) {
//            if (i == 0)
//            {
//                make.left.equalTo(self);
//
//            }
//        }];
//    }
}

@end
