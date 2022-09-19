//
//  WorkManageCarHeaderView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/15.
//

#import "WorkManageCarHeaderView.h"
@interface WorkManageCarHeaderView ()
@property (nonatomic, strong) UILabel *timeLb;
@property (nonatomic, strong) UILabel *enterNumber;
@property (nonatomic, strong) UILabel *outNumber;
@property (nonatomic, strong) UILabel *carNumber;
@property (nonatomic, strong) UIImageView *arrowImg;
@end
@implementation WorkManageCarHeaderView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        [self customerUI];
    }
    return self;
}

+ (instancetype)cellWithTableViewHeaderFooterView:(UITableView *)tableView
{
    WorkManageCarHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(self)];
    return headerView;
}

- (UIImageView *)arrowImg
{
    if (!_arrowImg)
    {
        _arrowImg = [UIImageView jk_imageViewWithImageNamed:@"home_arrow_down"];
    }
    return _arrowImg;
}

- (UILabel *)timeLb
{
    if (!_timeLb)
    {
        _timeLb = [UILabel labelWithText:@"2022-06-18"
                                    font:[UIFont boldSystemFontOfSize:14]
                               textColor:[UIColor jk_colorWithHexString:COLOR_BLUE]
                               alignment:NSTextAlignmentLeft];
    }
    return _timeLb;
}

- (UILabel *)enterNumber
{
    if (!_enterNumber)
    {
        _enterNumber = [UILabel labelWithText:@"入场车数："
                                         font:[UIFont boldSystemFontOfSize:12]
                                    textColor:[UIColor blackColor]
                                    alignment:NSTextAlignmentLeft];
    }
    return _enterNumber;
}

- (UILabel *)outNumber
{
    if (!_outNumber)
    {
        _outNumber = [UILabel labelWithText:@"出场车数："
                                       font:[UIFont boldSystemFontOfSize:12]
                                  textColor:[UIColor blackColor]
                                  alignment:NSTextAlignmentLeft];
    }
    return _outNumber;
}

- (UILabel *)carNumber
{
    if (!_carNumber)
    {
        _carNumber = [UILabel labelWithText:@"车辆数："
                                       font:[UIFont boldSystemFontOfSize:12]
                                  textColor:[UIColor blackColor]
                                  alignment:NSTextAlignmentLeft];
    }
    return _carNumber;
}

- (void)customerUI
{
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.top.bottom.equalTo(self);
    }];
    
    UIView *circleView = [UIView new];
    circleView.layer.masksToBounds = YES;
    circleView.layer.cornerRadius = 5;
    circleView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
    [backView addSubview:circleView];
    [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(10);
        make.left.equalTo(backView).offset(16);
        make.top.equalTo(backView).offset(20);
    }];
    
    [backView addSubview:self.timeLb];
    [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(circleView.mas_right).offset(10);
        make.centerY.equalTo(circleView);
    }];
    
    [backView addSubview:self.arrowImg];
    [_arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-16);
        make.centerY.equalTo(circleView);
        make.width.equalTo(14);
        make.height.equalTo(6/10.0 * 14);
    }];
    
    [backView addSubview:self.enterNumber];
    [_enterNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(16);
        make.bottom.equalTo(backView).offset(-16);
    }];
    
    [backView addSubview:self.outNumber];
    [_outNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.enterNumber);
        make.centerX.equalTo(self);
    }];
    
    [backView addSubview:self.carNumber];
    [_carNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-16);
        make.centerY.equalTo(self.enterNumber);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [backView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(backView);
        make.height.equalTo(0.5);
    }];
    
}
- (void)loadViewWithModel:(CarstatisticsResponse *)model
{
    self.timeLb.text = model.inReleaseDate;
    self.enterNumber.text = [NSString stringWithFormat:@"入场车数：%@",model.inCount];
    self.outNumber.text = [NSString stringWithFormat:@"出场车数：%@",model.outCount];
    self.carNumber.text = [NSString stringWithFormat:@"车辆数：%@",model.allCount];
    if (model.isSeleted)
    {
        [self imageClose];
    }
    else
    {
        [self imgeOpen];
    }
}

/// 顺时针90度
- (void)imgeOpen
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1]; //动画时长
    _arrowImg.transform = CGAffineTransformMakeRotation(0 *M_PI / 180.0);
    [UIView commitAnimations];
}

/// 逆时针90度
- (void)imageClose
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1]; //动画时长
    _arrowImg.transform = CGAffineTransformMakeRotation(180 *M_PI / 180.0);
    [UIView commitAnimations];
}

@end
