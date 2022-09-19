//
//  SeletedWorkTypeCompent.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/3.
//

#import "SeletedWorkTypeCompent.h"

@implementation SeletedWorkTypeCompent

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        self.backgroundColor = [UIColor whiteColor];
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

- (void)customerUI
{
    UILabel *describeLb = [UILabel labelWithText:@"请选择上班班次"
                                            font:[UIFont systemFontOfSize:font_14]
                                       textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                       alignment:NSTextAlignmentLeft];
    [self addSubview:describeLb];
    [describeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(26);
        make.top.equalTo(self).offset(26);
    }];
    
    GLImageView *closeImg = [[GLImageView alloc] initWithImage:[UIImage imageNamed:@"home_arrow_close"]];
    closeImg.userInteractionEnabled = YES;
    WeakSelf(self)
    [closeImg jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself.subject sendNext:@"3"];
        [weakself removeFromSuperview];
    }];
    [self addSubview:closeImg];
    [closeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(14);
        make.top.equalTo(16);
        make.right.equalTo(-16);
    }];
    
    UIView *dayView = [UIView new];
    dayView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
    dayView.layer.masksToBounds = YES;
    dayView.layer.cornerRadius = 2;
    [self addSubview:dayView];
    [dayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(26);
        make.right.equalTo(self).offset(-26);
        make.height.equalTo(44);
        make.top.equalTo(describeLb.mas_bottom).offset(50);
    }];
    
    dayView.userInteractionEnabled = YES;
    [dayView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself.subject sendNext:@"1"];
        [weakself removeFromSuperview];
    }];
    
    UILabel *dayLb = [UILabel labelWithText:@"白班"
                                       font:[UIFont systemFontOfSize:font_14]
                                  textColor:[UIColor whiteColor]
                                  alignment:NSTextAlignmentLeft];
    [dayView addSubview:dayLb];
    [dayLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(dayView);
        make.left.equalTo(dayView.mas_centerX).offset(4);
    }];
    
    UIImageView *dayImg = [UIImageView jk_imageViewWithImageNamed:@"home_sun"];
    [dayView addSubview:dayImg];
    [dayImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(20);
        make.right.equalTo(dayView.centerX).offset(-4);
        make.centerY.equalTo(dayView);
    }];
    
    UIView *nightView = [UIView new];
    nightView.layer.masksToBounds = YES;
    nightView.layer.cornerRadius = 2;
    nightView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_DUCK];
    [self addSubview:nightView];
    [nightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(26);
        make.right.equalTo(self).offset(-26);
        make.height.equalTo(44);
        make.top.equalTo(dayView.mas_bottom).offset(40);
    }];
    
    nightView.userInteractionEnabled = YES;
    [nightView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself.subject sendNext:@"2"];
        [weakself removeFromSuperview];
    }];
    
    UILabel *nightLb = [UILabel labelWithText:@"晚班"
                                         font:[UIFont systemFontOfSize:font_14]
                                    textColor:[UIColor whiteColor]
                                    alignment:NSTextAlignmentLeft];
    [nightView addSubview:nightLb];
    [nightLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nightView);
        make.left.equalTo(nightView.mas_centerX).offset(4);
    }];
    
    UIImageView *nightImg = [UIImageView jk_imageViewWithImageNamed:@"home_moon"];
    [nightView addSubview:nightImg];
    [nightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(20);
        make.right.equalTo(nightView.centerX).offset(-4);
        make.centerY.equalTo(nightView);
    }];
}

@end
