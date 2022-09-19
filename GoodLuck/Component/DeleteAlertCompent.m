//
//  DeleteAlertCompent.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/6.
//

#import "DeleteAlertCompent.h"
@interface DeleteAlertCompent ()
@property (nonatomic, strong) UILabel *descrbeLb;
@property (nonatomic, strong) UITextView *textField;
@property (nonatomic, strong) UILabel *numberLb;
@property (nonatomic, strong) UILabel *adminLb;
@property (nonatomic, strong) UILabel *textLb;
@end
@implementation DeleteAlertCompent

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

- (UITextView *)textField
{
    if (!_textField)
    {
        _textField = [UITextView new];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.font = [UIFont systemFontOfSize:font_14];
        _textField.textColor = [UIColor jk_colorWithHexString:COLOR_242424];
    }
    return _textField;
}

- (UILabel *)textLb
{
    if (!_textLb)
    {
        _textLb = [UILabel labelWithText:@"请输入删除原因"
                                    font:[UIFont systemFontOfSize:font_14]
                               textColor:[UIColor jk_colorWithHexString:@"#cccccc"]
                               alignment:NSTextAlignmentLeft];
    }
    return _textLb;
}

- (UILabel *)descrbeLb
{
    if (!_descrbeLb)
    {
        _descrbeLb = [UILabel labelWithText:@"确定"
                                       font:[UIFont systemFontOfSize:font_14]
                                  textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                  alignment:NSTextAlignmentLeft];
        _descrbeLb.numberOfLines = 0;
    }
    return _descrbeLb;
}

- (UILabel *)adminLb
{
    if (!_adminLb)
    {
        _adminLb = [UILabel labelWithText:@"操作人员："
                                     font:[UIFont systemFontOfSize:font_14]
                                textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                alignment:NSTextAlignmentLeft];
    }
    return _adminLb;
}

- (RACSubject *)subject
{
    if (!_subject)
    {
        _subject = [RACSubject new];
    }
    return _subject;
}

- (UILabel *)numberLb
{
    if (!_numberLb)
    {
        _numberLb = [UILabel labelWithText:@"0/50"
                                      font:[UIFont systemFontOfSize:font_12]
                                 textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                 alignment:NSTextAlignmentRight];
    }
    return _numberLb;
}

- (void)customerUI
{
    UILabel *titleLb = [UILabel labelWithText:@"删除提示"
                                         font:[UIFont systemFontOfSize:font_16]
                                    textColor:[UIColor redColor]
                                    alignment:NSTextAlignmentCenter];
    [self addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(20);
    }];
    
    [self addSubview:self.descrbeLb];
    [_descrbeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.top.equalTo(titleLb.mas_bottom).offset(16);
    }];
    
    [self addSubview:self.textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.descrbeLb);
        make.top.equalTo(self.descrbeLb.mas_bottom).offset(4);
        make.height.equalTo(50);
    }];
    WeakSelf(self)
    [_textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        weakself.textLb.hidden = [x length] > 0;
        if (x.length > 50)
        {
            weakself.textField.text = [x substringToIndex:50];
        }
        weakself.numberLb.text = [NSString stringWithFormat:@"%ld/50",weakself.textField.text.length];
    }];
    
    [self addSubview:self.textLb];
    [_textLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textField).offset(2);
        make.top.equalTo(self.textField).offset(8);
    }];
    
    [self addSubview:self.numberLb];
    [_numberLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.textField);
        make.top.equalTo(self.textField.mas_bottom);
    }];
    
    UIView *firstLine = [UIView new];
    firstLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [self addSubview:firstLine];
    [firstLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(self);
        make.top.equalTo(self.numberLb.mas_bottom).offset(6);
    }];
    
    [self addSubview:self.adminLb];
    [_adminLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textField);
        make.top.equalTo(firstLine.mas_bottom).offset(10);
    }];
    
    UIView *secondLine = [UIView new];
    secondLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [self addSubview:secondLine];
    [secondLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(self);
        make.top.equalTo(self.adminLb.mas_bottom).offset(10);
    }];
    
    UILabel *cancelLb = [UILabel labelWithText:@"取消"
                                          font:[UIFont systemFontOfSize:font_16]
                                     textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                     alignment:NSTextAlignmentCenter];
    cancelLb.userInteractionEnabled = YES;
    [cancelLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself.subject sendNext:@(1)];
        [weakself removeFromSuperview];
    }];
    [self addSubview:cancelLb];
    [cancelLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondLine.mas_bottom);
        make.left.equalTo(self);
        make.height.equalTo(40);
        make.right.equalTo(self.centerX);
        make.bottom.equalTo(self);
    }];

    UILabel *sureLb = [UILabel labelWithText:@"确认"
                                        font:[UIFont systemFontOfSize:font_16]
                                   textColor:[UIColor jk_colorWithHexString:COLOR_BLUE]
                                   alignment:NSTextAlignmentCenter];
    sureLb.userInteractionEnabled = YES;
    [sureLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
       if (weakself.textField.text.length == 0)
       {
           [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入删除原因"];
           return;
       }
        [weakself.subject sendNext:weakself.textField.text];
        [weakself removeFromSuperview];
    }];
    [self addSubview:sureLb];
    [sureLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondLine.mas_bottom);
        make.left.equalTo(self.centerX);
        make.right.equalTo(self);
        make.height.equalTo(40);
    }];

    UIView *middleLine = [UIView new];
    middleLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [self addSubview:middleLine];
    [middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cancelLb);
        make.bottom.equalTo(self);
        make.centerX.equalTo(self);
        make.width.equalTo(0.5);
    }];
}

- (void)loadView:(NSString *)time carNo:(NSString *)carNo admin:(NSString *)admin
{
    self.descrbeLb.text = [NSString stringWithFormat:@"确认删除出场时间为%@车牌号为%@的工单吗？确定后，工单将提交审核。",time,carNo];
    self.adminLb.text = [NSString stringWithFormat:@"操作人员：%@",admin];
}

@end
