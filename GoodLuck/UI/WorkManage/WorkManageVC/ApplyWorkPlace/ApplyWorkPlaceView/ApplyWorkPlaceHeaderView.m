//
//  ApplyWorkPlaceHeaderView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/14.
//

#import "ApplyWorkPlaceHeaderView.h"
@interface ApplyWorkPlaceHeaderView ()
@property (nonatomic, strong) UIView *bossLine;
@end
@implementation ApplyWorkPlaceHeaderView

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

- (UIView *)bossLine
{
    if (!_bossLine)
    {
        _bossLine = [UIView new];
        _bossLine.hidden = YES;
        _bossLine.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    }
    return _bossLine;
}

- (InfoInputMiddleCompent *)bossInput
{
    if (!_bossInput)
    {
        _bossInput = [InfoInputMiddleCompent new];
        _bossInput.textField.keyboardType = UIKeyboardTypeNumberPad;
        [_bossInput setName:@"老板手机" placeholder:@"移动电话号码" imageName:@"1"];
        _bossInput.textField.text = @"15995754057";
    }
    return _bossInput;
}

- (InfoInputMiddleCompent *)bossNameInput
{
    if (!_bossNameInput)
    {
        _bossNameInput = [InfoInputMiddleCompent new];
        _bossNameInput.hidden = YES;
        _bossNameInput.textField.enabled = NO;
        [_bossNameInput setName:@"老板姓名" placeholder:@"" imageName:nil];
        
    }
    return _bossNameInput;
}

- (InfoInputMiddleCompent *)contentInput
{
    if (!_contentInput)
    {
        _contentInput = [InfoInputMiddleCompent new];
        [_contentInput setName:@"申请内容" placeholder:@"备注" imageName:nil];
    }
    return _contentInput;
}

- (void)customerUI
{
    UIView *firstLine = [UIView new];
    firstLine.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [self addSubview:firstLine];
    [firstLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_safeAreaLayoutGuideTop);
    }];
    
   
    UIView *nameView = [UIView new];
    [self addSubview:nameView];
    [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(46);
        make.left.right.equalTo(self);
        make.top.equalTo(firstLine.mas_bottom);
    }];

    UILabel *nameLb = [UILabel labelWithText:@"请输入工地老板手机号"
                                        font:[UIFont systemFontOfSize:15]
                                   textColor:[UIColor blueColor]
                                   alignment:NSTextAlignmentLeft];
    [nameView addSubview:nameLb];
    [nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameView).offset(16);
        make.centerY.equalTo(nameView);
    }];

    UIView *secondLine = [UIView new];
    secondLine.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [self addSubview:secondLine];
    [secondLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(self);
        make.top.equalTo(nameView.mas_bottom);
    }];
    
    [self addSubview:self.bossNameInput];
    [_bossNameInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(46);
        make.left.right.equalTo(self);
        make.top.equalTo(secondLine.mas_bottom);
    }];
    
    [self addSubview:self.bossLine];
    [_bossLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(self);
        make.top.equalTo(self.bossNameInput.mas_bottom);
    }];

    [self addSubview:self.bossInput];
    [_bossInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(46);
        make.left.right.equalTo(self);
        make.top.equalTo(self.bossNameInput);
    }];

    UIView *thirdLine = [UIView new];
    thirdLine.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [self addSubview:thirdLine];
    [thirdLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(self);
        make.top.equalTo(self.bossInput.mas_bottom);
    }];

    [self addSubview:self.contentInput];
    [_contentInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(46);
        make.left.right.equalTo(self);
        make.top.equalTo(thirdLine.mas_bottom);
    }];

    UIView *fourthLime = [UIView new];
    fourthLime.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [self addSubview:fourthLime];
    [fourthLime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(self);
        make.top.equalTo(self.contentInput.mas_bottom);
    }];
}

- (void)showBossName
{
    _bossLine.hidden = NO;
    _bossNameInput.hidden = NO;
    [self addSubview:self.bossInput];
    [_bossInput mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(46);
        make.left.right.equalTo(self);
        make.top.equalTo(self.bossLine.mas_bottom);
    }];
}

- (void)hiddenBossName
{
    _bossLine.hidden = YES;
    _bossNameInput.hidden = YES;
    [self addSubview:self.bossInput];
    [_bossInput mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(46);
        make.left.right.equalTo(self);
        make.top.equalTo(self.bossNameInput);
    }];
}

@end
