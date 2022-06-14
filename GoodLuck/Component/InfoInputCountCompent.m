//
//  InfoInputCountCompent.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/6.
//

#import "InfoInputCountCompent.h"
@interface InfoInputCountCompent ()
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *numberLb;

@end
@implementation InfoInputCountCompent

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

- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [UITextField new];
        _textField.textColor = [UIColor jk_colorWithHexString:@"666666"];
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.textAlignment = NSTextAlignmentRight;
    }
    return _textField;
}

- (UILabel *)nameLb
{
    if (!_nameLb)
    {
        _nameLb = [UILabel labelWithText:@""
                                    font:[UIFont systemFontOfSize:15]
                               textColor:[UIColor blackColor]
                               alignment:NSTextAlignmentLeft];
    }
    return _nameLb;
}

- (UILabel *)numberLb
{
    if (!_numberLb)
    {
        _numberLb = [UILabel labelWithText:@"0/50"
                                      font:[UIFont systemFontOfSize:14]
                                 textColor:[UIColor blackColor]
                                 alignment:NSTextAlignmentRight];
    }
    return _numberLb;
}

- (void)customerUI
{
    [self addSubview:self.nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.top.equalTo(self).offset(8);
    }];
    
    [self addSubview:self.textField];
    WeakSelf(self)
    [[_textField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        if (x.length > 50)
        {
            x = [weakself.textField.text substringToIndex: 50];
            weakself.textField.text = x;
        }
        else
        {
            self.numberLb.text = [NSString stringWithFormat:@"%lu/50",(unsigned long)x.length];
        }
    }];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(100);
        make.right.equalTo(self).offset(-16);
        make.top.equalTo(self.nameLb);
    }];
    
    [self addSubview:self.numberLb];
    [_numberLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.mas_bottom).offset(6);
        make.right.equalTo(self).offset(-16);
    }];
}

- (void)setName:(NSString *)name placeholder:(NSString *)placehodler
{
    self.nameLb.text = name;
    self.textField.placeholder = placehodler;
}

@end
