//
//  AddSoilCompent.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/13.
//

#import "AddSoilCompent.h"
@implementation AddSoilCompent

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
    }
    return self;
}

- (RACSubject *)closeSubject
{
    if (!_closeSubject)
    {
        _closeSubject = [RACSubject new];
    }
    return _closeSubject;
}

- (RACSubject *)subject
{
    if (!_subject)
    {
        _subject = [RACSubject new];
    }
    return _subject;
}

- (void)loadViewWithArray:(NSArray<CarSizeModel *> *)array name:(NSString *)name
{
    UILabel *nameLb = [UILabel labelWithText:name
                                        font:[UIFont systemFontOfSize:font_16]
                                   textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                   alignment:NSTextAlignmentLeft];
    [self addSubview:nameLb];
    [nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.top.equalTo(self).offset(20);
    }];
    
    GLImageView *closeImg = [[GLImageView alloc] initWithImage:[UIImage imageNamed:@"home_arrow_close"]];
    closeImg.userInteractionEnabled = YES;
    WeakSelf(self)
    [closeImg jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself.closeSubject sendNext:@"1"];
        [weakself removeFromSuperview];
    }];
    [self addSubview:closeImg];
    [closeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(14);
        make.top.equalTo(16);
        make.right.equalTo(-16);
    }];
    
    GLTextField *textField = [GLTextField new];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    UILabel *lastLb;
    for (int i = 0; i < array.count; i++)
    {
        UILabel *label = [UILabel labelWithText:(i == array.count - 1) ? @"其他":array[i].name
                                           font:[UIFont systemFontOfSize:font_14]
                                      textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                      alignment:NSTextAlignmentCenter];
        label.userInteractionEnabled = YES;
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 5;
        label.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        [label jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            if (i == array.count - 1)
            {
                [textField becomeFirstResponder];
            }
            else
            {
                [weakself.subject sendNext:array[i].name];
                [weakself removeFromSuperview];
            }
        }];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i % 3 == 0)
            {
                make.left.equalTo(self).offset(16);
            }
            else
            {
                make.left.equalTo(lastLb.mas_right).offset(20);
            }
            
            if (i == 0)
            {
                make.top.equalTo(nameLb.mas_bottom).offset(20);
            }
            else if (i % 3 == 0)
            {
                make.top.equalTo(lastLb.mas_bottom).offset(10);
            }
            else
            {
                make.top.equalTo(lastLb);
            }
            
            make.width.equalTo((kScreenWidth - 40 - 32 - 40)/3);
            make.height.equalTo(40);
        }];
        lastLb = label;
    }
    
    UILabel *sureLb = [UILabel labelWithText:@"确定"
                                        font:[UIFont systemFontOfSize:font_14]
                                   textColor:[UIColor whiteColor]
                                   alignment:NSTextAlignmentCenter];
    sureLb.layer.masksToBounds = YES;
    sureLb.userInteractionEnabled = YES;
    sureLb.layer.cornerRadius = 5;
    sureLb.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
    [self addSubview:sureLb];
    [sureLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-16);
        make.top.equalTo(lastLb.mas_bottom).offset(20);
        make.width.equalTo(60);
        make.height.equalTo(40);
        make.bottom.equalTo(self).offset(-40);
    }];
    
    textField.font = [UIFont systemFontOfSize:font_14];
    [textField placeHolderString:@"输入其他车斗方"];
    [self addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.top.equalTo(lastLb.mas_bottom).offset(20);
        make.height.equalTo(40);
        make.right.equalTo(sureLb.mas_left).offset(-60);
    }];
    
    [sureLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        if ([Tools isEmpty:textField.text])
        {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"输入其他车斗方"];
            return;
        }
        [weakself.subject sendNext:textField.text];
        [weakself removeFromSuperview];
    }];
}

@end
