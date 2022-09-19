//
//  RangePickerCell.h
//  FSCalendar
//
//  Created by dingwenchao on 02/11/2016.
//  Copyright © 2016 Wenchao Ding. All rights reserved.
//

#import <FSCalendar/FSCalendar.h>

@interface RangePickerCell : FSCalendarCell

// The start/end of the range
@property (weak, nonatomic) CALayer *selectionLayer;

// The middle of the range
@property (weak, nonatomic) CALayer *middleLayer;

@property (weak, nonatomic) CALayer *todayLayer;

@property (weak, nonatomic) CALayer *startLayer;

@property (weak, nonatomic) CALayer *endLayer;

@end
