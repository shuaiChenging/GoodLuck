//
//  ProvinceCompent.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/11.
//

#import "ProvinceCompent.h"
@interface ProvinceCompent ()
@property (nonatomic, strong) UILabel *finishedLb;
@property (nonatomic, strong) UILabel *closeLb;
@end
@implementation ProvinceCompent

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
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

- (RACSubject *)buttonSubject
{
    if (!_buttonSubject)
    {
        _buttonSubject = [RACSubject new];
    }
    return _buttonSubject;
}

- (UILabel *)finishedLb
{
    if (!_finishedLb)
    {
        _finishedLb = [UILabel labelWithText:@"完成"
                                        font:[UIFont systemFontOfSize:font_15]
                                   textColor:[UIColor whiteColor]
                                   alignment:NSTextAlignmentCenter];
        _finishedLb.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
        _finishedLb.userInteractionEnabled = YES;
    }
    return _finishedLb;
}

- (UILabel *)closeLb
{
    if (!_closeLb)
    {
        _closeLb = [UILabel labelWithText:@"X"
                                     font:[UIFont systemFontOfSize:font_15]
                                textColor:[UIColor whiteColor]
                                alignment:NSTextAlignmentCenter];
        _closeLb.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
        _closeLb.userInteractionEnabled = YES;
    }
    return _closeLb;
}

- (void)customerUI
{
    WeakSelf(self)
    NSArray *array = @[@"粤",@"京",@"冀",@"沪",@"津",@"晋",@"蒙",@"辽",@"吉",@"黑",
                       @"苏",@"浙",@"皖",@"闽",@"赣",@"鲁",@"豫",@"鄂",@"湘",@"桂",
                       @"琼",@"渝",@"川",@"贵",@"云",@"藏",@"峡",@"甘",@"青",@"宁",
                       @"新",@"临"];
    UILabel *lastLb;
    for (int i = 0; i < array.count; i++)
    {
        UILabel *label = [UILabel labelWithText:array[i]
                                           font:[UIFont systemFontOfSize:font_14]
                                      textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                      alignment:NSTextAlignmentCenter];
        label.backgroundColor = [UIColor whiteColor];
        label.userInteractionEnabled = YES;
        [label jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [weakself.subject sendNext:array[i]];
        }];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i % 10 == 0)
            {
                make.left.equalTo(self).offset(10);
            }
            else
            {
                make.left.equalTo(lastLb.mas_right).offset(4);
            }
            
            if (i == 0)
            {
                make.top.equalTo(self).offset(10);
            }
            else if (i % 10 == 0)
            {
                make.top.equalTo(lastLb.mas_bottom).offset(10);
            }
            else
            {
                make.top.equalTo(lastLb);
            }
            
            make.width.height.equalTo((kScreenWidth - 20 - 9 * 4)/10);
            if (i == array.count - 1)
            {
                make.bottom.equalTo(self).offset(-40);
            }
        }];
        lastLb = label;
    }
    
    [self addSubview:self.finishedLb];
    [_finishedLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself.buttonSubject sendNext:@"1"];
        weakself.hidden = YES;
    }];
    [_finishedLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-40);
        make.right.equalTo(self).offset(-10);
        make.width.equalTo(60);
        make.height.equalTo(30);
    }];
    
    [self addSubview:self.closeLb];
    [_closeLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself.buttonSubject sendNext:@"2"];
    }];
    [_closeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(40);
        make.height.equalTo(30);
        make.right.equalTo(self.finishedLb.mas_left).offset(-10);
        make.centerY.equalTo(self.finishedLb);
    }];
}

@end
