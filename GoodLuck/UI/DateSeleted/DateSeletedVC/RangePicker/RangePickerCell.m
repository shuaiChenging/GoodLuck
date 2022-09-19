//
//  RangePickerCell.m
//  FSCalendar
//
//  Created by dingwenchao on 02/11/2016.
//  Copyright © 2016 Wenchao Ding. All rights reserved.
//

#import "RangePickerCell.h"
#import "FSCalendarExtensions.h"
@interface RangePickerCell ()
@property (nonatomic, strong) UILabel *todayLb;
@property (nonatomic, strong) UILabel *startLb;
@property (nonatomic, strong) UILabel *endLb;
@end
@implementation RangePickerCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIBezierPath *startBezierPath = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds
                                                              byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft
                                                                    cornerRadii:(CGSize){10.0}];
        CAShapeLayer *startShapeLayer = [CAShapeLayer layer];
        // 设置绘制路径
        startShapeLayer.path = startBezierPath.CGPath;
        
        UIBezierPath *endBezierPath = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds
                                                              byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight
                                                                    cornerRadii:(CGSize){10.0}];
        CAShapeLayer *endShapeLayer = [CAShapeLayer layer];
        // 设置绘制路径
        endShapeLayer.path = endBezierPath.CGPath;
        
        
        
        CALayer *startLayer = [[CALayer alloc] init];
        startLayer.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE].CGColor;
        startLayer.mask = startShapeLayer;
        [startLayer addSublayer:self.startLb.layer];
        [self.contentView.layer insertSublayer:startLayer below:self.titleLabel.layer];
        self.startLayer = startLayer;
        
        CALayer *endLayer = [[CALayer alloc] init];
        endLayer.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE].CGColor;
        endLayer.mask = endShapeLayer;
        [endLayer addSublayer:self.endLb.layer];
        [self.contentView.layer insertSublayer:endLayer below:self.titleLabel.layer];
        self.endLayer = endLayer;
        
        CALayer *todayLayer = [[CALayer alloc] init];
        todayLayer.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE].CGColor;
        todayLayer.cornerRadius = 10;
        [todayLayer addSublayer:self.todayLb.layer];
        [self.contentView.layer insertSublayer:todayLayer below:self.titleLabel.layer];
        self.todayLayer = todayLayer;
        
        CALayer *selectionLayer = [[CALayer alloc] init];
        selectionLayer.cornerRadius = 10;
        selectionLayer.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE].CGColor;
        selectionLayer.actions = @{@"hidden":[NSNull null]}; // Remove hiding animation
        [self.contentView.layer insertSublayer:selectionLayer below:self.titleLabel.layer];
        self.selectionLayer = selectionLayer;
        
        CALayer *middleLayer = [[CALayer alloc] init];
        middleLayer.backgroundColor = [[UIColor jk_colorWithHexString:COLOR_BLUE] colorWithAlphaComponent:0.1].CGColor;
        middleLayer.actions = @{@"hidden":[NSNull null]}; // Remove hiding animation
        [self.contentView.layer insertSublayer:middleLayer below:self.titleLabel.layer];
        self.middleLayer = middleLayer;
        
        // Hide the default selection layer
        self.shapeLayer.hidden = YES;
    
        
    }
    return self;
}

- (UILabel *)startLb
{
    if (!_startLb)
    {
        _startLb = [UILabel labelWithText:@"开始"
                                     font:[UIFont systemFontOfSize:font_10]
                                textColor:[UIColor whiteColor]
                                alignment:NSTextAlignmentCenter];
    }
    return _startLb;
}

- (UILabel *)endLb
{
    if (!_endLb)
    {
        _endLb = [UILabel labelWithText:@"结束"
                                   font:[UIFont systemFontOfSize:font_10]
                              textColor:[UIColor whiteColor]
                              alignment:NSTextAlignmentCenter];
    }
    return _endLb;
}

- (UILabel *)todayLb
{
    if (!_todayLb)
    {
        _todayLb = [UILabel labelWithText:@"开始/结束"
                                     font:[UIFont systemFontOfSize:font_10]
                                textColor:[UIColor whiteColor]
                                alignment:NSTextAlignmentCenter];
    }
    return _todayLb;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = self.contentView.bounds;
}

- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    [super layoutSublayersOfLayer:layer];
    self.selectionLayer.frame = self.contentView.bounds;
    self.middleLayer.frame = self.contentView.bounds;
    self.todayLayer.frame = self.contentView.bounds;
    self.startLayer.frame = self.contentView.bounds;
    self.endLayer.frame = self.contentView.bounds;
    self.todayLb.frame = CGRectMake(0, self.todayLayer.frame.size.height - 24, self.todayLayer.frame.size.width, 20);
    self.startLb.frame = CGRectMake(0, self.startLayer.frame.size.height - 24, self.startLayer.frame.size.width, 20);
    self.endLb.frame = CGRectMake(0, self.endLayer.frame.size.height - 24, self.endLayer.frame.size.width, 20);
}

@end
