//
//  EnterErrorWorkPlaceView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/21.
//

#import "EnterErrorWorkPlaceView.h"
@interface EnterErrorWorkPlaceView ()
@property (nonatomic, strong) UILabel *workPlaceLb;
@property (nonatomic, strong) UILabel *distancePlaceLb;
@end
@implementation EnterErrorWorkPlaceView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
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

- (UILabel *)workPlaceLb
{
    if (!_workPlaceLb)
    {
        _workPlaceLb = [UILabel labelWithText:@""
                                         font:[UIFont systemFontOfSize:font_15]
                                    textColor:[UIColor jk_colorWithHexString:COLOR_BLUE]
                                    alignment:NSTextAlignmentLeft];
    }
    return _workPlaceLb;
}

- (UILabel *)distancePlaceLb
{
    if (!_distancePlaceLb)
    {
        _distancePlaceLb = [UILabel labelWithText:@""
                                             font:[UIFont systemFontOfSize:font_15]
                                        textColor:[UIColor jk_colorWithHexString:COLOR_BLUE]
                                        alignment:NSTextAlignmentLeft];
    }
    return _distancePlaceLb;
}

- (void)customerUI
{
    UILabel *titleLb = [UILabel labelWithText:@"提示"
                                         font:[UIFont boldSystemFontOfSize:font_18]
                                    textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                    alignment:NSTextAlignmentCenter];
    [self addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(12);
        make.centerX.equalTo(self);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLb.mas_bottom).offset(12);
        make.height.equalTo(0.5);
        make.right.left.equalTo(self);
    }];
    
    UILabel *errorDescirbeLb = [UILabel labelWithText:@"是否进错工地？"
                                                 font:[UIFont boldSystemFontOfSize:maxFont]
                                            textColor:[UIColor jk_colorWithHexString:COLOR_C34448]
                                            alignment:NSTextAlignmentLeft];
    [self addSubview:errorDescirbeLb];
    [errorDescirbeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.top.equalTo(lineView.mas_bottom).offset(20);
    }];
    
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.top.equalTo(errorDescirbeLb.mas_bottom).offset(20);
        make.height.equalTo(96);
    }];
    
    UILabel *workPlaceDesLb = [UILabel labelWithText:@"您选择的工地为："
                                                font:[UIFont systemFontOfSize:font_15]
                                           textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                           alignment:NSTextAlignmentLeft];
    [contentView addSubview:workPlaceDesLb];
    [workPlaceDesLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(16);
        make.top.equalTo(contentView).offset(20);
    }];
    
    [contentView addSubview:self.workPlaceLb];
    [_workPlaceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(workPlaceDesLb.mas_right);
        make.centerY.equalTo(workPlaceDesLb);
    }];
    
    UILabel *distancePlaceDesLb = [UILabel labelWithText:@"您当前距离该工地为"
                                                    font:[UIFont systemFontOfSize:font_15]
                                               textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                               alignment:NSTextAlignmentLeft];
    [contentView addSubview:distancePlaceDesLb];
    [distancePlaceDesLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(16);
        make.top.equalTo(workPlaceDesLb.mas_bottom).offset(16);
    }];
    
    [contentView addSubview:self.distancePlaceLb];
    [_distancePlaceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(distancePlaceDesLb.mas_right);
        make.centerY.equalTo(distancePlaceDesLb);
    }];
    
    UILabel *alertLb = [UILabel labelWithText:@"*请务必确认您所选择的工地是否正确，以免造成工单信息录入错误"
                                         font:[UIFont systemFontOfSize:font_14]
                                    textColor:[UIColor jk_colorWithHexString:COLOR_909091]
                                    alignment:NSTextAlignmentLeft];
    alertLb.numberOfLines = 0;
    [self addSubview:alertLb];
    [alertLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.top.equalTo(contentView.mas_bottom).offset(20);
    }];
    
    UIView *topLine = [UIView new];
    topLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [self addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(0.5);
        make.top.equalTo(alertLb.mas_bottom).offset(20);
    }];
    
    UILabel *goOnLb = [UILabel labelWithText:@"仍然继续"
                                        font:[UIFont systemFontOfSize:font_16]
                                   textColor:[UIColor jk_colorWithHexString:COLOR_BLUE]
                                   alignment:NSTextAlignmentCenter];
    goOnLb.userInteractionEnabled = YES;
    WeakSelf(self)
    [goOnLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself.subject sendNext:@"1"];
        [weakself removeFromSuperview];
    }];
    [self addSubview:goOnLb];
    [goOnLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(44);
        make.top.equalTo(topLine.mas_bottom);
        make.right.equalTo(self.centerX);
        make.left.bottom.equalTo(self);
    }];
    
    UILabel *exitLb = [UILabel labelWithText:@"退出"
                                        font:[UIFont systemFontOfSize:font_16]
                                   textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                   alignment:NSTextAlignmentCenter];
    exitLb.userInteractionEnabled = YES;
    [exitLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself.subject sendNext:@"0"];
        [weakself removeFromSuperview];
    }];
    [self addSubview:exitLb];
    [exitLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX);
        make.top.bottom.equalTo(goOnLb);
        make.right.equalTo(self);
    }];
}

- (void)setPlaceWithName:(NSString *)name distance:(NSString *)distance
{
    self.workPlaceLb.text = name;
    self.distancePlaceLb.text = distance;
}

@end
