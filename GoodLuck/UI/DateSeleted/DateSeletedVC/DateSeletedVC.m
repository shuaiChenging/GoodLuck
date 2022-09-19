//
//  DateSeletedVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/6.
//

#import "DateSeletedVC.h"
#import "RangePickerViewController.h"
@interface DateSeletedVC ()
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) RangePickerViewController *pickerVC;
@property (nonatomic, strong) NSMutableArray *labels;
@property (nonatomic, assign) int seletedRow;
@end

@implementation DateSeletedVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"日期选择";
    self.seletedRow = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    self.labels = [NSMutableArray arrayWithCapacity:0];
    self.array = @[@"24小时",@"白班",@"晚班",@"白晚班"];
    [self customerUI];
}

- (RangePickerViewController *)pickerVC
{
    if (!_pickerVC)
    {
        _pickerVC = [RangePickerViewController new];
    }
    return _pickerVC;
}

- (RACSubject *)subject
{
    if (!_subject)
    {
        _subject = [RACSubject new];
    }
    return _subject;
}

- (void)customerUI
{
    UIView *headerView = [UIView new];
    headerView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(40);
    }];
    
    UILabel *dayLb = [UILabel labelWithText:@"白班 06:00至18:00"
                                       font:[UIFont systemFontOfSize:font_12]
                                  textColor:[UIColor blackColor]
                                  alignment:NSTextAlignmentLeft];
    [headerView addSubview:dayLb];
    [dayLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.left.equalTo(headerView).offset(16);
    }];
    
    UILabel *nightLb = [UILabel labelWithText:@"晚班 18:00至06:00"
                                         font:[UIFont systemFontOfSize:font_12]
                                    textColor:[UIColor blackColor]
                                    alignment:NSTextAlignmentLeft];
    [headerView addSubview:nightLb];
    [nightLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.left.equalTo(dayLb.mas_right).offset(20);
    }];
    
    
    UIView *seletedView = [UIView new];
    seletedView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:seletedView];
    [seletedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(60);
    }];
    
    UILabel *lastLb;
    for (int i = 0; i < self.array.count; i++)
    {
        UILabel *label = [UILabel labelWithText:self.array[i]
                                           font:[UIFont systemFontOfSize:font_14]
                                      textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                      alignment:NSTextAlignmentCenter];
        label.userInteractionEnabled = YES;
        WeakSelf(self)
        [label jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [weakself seletedWithIndex:i];
        }];
        
        label.backgroundColor = [UIColor whiteColor];
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 5;
        label.layer.borderColor = [UIColor jk_colorWithHexString:COLOR_LINE].CGColor;
        label.layer.borderWidth = 1;
        if (i == 0)
        {
            label.layer.borderColor = [UIColor jk_colorWithHexString:COLOR_BLUE].CGColor;
            label.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
            label.textColor = [UIColor whiteColor];
        }
        [seletedView addSubview:label];
        [self.labels addObject:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(seletedView);
            make.height.equalTo(40);
            make.width.equalTo((kScreenWidth - 32 - 10 * (self.array.count - 1))/self.array.count);
            if (i == 0)
            {
                make.left.equalTo(seletedView).offset(16);
            }
            else
            {
                make.left.equalTo(lastLb.mas_right).offset(10);
            }
        }];
        lastLb = label;
    }
    
    UIView *bottomView = [UIView new];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(78);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];

    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [bottomView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(bottomView);
        make.height.equalTo(0.5);
    }];

    UIButton *button = [UIButton new];
    [button.titleLabel setFont:[UIFont systemFontOfSize:font_15]];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
    [bottomView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(16);
        make.right.equalTo(bottomView).offset(-16);
        make.center.equalTo(bottomView);
        make.height.equalTo(46);
    }];
    
    
    
    [self addChildViewController:self.pickerVC];
    [self.view addSubview:_pickerVC.view];
    [_pickerVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(seletedView.mas_bottom);
        make.bottom.equalTo(bottomView.mas_top);
    }];
    
    WeakSelf(self)
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself callBackHandle];
    }];
}

