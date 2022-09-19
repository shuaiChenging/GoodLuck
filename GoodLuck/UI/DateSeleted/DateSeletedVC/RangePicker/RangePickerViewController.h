//
//  RangePickerViewController.h
//  FSCalendar
//
//  Created by dingwenchao on 5/8/16.
//  Copyright © 2016 Wenchao Ding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RangePickerViewController : UIViewController
// The start date of the range
@property (strong, nonatomic) NSDate *date1;
// The end date of the range
@property (strong, nonatomic) NSDate *date2;

@property (strong, nonatomic) NSDate *date3;

@property (nonatomic, assign) BOOL isSingle;

- (void)clearOtherWithisSingle:(BOOL)isSingle;
@end
