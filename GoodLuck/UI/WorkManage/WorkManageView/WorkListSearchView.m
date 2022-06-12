//
//  WorkListSearchView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/4.
//

#import "WorkListSearchView.h"

@implementation WorkListSearchView

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
        _textField.placeholder = @"项目搜索";
    }
    return _textField;
}

- (void)customerUI
{
    UIImageView *searchImg = [UIImageView new];
    searchImg.backgroundColor = [UIColor grayColor];
    [self addSubview:searchImg];
    [searchImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(30);
        make.centerY.left.equalTo(self);
    }];
    
    [self addSubview:self.textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchImg.mas_right);
        make.top.bottom.right.equalTo(self);
    }];
}

@end
