//
//  WorkOrderDetailCell.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/16.
//

#import "WorkOrderDetailCell.h"
@interface WorkOrderDetailCell ()
@property (nonatomic, strong) UILabel *timeLb;
@property (nonatomic, strong) UILabel *carNoLb;
@property (nonatomic, strong) UILabel *orderNoLb;
@property (nonatomic, strong) UILabel *projectNameLb;
@property (nonatomic, strong) UILabel *orderStatusLb;
@property (nonatomic, strong) UILabel *carTeamLb;
@property (nonatomic, strong) UILabel *classesLb;
@property (nonatomic, strong) UILabel *priceLb;
@property (nonatomic, strong) UILabel *soilTypeLb;
@property (nonatomic, strong) UILabel *soilWayLb;
@property (nonatomic, strong) UILabel *dateLb;
@property (nonatomic, strong) UILabel *outPeopleLb;
@property (nonatomic, strong) UILabel *outTimeLb;
@property (nonatomic, strong) UIImageView *outImg;
@property (nonatomic, strong) UIImageView *carFontImg;
@property (nonatomic, strong) UIImageView *mapImg;
@end
@implementation WorkOrderDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
        [self customerUI];
    }
    
    return self;
}

+ (instancetype)cellWithCollectionView:(UITableView *)tableView
{
    WorkOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    return cell;
}

- (UILabel *)timeLb
{
    if (!_timeLb)
    {
        _timeLb = [UILabel labelWithText:@"2022.05.18 第一车"
                                    font:[UIFont systemFontOfSize:12]
                               textColor:[UIColor blueColor]
                               alignment:NSTextAlignmentCenter];
    }
    return _timeLb;
}

- (UILabel *)carNoLb
{
    if (!_carNoLb)
    {
        _carNoLb = [UILabel labelWithText:@"浙A"
                                     font:[UIFont boldSystemFontOfSize:14]
                                textColor:[UIColor blackColor]
                                alignment:NSTextAlignmentCenter];
    }
    return _carNoLb;
}

- (UILabel *)orderNoLb
{
    if (!_orderNoLb)
    {
        _orderNoLb = [UILabel labelWithText:@"工单编号："
                                       font:[UIFont systemFontOfSize:11]
                                  textColor:[UIColor blackColor]
                                  alignment:NSTextAlignmentCenter];
    }
    return _orderNoLb;
}

- (UILabel *)projectNameLb
{
    if (!_projectNameLb)
    {
        _projectNameLb = [UILabel labelWithText:@"龙湖"
                                           font:[UIFont systemFontOfSize:12]
                                      textColor:[UIColor blackColor]
                                      alignment:NSTextAlignmentRight];
    }
    return _projectNameLb;
}

- (UILabel *)orderStatusLb
{
    if (!_orderStatusLb)
    {
        _orderStatusLb = [UILabel labelWithText:@"已出场"
                                           font:[UIFont systemFontOfSize:12]
                                      textColor:[UIColor blackColor]
                                      alignment:NSTextAlignmentRight];
    }
    return _orderStatusLb;
}

- (UILabel *)carTeamLb
{
    if (!_carTeamLb)
    {
        _carTeamLb = [UILabel labelWithText:@"小刚"
                                       font:[UIFont systemFontOfSize:12]
                                  textColor:[UIColor blackColor]
                                  alignment:NSTextAlignmentRight];
    }
    return _carTeamLb;
}

- (UILabel *)classesLb
{
    if (!_classesLb)
    {
        _classesLb = [UILabel labelWithText:@"白班"
                                       font:[UIFont systemFontOfSize:12]
                                  textColor:[UIColor blackColor]
                                  alignment:NSTextAlignmentRight];
    }
    return _classesLb;
}

- (UILabel *)priceLb
{
    if (!_priceLb)
    {
        _priceLb = [UILabel labelWithText:@"0元"
                                     font:[UIFont systemFontOfSize:12]
                                textColor:[UIColor blackColor]
                                alignment:NSTextAlignmentRight];
    }
    return _priceLb;
}

- (UILabel *)soilTypeLb
{
    if (!_soilTypeLb)
    {
        _soilTypeLb = [UILabel labelWithText:@"黑土"
                                        font:[UIFont systemFontOfSize:12]
                                   textColor:[UIColor blackColor]
                                   alignment:NSTextAlignmentRight];
    }
    return _soilTypeLb;
}

- (UILabel *)soilWayLb
{
    if (!_soilWayLb)
    {
        _soilWayLb = [UILabel labelWithText:@"自倒"
                                       font:[UIFont systemFontOfSize:12]
                                  textColor:[UIColor blackColor]
                                  alignment:NSTextAlignmentRight];
    }
    return _soilWayLb;
}

- (void)customerUI
{
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-20);
    }];
    
    [backView addSubview:self.timeLb];
}

@end
