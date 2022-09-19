//
//  ChangeCarNoView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/11.
//

#import "ChangeCarNoView.h"
@interface ChangeCarNoView ()
@property (nonatomic, strong) GLImageView *leftImg;
@property (nonatomic, strong) GLImageView *rightImg;
@property (nonatomic, assign) BOOL isNewCar;
@property (nonatomic, strong) UILabel *newLb;
@property (nonatomic, strong) NSMutableArray<UILabel *> *labels;
@property (nonatomic, assign) int currentRow;
@end
@implementation ChangeCarNoView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        self.labels = [NSMutableArray arrayWithCapacity:0];
        
        GLImageView *closeImg = [[GLImageView alloc] initWithImage:[UIImage imageNamed:@"home_arrow_close"]];
        closeImg.userInteractionEnabled = YES;
        WeakSelf(self)
        [closeImg jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [weakself.cancelSubject sendNext:@"1"];
            [weakself removeFromSuperview];
        }];
        [self addSubview:closeImg];
        [closeImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(14);
            make.top.equalTo(16);
            make.right.equalTo(-16);
        }];
    }
    return self;
}

- (GLImageView *)leftImg
{
    if (!_leftImg)
    {
        _leftImg = [GLImageView new];
        _leftImg.userInteractionEnabled = YES;
    }
    return _leftImg;
}

- (GLImageView *)rightImg
{
    if (!_rightImg)
    {
        _rightImg = [GLImageView new];
        _rightImg.userInteractionEnabled = YES;
    }
    return _rightImg;
}

- (UILabel *)newLb
{
    if (!_newLb)
    {
        _newLb = [UILabel labelWithText:@""
                                   font:[UIFont systemFontOfSize:font_12]
                              textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                              alignment:NSTextAlignmentCenter];
        _newLb.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        _newLb.userInteractionEnabled = YES;
        _newLb.layer.borderWidth = 1;
        _newLb.layer.borderColor = [UIColor jk_colorWithHexString:COLOR_BACK].CGColor;
    }
    return _newLb;
}

- (RACSubject *)buttonSubject
{
    if (!_buttonSubject)
    {
        _buttonSubject = [RACSubject new];
    }
    return _buttonSubject;
}

- (RACSubject *)subject
{
    if (!_subject)
    {
        _subject = [RACSubject new];
    }
    return _subject;
}

- (RACSubject *)cancelSubject
{
    if (!_cancelSubject)
    {
        _cancelSubject = [RACSubject new];
    }
    return _cancelSubject;
}

