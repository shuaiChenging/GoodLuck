//
//  InfoInputMiddleCompent.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/6.
//

#import "InfoInputMiddleCompent.h"
@interface InfoInputMiddleCompent ()
@property (nonatomic, strong) UILabel *nameLb;
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

- (GLImageView *)rightImg
{
    if (!_rightImg)
    {
        _rightImg = [GLImageView new];
        _rightImg.userInteractionEnabled = YES;
    }
    return _rightImg;
}

- (GLTextField *)textField
{
    if (!_textField)
    {
        _textField = [GLTextField new];
        _textField.textColor = [UIColor jk_colorWithHexString:COLOR_242424];
        _textField.font = [UIFont systemFontOfSize:font_14];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _textField;
}

- (UILabel *)nameLb
{
    if (!_nameLb)
    {
        _nameLb = [UILabel labelWithText:@""
                                    font:[UIFont systemFontOfSize:font_14]
                               textColor:[UIColor jk_colorWithHexString:COLOR_666666]
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
        make.width.height.equalTo(24);
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
    [self.textField placeHolderString:placehodler];
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
