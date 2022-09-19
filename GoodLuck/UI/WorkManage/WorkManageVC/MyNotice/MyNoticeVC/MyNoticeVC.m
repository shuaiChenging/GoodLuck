//
//  MyNoticeVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/8/29.
//

#import "MyNoticeVC.h"
#import "NoticeRoleView.h"
#import "NoticeWorkOrderView.h"
#import "SeletedItemCompent.h"
@interface MyNoticeVC ()<UIScrollViewDelegate>
@property (nonatomic, strong) NoticeRoleView *noticeRoleView;
@property (nonatomic, strong) NoticeWorkOrderView *noticeWorkOrderView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) SeletedItemCompent *seletedItemCompent;
@end

@implementation MyNoticeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的通知";
    [self customerUI];
}

- (NoticeRoleView *)noticeRoleView
{
    if (!_noticeRoleView)
    {
        _noticeRoleView = [NoticeRoleView new];
    }
    return _noticeRoleView;
}

- (SeletedItemCompent *)seletedItemCompent
{
    if (!_seletedItemCompent)
    {
        _seletedItemCompent = [[SeletedItemCompent alloc] initWithArray:@[@"角色审批",@"工单审批"]];
        _seletedItemCompent.backgroundColor = [UIColor whiteColor];
        WeakSelf(self)
        [_seletedItemCompent.subject subscribeNext:^(id  _Nullable x) {
            [weakself.scrollView setContentOffset:CGPointMake([x intValue] * kScreenWidth, 0) animated:YES];
        }];
    }
    return _seletedItemCompent;
}

- (NoticeWorkOrderView *)noticeWorkOrderView
{
    if (!_noticeWorkOrderView)
    {
        _noticeWorkOrderView = [NoticeWorkOrderView new];
    }
    return _noticeWorkOrderView;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [UIScrollView new];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(2 * kScreenWidth, 0);
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (void)customerUI
{
    [self.view addSubview:self.seletedItemCompent];
    [_seletedItemCompent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(44);
    }];
    [self.view addSubview:self.scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.seletedItemCompent.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [_scrollView addSubview:self.noticeRoleView];
    [_noticeRoleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView);
        make.top.equalTo(self.seletedItemCompent.mas_bottom);
        make.bottom.equalTo(self.view);
        make.width.equalTo(kScreenWidth);
    }];
    
    [_scrollView addSubview:self.noticeWorkOrderView];
    [_noticeWorkOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.noticeRoleView.mas_right);
        make.top.equalTo(self.seletedItemCompent.mas_bottom);
        make.bottom.equalTo(self.view);
        make.width.equalTo(kScreenWidth);
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int number = scrollView.contentOffset.x / kScreenWidth;
    [self.seletedItemCompent seletedHandle:number];

}
@end
