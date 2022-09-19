//
//  EchartCell.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/15.
//

#import "EchartCell.h"
#import "PNChart/PNChart.h"
@interface EchartCell ()
@property (nonatomic, strong) PNLineChart *lineChart;
@property (nonatomic, strong) UILabel *zdLb;
@property (nonatomic, strong) UILabel *ztcLb;
@property (nonatomic, strong) UILabel *manageLb;
@end
@implementation EchartCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        [self customerUI];
    }
    
    return self;
}

+ (instancetype)cellWithCollectionView:(UITableView *)tableView
{
    EchartCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    return cell;
}

- (UILabel *)ztcLb
{
    if (!_ztcLb)
    {
        _ztcLb = [UILabel labelWithText:@"渣土场：0车"
                                  font:[UIFont systemFontOfSize:font_12]
                             textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                             alignment:NSTextAlignmentRight];
    }
    return _ztcLb;
}

- (UILabel *)zdLb
{
    if (!_zdLb)
    {
        _zdLb = [UILabel labelWithText:@"自倒：0车"
                                  font:[UIFont systemFontOfSize:font_12]
                             textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                             alignment:NSTextAlignmentRight];
    }
    return _zdLb;
}

- (UILabel *)manageLb
{
    if (!_manageLb)
    {
        _manageLb = [UILabel labelWithText:@"上班管理员："
                                      font:[UIFont systemFontOfSize:font_14]
                                 textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                 alignment:NSTextAlignmentLeft];
    }
    return _manageLb;
}

- (PNLineChart *)lineChart
{
    if (!_lineChart)
    {
        _lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 70, kScreenWidth - 32, 200)];
        _lineChart.backgroundColor = [UIColor whiteColor];
        _lineChart.yGridLinesColor = [UIColor grayColor];
        [_lineChart.chartData enumerateObjectsUsingBlock:^(PNLineChartData *obj, NSUInteger idx, BOOL *stop) {
            obj.pointLabelColor = [UIColor blackColor];
        }];
        [_lineChart setXLabels:@[@"0:00",
                                 @"1:00",
                                 @"2:00",
                                 @"3:00",
                                 @"4:00",
                                 @"5:00",
                                 @"6:00",
                                 @"7:00",
                                 @"8:00",
                                 @"9:00",
                                 @"10:00",
                                 @"11:00",
                                 @"12:00",
                                 @"13:00",
                                 @"14:00",
                                 @"15:00",
                                 @"16:00",
                                 @"17:00",
                                 @"18:00",
                                 @"19:00",
                                 @"20:00",
                                 @"21:00",
                                 @"22:00",
                                 @"23:00"]];
        
        _lineChart.yLabelColor = [UIColor blackColor];
        _lineChart.xLabelColor = [UIColor redColor];

        _lineChart.showGenYLabels = NO;
        _lineChart.showYGridLines = YES;

        _lineChart.yFixedValueMin = 0;
    }
    return _lineChart;
}

- (void)customerUI
{
    UIView *backView = [UIView new];
    backView.layer.masksToBounds = YES;
    backView.layer.cornerRadius = 5;
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.top.bottom.equalTo(self.contentView);
    }];
    
    [backView addSubview:self.lineChart];
    
    [backView addSubview:self.zdLb];
    [_zdLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-16);
        make.top.equalTo(backView).offset(16);
    }];
    
    UIView *blueView = [UIView new];
    blueView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
    [backView addSubview:blueView];
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(10);
        make.centerY.equalTo(self.zdLb);
        make.right.equalTo(self.zdLb.mas_left).offset(-10);
    }];
    
    [backView addSubview:self.ztcLb];
    [_ztcLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(blueView.mas_left).offset(-10);
        make.centerY.equalTo(self.zdLb);
    }];
    
    UIView *greenView = [UIView new];
    greenView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_GREEN];
    [backView addSubview:greenView];
    [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(10);
        make.centerY.equalTo(self.ztcLb);
        make.right.equalTo(self.ztcLb.mas_left).offset(-10);
    }];
    
    UILabel *orderLb = [UILabel labelWithText:@"工单数"
                                         font:[UIFont systemFontOfSize:font_12]
                                    textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                    alignment:NSTextAlignmentLeft];
    [backView addSubview:orderLb];
    [orderLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(16);
        make.top.equalTo(blueView.mas_bottom).offset(8);
    }];
    
    [backView addSubview:self.manageLb];
    [_manageLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(16);
        make.bottom.equalTo(backView).offset(-16);
    }];
}

- (void)loadViewWithModel:(WorkDetailZTResponse *)model
{
    self.ztcLb.text = [NSString stringWithFormat:@"渣土场：%@",model.ztcCount];
    self.zdLb.text = [NSString stringWithFormat:@"自倒：%@",model.zdCount];
    self.manageLb.text = [NSString stringWithFormat:@"上班管理员：%@",model.name];
    _lineChart.yFixedValueMax = model.maxCount;
    [_lineChart setYLabels:model.yArr];
    
    NSArray *ztArray = model.ztArr;
    PNLineChartData *ztData = [PNLineChartData new];
    ztData.color = [UIColor jk_colorWithHexString:COLOR_GREEN];
    ztData.pointLabelColor = [UIColor blackColor];
    ztData.alpha = 1;
    ztData.showPointLabel = YES;
    ztData.itemCount = ztArray.count;
    ztData.inflexionPointColor = PNRed;
    ztData.inflexionPointStyle = PNLineChartPointStyleNone;
    ztData.getData = ^(NSUInteger index) {
        CGFloat yValue = [ztArray[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    NSArray *zdArray = model.zdArr;
    PNLineChartData *zdData = [PNLineChartData new];
    zdData.pointLabelColor = [UIColor blackColor];
    zdData.color = [UIColor jk_colorWithHexString:COLOR_BLUE];
    zdData.alpha = 1;
    zdData.itemCount = zdArray.count;
    zdData.inflexionPointStyle = PNLineChartPointStyleNone;
    zdData.getData = ^(NSUInteger index) {
        CGFloat yValue = [zdArray[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    self.lineChart.chartData = @[ztData,zdData];
    [self.lineChart.chartData enumerateObjectsUsingBlock:^(PNLineChartData *obj, NSUInteger idx, BOOL *stop) {
        obj.pointLabelColor = [UIColor blackColor];
    }];

    [self.lineChart strokeChart];
}

@end
