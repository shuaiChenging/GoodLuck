//
//  RangePickerViewController.m
//  FSCalendar
//
//  Created by dingwenchao on 5/8/16.
//  Copyright © 2016 Wenchao Ding. All rights reserved.
//

#import "RangePickerViewController.h"
#import "FSCalendar.h"
#import "RangePickerCell.h"
#import "FSCalendarExtensions.h"
#import "DatePointManage.h"
@interface RangePickerViewController () <FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance>

@property (strong, nonatomic) FSCalendar *calendar;

@property (strong, nonatomic) UILabel *eventLabel;
@property (strong, nonatomic) NSCalendar *gregorian;
@property (nonatomic, assign) BOOL isFirstLoad;
@property (nonatomic, assign) bool isSeleted;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
- (void)configureCell:(__kindof FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)position;

@end

@implementation RangePickerViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isFirstLoad = YES;
    self.isSeleted = NO;
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectZero];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.pagingEnabled = NO;
    calendar.allowsMultipleSelection = YES;
    calendar.rowHeight = 60;
    calendar.placeholderType = FSCalendarPlaceholderTypeNone;
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    calendar.locale = locale;
    calendar.appearance.titleDefaultColor = [UIColor blackColor];
    calendar.appearance.headerTitleColor = [UIColor blackColor];
    calendar.appearance.weekdayTextColor = [UIColor blackColor];
    calendar.appearance.eventDefaultColor = [UIColor jk_colorWithHexString:@"#2dc258"];
    calendar.appearance.eventSelectionColor = [UIColor jk_colorWithHexString:@"#2dc258"];
    calendar.appearance.eventOffset = CGPointMake(0, -36);
    calendar.appearance.titleFont = [UIFont systemFontOfSize:16];
    calendar.weekdayHeight = 40;
    calendar.swipeToChooseGesture.enabled = YES;
    
    calendar.today = nil; // Hide the today circle
    [calendar registerClass:[RangePickerCell class] forCellReuseIdentifier:@"cell"];
    
    self.calendar = calendar;
    self.calendar.accessibilityIdentifier = @"calendar";
    [self.view addSubview:self.calendar];
    [self.calendar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    // Uncomment this to perform an 'initial-week-scope'
    // self.calendar.scope = FSCalendarScopeWeek;
    
    // For UITest
}

- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark - FSCalendarDataSource

- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
    return [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:-12 toDate:[NSDate date] options:0];
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
    return [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:[NSDate date] options:0];
}

- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date
{
    NSString *dateStr = [Tools dateToString:date withDateFormat:@"yyyy-MM-dd"];
    NSInteger number = [[DatePointManage shareInstance].dateArr containsObject:dateStr] ? 1 : 0;
    return number;
}

- (NSString *)calendar:(FSCalendar *)calendar titleForDate:(NSDate *)date
{
    if ([self.gregorian isDateInToday:date])
    {
        return @"今天";
    }
    return nil;
}

- (FSCalendarCell *)calendar:(FSCalendar *)calendar cellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    RangePickerCell *cell = [calendar dequeueReusableCellWithIdentifier:@"cell" forDate:date atMonthPosition:monthPosition];
    return cell;
}

- (void)calendar:(FSCalendar *)calendar willDisplayCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    [self configureCell:cell forDate:date atMonthPosition:monthPosition];
}

#pragma mark - FSCalendarDelegate

- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    return monthPosition == FSCalendarMonthPositionCurrent;
}

- (BOOL)calendar:(FSCalendar *)calendar shouldDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    return monthPosition == FSCalendarMonthPositionCurrent;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    self.isSeleted = YES;
    if (self.isSingle)
    {
        self.date1 = date;
    }
    else
    {
        if (self.date2)
        {
            [calendar deselectDate:self.date1];
            [calendar deselectDate:self.date2];
            self.date1 = date;
            self.date2 = nil;
        }
        else if (!self.date1)
        {
            self.date1 = date;
        }
        else
        {
            self.date2 = date;
        }
    }
    [self configureVisibleCells];
    if ([self.gregorian isDate:self.date1 inSameDayAsDate:self.date2])
    {
        FSCalendarCell *cell = [calendar cellForDate:date atMonthPosition:FSCalendarMonthPositionCurrent];
        RangePickerCell *rangeCell = (RangePickerCell *)cell;
        rangeCell.startLayer.hidden = rangeCell.endLayer.hidden = YES;
        rangeCell.todayLayer.hidden = NO;
    }
}

- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    FSCalendarCell *cell = [calendar cellForDate:date atMonthPosition:FSCalendarMonthPositionCurrent];
    RangePickerCell *rangeCell = (RangePickerCell *)cell;
    if (self.date2)
    {
        [calendar deselectDate:self.date1];
        [calendar deselectDate:self.date2];
        self.date1 = date;
        self.date2 = nil;
        self.date3 = nil;
        [self configureVisibleCells];
        rangeCell.titleLabel.textColor = [UIColor whiteColor];
    }
    else
    {
        [calendar deselectDate:self.date1];
        self.date1 = nil;
        self.date3 = date;
        [self configureVisibleCells];
        rangeCell.titleLabel.textColor = [UIColor whiteColor];
        rangeCell.todayLayer.hidden = NO;
    }
    
}

- (NSArray<UIColor *> *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventDefaultColorsForDate:(NSDate *)date
{
    return @[appearance.eventDefaultColor];
}

- (void)clearOtherWithisSingle:(BOOL)isSingle
{
    [self.calendar deselectDate:self.date1];
    [self.calendar deselectDate:self.date2];
    self.date1 = isSingle ? [NSDate date] : nil;
    self.date2 = nil;
    self.date3 = nil;
    self.isSingle = isSingle;
    self.isFirstLoad = !isSingle;
    self.isSeleted = NO;
    self.calendar.allowsMultipleSelection = !isSingle;
    [self configureVisibleCells];
}

#pragma mark - Private methods

- (void)configureVisibleCells
{
    [self.calendar.visibleCells enumerateObjectsUsingBlock:^(__kindof FSCalendarCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDate *date = [self.calendar dateForCell:obj];
        FSCalendarMonthPosition position = [self.calendar monthPositionForCell:obj];
        [self configureCell:obj forDate:date atMonthPosition:position];
    }];
}

- (void)configureCell:(__kindof FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)position
{
    RangePickerCell *rangeCell = cell;
    if (position != FSCalendarMonthPositionCurrent)
    {
        rangeCell.middleLayer.hidden = YES;
        rangeCell.selectionLayer.hidden = YES;
        return;
    }
    //// middleLayer
    if (self.date1 && self.date2)
    {
            // The date is in the middle of the range
        BOOL isMiddle = [date compare:self.date1] != [date compare:self.date2];
        rangeCell.middleLayer.hidden = !isMiddle;
    }
    else
    {
        rangeCell.middleLayer.hidden = YES;
    }
    
    if (self.isSingle)
    {
        BOOL isSelected = NO;
        isSelected |= self.date1 && [self.gregorian isDate:date inSameDayAsDate:self.date1];
        isSelected |= self.date2 && [self.gregorian isDate:date inSameDayAsDate:self.date2];
        rangeCell.selectionLayer.hidden = !isSelected;
        rangeCell.startLayer.hidden = rangeCell.endLayer.hidden = rangeCell.todayLayer.hidden = YES;
        rangeCell.titleLabel.textColor = isSelected ? [UIColor whiteColor] : [UIColor blackColor];
    }
    else
    {
        
        if ([self.gregorian isDate:date inSameDayAsDate:self.date1])
        {
            rangeCell.startLayer.hidden = self.date2 && [self.date1 compare:self.date2] == NSOrderedDescending;
            rangeCell.endLayer.hidden = !rangeCell.startLayer.hidden;
            rangeCell.titleLabel.textColor = [UIColor whiteColor];
        }
        else if ([self.gregorian isDate:date inSameDayAsDate:self.date2])
        {
            rangeCell.startLayer.hidden = [self.date1 compare:self.date2] == NSOrderedAscending;
            rangeCell.endLayer.hidden = !rangeCell.startLayer.hidden;
            rangeCell.titleLabel.textColor = [UIColor whiteColor];
        }
        else
        {
            rangeCell.startLayer.hidden = rangeCell.endLayer.hidden = YES;
            rangeCell.titleLabel.textColor = [UIColor blackColor];
        }
        rangeCell.selectionLayer.hidden = rangeCell.todayLayer.hidden = YES;
    }
    
    if ([self.gregorian isDate:date inSameDayAsDate:[NSDate date]])
    {
        rangeCell.eventIndicator.color = [UIColor jk_colorWithHexString:@"#2dc258"];
        rangeCell.titleLabel.textColor = !self.isFirstLoad && self.isSeleted ? [UIColor blackColor] : [UIColor whiteColor];
        if ([self.gregorian isDateInToday:self.date1] || [self.gregorian isDateInToday:self.date2])
        {
            rangeCell.titleLabel.textColor = [UIColor whiteColor];
        }
        rangeCell.todayLayer.hidden = !self.isFirstLoad && self.isSeleted;
        self.isFirstLoad = NO;
    }
    
}

@end