- (void)loadViewWithCarNo:(NSString *)carNo image:(UIImage *)image
{
    self.isNewCar = carNo.length == 8;
    UILabel *carLb = [UILabel labelWithText:@"车牌确认"
                                       font:[UIFont systemFontOfSize:font_16]
                                  textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                  alignment:NSTextAlignmentCenter];
    [self addSubview:carLb];
    [carLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(20);
    }];
    
    UIImageView *carImg = [[UIImageView alloc] initWithImage:image];
    carImg.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
    [self addSubview:carImg];
    [carImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(carLb.mas_bottom).offset(20);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(80);
    }];
    
    UILabel *carTypeLb = [UILabel labelWithText:@"新能源："
                                           font:[UIFont systemFontOfSize:font_14]
                                      textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                      alignment:NSTextAlignmentLeft];
    [self addSubview:carTypeLb];
    [carTypeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(carImg.mas_bottom).offset(20);
    }];
    
    [self addSubview:self.leftImg];
    WeakSelf(self)
    [_leftImg jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        weakself.isNewCar = YES;
        weakself.newLb.hidden = NO;
        weakself.leftImg.image = [UIImage imageNamed:@"manage_detail_car_seleted"];
        weakself.rightImg.image = [UIImage imageNamed:@"manage_detail_car_default"];
    }];
    _leftImg.image = [UIImage imageNamed:self.isNewCar ? @"manage_detail_car_seleted" : @"manage_detail_car_default"];
    [_leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(24);
        make.left.equalTo(carTypeLb.mas_right).offset(30);
        make.centerY.equalTo(carTypeLb);
    }];
    
    UILabel *yesLb = [UILabel labelWithText:@"是"
                                       font:[UIFont systemFontOfSize:font_14]
                                  textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                  alignment:NSTextAlignmentLeft];
    [self addSubview:yesLb];
    [yesLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImg.mas_right).offset(6);
        make.centerY.equalTo(self.leftImg);
    }];
    
    [self addSubview:self.rightImg];
    [_rightImg jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        weakself.isNewCar = NO;
        weakself.newLb.hidden = YES;
        weakself.newLb.text = @"";
        weakself.leftImg.image = [UIImage imageNamed:@"manage_detail_car_default"];
        weakself.rightImg.image = [UIImage imageNamed:@"manage_detail_car_seleted"];
    }];
    _rightImg.image = [UIImage imageNamed:!self.isNewCar ? @"manage_detail_car_seleted" : @"manage_detail_car_default"];
    [_rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(24);
        make.centerY.equalTo(self.leftImg);
        make.left.equalTo(yesLb.mas_right).offset(20);
    }];
    
    UILabel *noLb = [UILabel labelWithText:@"否"
                                      font:[UIFont systemFontOfSize:font_14]
                                 textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                 alignment:NSTextAlignmentLeft];
    [self addSubview:noLb];
    [noLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rightImg.mas_right).offset(6);
        make.centerY.equalTo(self.rightImg);
    }];
    
    UILabel *lastLb;
    UIView *middleView = [UIView new];
    middleView.layer.masksToBounds = YES;
    middleView.layer.cornerRadius = 5;
    middleView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
    for (int i = 0; i < [carNo length]; i++)
    {
        NSString *subStr = [carNo substringWithRange:NSMakeRange(i, 1)];
        UILabel *label = [UILabel labelWithText:subStr
                                           font:[UIFont systemFontOfSize:font_12]
                                      textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                      alignment:NSTextAlignmentCenter];
        label.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        label.userInteractionEnabled = YES;
        label.layer.borderWidth = 1;
        label.layer.borderColor = [UIColor jk_colorWithHexString:COLOR_BACK].CGColor;
        [label jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [weakself seleteNumberWithIndexrow:i];
        }];
        [self addSubview:label];
        [self.labels addObject:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0)
            {
                make.left.equalTo(self).offset(10);
            }
            else if (i == 2)
            {
                make.left.equalTo(middleView.mas_right).offset(6);
            }
            else
            {
                make.left.equalTo(lastLb.mas_right).offset(4);
            }
            make.top.equalTo(carTypeLb.mas_bottom).offset(16);
            make.width.height.equalTo(32);
        }];
        
        if (i == 1)
        {
            [self addSubview:middleView];
            [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(label.mas_right).offset(6);
                make.width.height.equalTo(10);
                make.centerY.equalTo(label);
            }];
        }
        
        lastLb = label;
    }
    
    if (self.isNewCar)
    {
        self.newLb = lastLb;
    }
    else
    {
        [self addSubview:self.newLb];
        [self.labels addObject:self.newLb];
        _newLb.hidden = YES;
        [_newLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [weakself seleteNumberWithIndexrow:(int)weakself.labels.count - 1];
        }];
        [_newLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lastLb.mas_right).offset(6);
            make.width.height.equalTo(32);
            make.centerY.equalTo(lastLb);
        }];
    }

    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(lastLb.mas_bottom).offset(16);
        make.height.equalTo(0.5);
    }];

    UILabel *reScanLb = [UILabel labelWithText:@"重扫"
                                          font:[UIFont systemFontOfSize:font_14]
                                     textColor:[UIColor jk_colorWithHexString:COLOR_GREEN]
                                     alignment:NSTextAlignmentCenter];
    reScanLb.userInteractionEnabled = YES;
    [reScanLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself.buttonSubject sendNext:@"1"];
        [weakself removeFromSuperview];
    }];
    [self addSubview:reScanLb];
    [reScanLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self);
        make.right.equalTo(self.centerX);
        make.top.equalTo(lineView.mas_bottom);
        make.height.equalTo(50);
    }];

    UILabel *sureLb = [UILabel labelWithText:@"确认"
                                        font:[UIFont systemFontOfSize:font_14]
                                   textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                   alignment:NSTextAlignmentCenter];
    sureLb.userInteractionEnabled = YES;
    [sureLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself sureResultStr];
    }];
    [self addSubview:sureLb];
    [sureLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(reScanLb);
        make.right.equalTo(self);
        make.left.equalTo(self.centerX);
        make.height.equalTo(50);
    }];

    UIView *middleLine = [UIView new];
    middleLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [self addSubview:middleLine];
    [middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(0.5);
        make.centerX.equalTo(self);
        make.top.equalTo(reScanLb);
        make.height.equalTo(50);
    }];
}

- (void)sureResultStr
{
    NSMutableString *string = [NSMutableString stringWithCapacity:0];
    for (int i = 0; i < self.labels.count; i++)
    {
        UILabel *label = self.labels[i];
        if (![Tools isEmpty:label.text])
        {
            [string appendString:label.text];
        }
    }
    if (![Tools isEmpty:string])
    {
        [self.buttonSubject sendNext:string];
        [self removeFromSuperview];
    }
    
}

- (void)seleteNumberWithIndexrow:(int)indexRow
{
    self.currentRow = indexRow;
    [self.subject sendNext:[NSNumber numberWithInt:indexRow]];
    for (int i = 0; i < self.labels.count; i++)
    {
        UILabel *label = self.labels[i];
        label.layer.borderColor = i == indexRow ? [UIColor jk_colorWithHexString:@"#cccccc"].CGColor : [UIColor jk_colorWithHexString:COLOR_BACK].CGColor;
    }
}

- (void)recoverState
{
    for (int i = 0; i < self.labels.count; i++)
    {
        UILabel *label = self.labels[i];
        label.layer.borderColor = [UIColor jk_colorWithHexString:COLOR_BACK].CGColor;
    }
}

- (void)setCurrentLb:(NSString *)name back:(BOOL)back
{
    self.labels[self.currentRow].text = name;
    if (back)
    {
        if (self.currentRow == 0)
        {
            return;
        }
        self.currentRow--;
        [self seleteNumberWithIndexrow:self.currentRow];
    }
    else
    {
        if (self.isNewCar)
        {
            if (self.currentRow == self.labels.count - 1)
            {
                return;
            }
        }
        else
        {
            if (self.currentRow == self.labels.count - 2)
            {
                return;
            }
        }
        self.currentRow++;
        [self seleteNumberWithIndexrow:self.currentRow];
    }
}

@end
