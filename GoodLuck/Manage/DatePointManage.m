//
//  DatePointManage.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/8/22.
//

#import "DatePointManage.h"
#import "DatePointModel.h"
@implementation DatePointManage
+ (instancetype)shareInstance
{
    static DatePointManage * _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[DatePointManage alloc] init];
    });
    
    return _sharedInstance;
}

- (void)getPointDate:(NSString *)projectId
{
    NSCalendar *gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDate *yesterDay = [gregorian dateByAddingUnit:NSCalendarUnitYear value:-1 toDate:[NSDate date] options:0];
    NSString *startTime = [NSString stringWithFormat:@"%@ 00:00:00",[Tools dateToString:yesterDay withDateFormat:@"yyyy-MM-dd"]];
    NSString *endTime = [Tools getCurrentTime];
    WeakSelf(self)
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:everydaystatistice argument:@{@"projectId":projectId,@"startTime":startTime,@"endTime":endTime}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            NSArray<DatePointModel *> *arr = [DatePointModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
            weakself.dateArr = [[arr.rac_sequence map:^id _Nullable(DatePointModel * _Nullable value) {
                return value.date;
            }] array];
            
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}
@end
