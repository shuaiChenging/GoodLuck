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
@property (nonatomic, strong) UIScrollView *scrollView;
@end
@implementation SeletedItemCompent

- (instancetype)initWithArray:(NSArray *)array
{
    self = [super init];
    if (self)
    {
        self.labels = [NSMutableArray arrayWithCapacity:0];
        [self customerUI:array];
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

- (instancetype)initDetailScrollWithArray:(NSArray *)array
{
    self = [super init];
    if (self)
    {
        self.labels = [NSMutableArray arrayWithCapacity:0];
        [self customerDetailScrollWithArray:array];
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
        _lineView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
    }
    return _lineView;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [UIScrollView new];
        _scrollView.userInteractionEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (void)customerDetailScrollWithArray:(NSArray *)array
{
    [self addSubview:self.scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_scrollView addSubview:self.lineView];
    
    UILabel *lastLb;
    for (int i = 0; i < array.count; i++)
    {
        UILabel *label = [UILabel labelWithText:array[i]
                                           font:[UIFont systemFontOfSize:14]
                                      textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                      alignment:NSTextAlignmentCenter];
        CGSize size = [label sizeThatFits:CGSizeMake(MAXFLOAT, 30)];
        label.userInteractionEnabled = YES;
        __weak typeof(self) weakSelf = self;
        [label jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [weakSelf seletedHandle:i];
        }];
        if (i == 0)
        {
            label.textColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
        }
        [_scrollView addSubview:label];
        [self.labels addObject:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            if (i == 0)
            {
                make.left.equalTo(self.scrollView);
            }
            else
            {
                make.left.equalTo(lastLb.mas_right);
            }
            make.width.equalTo(size.width + 10);
            if (i == array.count - 1)
            {
                make.right.equalTo(self.scrollView);
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

- (void)customerScrollWithArray:(NSArray *)array
{
    [self addSubview:self.scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_scrollView addSubview:self.lineView];
    
    UILabel *lastLb;
    for (int i = 0; i < array.count; i++)
    {
        UILabel *label = [UILabel labelWithText:array[i]
                                           font:[UIFont systemFontOfSize:14]
                                      textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                      alignment:NSTextAlignmentCenter];
        label.userInteractionEnabled = YES;
        __weak typeof(self) weakSelf = self;
        [label jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [weakSelf seletedHandle:i];
        }];
        if (i == 0)
        {
            label.textColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
        }
        [_scrollView addSubview:label];
        [self.labels addObject:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            if (i == 0)
            {
                make.left.equalTo(self.scrollView);
            }
            else
            {
                make.left.equalTo(lastLb.mas_right);
            }
            make.width.equalTo(64);
            if (i == array.count - 1)
            {
                make.right.equalTo(self.scrollView);
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
    [self.subject sendNext:[NSNumber numberWithInt:index]];
    for (int i = 0; i < self.labels.count; i++)
    {
        UILabel *label = self.labels[i];
        label.textColor = [UIColor jk_colorWithHexString:COLOR_242424];
        if (index == i)
        {
            label.textColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
            [_lineView remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self);
                make.height.equalTo(2);
                make.width.equalTo(40);
                make.centerX.equalTo(label);
            }];
            [UIView animateWithDuration:0.3 animations:^{
                [self layoutIfNeeded];
            }];
        }
    }
    
    if (_scrollView)
    {
        if ((index + 1) * 64 > kScreenWidth)
        {
            [_scrollView setContentOffset:CGPointMake((index + 1) * 64 - kScreenWidth, 0) animated:YES];
        }
        else
        {
            [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        
    }
}

- (void)customerUI:(NSArray *)array
{
    UILabel *lastLb;
    [self addSubview:self.lineView];
    for (int i = 0; i < array.count; i++)
    {
        UILabel *label = [UILabel labelWithText:array[i]
                                           font:[UIFont systemFontOfSize:font_14]
                                      textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                      alignment:NSTextAlignmentCenter];
        label.userInteractionEnabled = YES;
        __weak typeof(self) weakSelf = self;
        [label jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [weakSelf seletedHandle:i];
        }];
        if (i == 0)
        {
            label.textColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
        }
        [self addSubview:label];
        [self.labels addObject:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            if (i == 0)
            {
                make.left.equalTo(self);
            }
            else
            {
                make.left.equalTo(lastLb.mas_right);
            }
            make.width.equalTo(kScreenWidth/array.count);
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

@end
