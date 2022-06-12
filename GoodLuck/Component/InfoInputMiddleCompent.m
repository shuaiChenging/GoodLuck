//
//  InfoInputMiddleCompent.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/6.
//

#import "InfoInputMiddleCompent.h"
@interface InfoInputMiddleCompent ()
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UITextField *textField;
@end
@implementation InfoInputMiddleCompent

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self customerUI];
    }
    return self;
}

- (UIImageView *)rightImg
{
    if (!_rightImg)
    {
        _rightImg = [UIImageView new];
        _rightImg.backgroundColor = [UIColor grayColor];
        _rightImg.userInteractionEnabled = YES;
    }
    return _rightImg;
}

- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [UITextField new];
        _textField.textColor = [UIColor jk_colorWithHexString:@"666666"];
        _textField.font = [UIFont systemFontOfSize:15];
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
                               textColor:nil
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
    
    [self addSubview:self.rightImg];
    [_rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(30);
        make.right.equalTo(self).offset(-16);
        make.centerY.equalTo(self);
    }];
    
    [self addSubview:self.textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(100);
        make.right.equalTo(self).offset(-16);
        make.centerY.equalTo(self);
    }];
}

- (void)setName:(NSString *)name placeholder:(NSString *)placehodler imageName:(nullable NSString *)imageName
{
    self.nameLb.text = name;
    self.textField.placeholder = placehodler;
    self.rightImg.hidden = imageName.length == 0;
    if (imageName.length > 0)
    {
        self.rightImg.image = [UIImage imageNamed:imageName];
        
        [_textField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-32 - 30);
        }];
    }
}

@end