- (void)callBackHandle
{
    NSCalendar *gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    switch (self.seletedRow) {
        case 0:
        {
            if (_pickerVC.date1 == nil && _pickerVC.date2 == nil && _pickerVC.date3 == nil) /// 什么都没选默认今天
            {
                NSDictionary *dic = @{@"startTime":[NSString stringWithFormat:@"%@ 00:00:00",[Tools dateToString:[NSDate date] withDateFormat:@"yyyy-MM-dd"]],
                                      @"endTime":[Tools dateToString:[NSDate date] withDateFormat:@"yyyy-MM-dd HH:mm:ss"],
                                      @"timeName":[NSString stringWithFormat:@"%@(24小时)",[Tools dateToString:[NSDate date] withDateFormat:@"yyyy-MM-dd"]]};
                [self.subject sendNext:dic];
            }
            else
            {
                if (_pickerVC.date3) /// 选的同一天
                {
                    NSDictionary *dic = @{@"startTime":[NSString stringWithFormat:@"%@ 00:00:00",[Tools dateToString:_pickerVC.date3 withDateFormat:@"yyyy-MM-dd"]],
                                          @"endTime":[NSString stringWithFormat:@"%@ 23:59:59",[Tools dateToString:_pickerVC.date3 withDateFormat:@"yyyy-MM-dd"]],
                                          @"timeName":[NSString stringWithFormat:@"%@(24小时)",[Tools dateToString:_pickerVC.date3 withDateFormat:@"yyyy-MM-dd"]]};
                    [self.subject sendNext:dic];
                }
                else if (_pickerVC.date1 && _pickerVC.date2)
                {
                    NSDate *date1 = _pickerVC.date1;
                    NSDate *date2 = _pickerVC.date2;
                    NSComparisonResult result = [gregorian compareDate:date1 toDate:date2 toUnitGranularity:NSCalendarUnitDay];
                    if (result == NSOrderedAscending)
                    {
                        NSDictionary *dic = @{@"startTime":[Tools dateToString:date1 withDateFormat:@"yyyy-MM-dd HH:mm:ss"],
                                              @"endTime":[NSString stringWithFormat:@"%@ 23:59:59",[Tools dateToString:date2 withDateFormat:@"yyyy-MM-dd"]],
                                              @"timeName":[NSString stringWithFormat:@"%@~%@(24小时)",[Tools dateToString:date1 withDateFormat:@"yyyy-MM-dd"],[Tools dateToString:date2 withDateFormat:@"yyyy-MM-dd"]]};
                        [self.subject sendNext:dic];
                    }
                    else if (result == NSOrderedSame) /// 选的同一天
                    {
                        NSDictionary *dic = @{@"startTime":[NSString stringWithFormat:@"%@ 00:00:00",[Tools dateToString:_pickerVC.date1 withDateFormat:@"yyyy-MM-dd"]],
                                              @"endTime":[NSString stringWithFormat:@"%@ 23:59:59",[Tools dateToString:_pickerVC.date1 withDateFormat:@"yyyy-MM-dd"]],
                                              @"timeName":[NSString stringWithFormat:@"%@(24小时)",[Tools dateToString:_pickerVC.date1 withDateFormat:@"yyyy-MM-dd"]]};
                        [self.subject sendNext:dic];
                    }
                    else
                    {
                        NSDictionary *dic = @{@"startTime":[Tools dateToString:date2 withDateFormat:@"yyyy-MM-dd HH:mm:ss"],
                                              @"endTime":[NSString stringWithFormat:@"%@ 23:59:59",[Tools dateToString:date1 withDateFormat:@"yyyy-MM-dd"]],
                                              @"timeName":[NSString stringWithFormat:@"%@~%@(24小时)",[Tools dateToString:date2 withDateFormat:@"yyyy-MM-dd"],[Tools dateToString:date1 withDateFormat:@"yyyy-MM-dd"]]};
                        [self.subject sendNext:dic];
                    }
                }
            }
            break;
        }
        case 1:
        {
            if (_pickerVC.date1)
            {
                NSDate *date1 = _pickerVC.date1;
                NSDictionary *dic = @{@"startTime":[NSString stringWithFormat:@"%@ 06:00:00",[Tools dateToString:date1 withDateFormat:@"yyyy-MM-dd"]],
                                      @"endTime":[NSString stringWithFormat:@"%@ 16:00:00",[Tools dateToString:date1 withDateFormat:@"yyyy-MM-dd"]],
                                      @"timeName":[NSString stringWithFormat:@"%@(白班)",[Tools dateToString:date1 withDateFormat:@"yyyy-MM-dd"]]};
                [self.subject sendNext:dic];
            }
            break;
        }
        case 2:
        {
            if (_pickerVC.date1)
            {
                NSDate *date1 = _pickerVC.date1;
                NSDictionary *dic = @{@"startTime":[NSString stringWithFormat:@"%@ 18:00:00",[Tools dateToString:date1 withDateFormat:@"yyyy-MM-dd"]],
                                      @"endTime":[NSString stringWithFormat:@"%@ 06:00:00",[Tools dateToString:date1 withDateFormat:@"yyyy-MM-dd"]],
                                      @"timeName":[NSString stringWithFormat:@"%@(晚班)",[Tools dateToString:date1 withDateFormat:@"yyyy-MM-dd"]]};
                [self.subject sendNext:dic];
            }
            break;
        }
        case 3:
        {
            if (_pickerVC.date1)
            {
                NSDate *date1 = _pickerVC.date1;
                NSDictionary *dic = @{@"startTime":[NSString stringWithFormat:@"%@ 00:00:00",[Tools dateToString:date1 withDateFormat:@"yyyy-MM-dd"]],
                                      @"endTime":[NSString stringWithFormat:@"%@ 23:59:59",[Tools dateToString:date1 withDateFormat:@"yyyy-MM-dd"]],
                                      @"timeName":[NSString stringWithFormat:@"%@(白晚班)",[Tools dateToString:date1 withDateFormat:@"yyyy-MM-dd"]]};
                [self.subject sendNext:dic];
            }
            break;
        }
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)seletedWithIndex:(int)index
{
    if (self.seletedRow == index)
    {
        return;
    }
    self.seletedRow = index;
    [self.pickerVC clearOtherWithisSingle:index != 0];
    for (int i = 0; i < self.labels.count; i++)
    {
        UILabel *label = self.labels[i];
        label.layer.borderColor = [UIColor jk_colorWithHexString:index == i ? COLOR_BLUE : COLOR_LINE].CGColor;
        label.backgroundColor = index == i ?  [UIColor jk_colorWithHexString:COLOR_BLUE] : [UIColor whiteColor];
        label.textColor = index == i ?  [UIColor whiteColor] : [UIColor jk_colorWithHexString:COLOR_242424];
    }
}
@end
