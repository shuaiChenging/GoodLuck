//
//  InfoInputRightCompent.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/6.
//

#import "InfoInputRightCompent.h"
@interface InfoInputRightCompent ()
@property (nonatomic, strong) UILabel *nameLb;

@end
@implementation InfoInputRightCompent

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

- (GLTextField *)textField
{
    if (!_textField)
    {
        _textField = [GLTextField new];
        _textField.textColor = [UIColor jk_colorWithHexString:@"666666"];
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
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

- (void)customerUI
{
    [self addSubview:self.nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.centerY.equalTo(self);
    }];
    
    [self addSubview:self.textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(100);
        make.right.equalTo(self).offset(-16);
        make.centerY.equalTo(self);
    }];
}

- (void)setName:(NSString *)name placeholder:(NSString *)placehodler
{
    self.nameLb.text = name;
    [self.textField placeHolderString:placehodler];
}
@end
