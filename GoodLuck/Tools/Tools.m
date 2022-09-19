//
//  Tools.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/6.
//

#import "Tools.h"
#import "DDToastView.h"
#import "AppDelegate.h"
#import "AddCompent.h"
#import "EnterErrorWorkPlaceView.h"
#import "LoginInfoManage.h"
#import "PersonalCenterResponse.h"
#import "SeletedWorkTypeCompent.h"
#import "AlertCompent.h"
#import "DeleteAlertCompent.h"
#import <PrinterSDK/PrinterSDK.h>
#import "ChangeCarNoView.h"
#import "ProvinceCompent.h"
#import "CarNoCompent.h"
#import "AddSoilCompent.h"

@implementation Tools
+ (void)showToast:(NSString *)str
{
    if ([Tools isEmpty:str])
    {
        return;
    }
    DDToastView *toastView = [DDToastView new];
    [toastView showToastOnWindowWithMessage:str];
}

+ (BOOL)isEmpty:(NSString *)str
{
    if(!str)
    {
        return true;
    }
    else
    {
        NSCharacterSet *set=[NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString=[str stringByTrimmingCharactersInSet:set];
        if([trimedString length] == 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
}

+ (UIWindow *)getCurrentWindow
{
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for(UIWindow *window in [windows reverseObjectEnumerator])
    {
        if ([window isKindOfClass:[UIWindow class]] &&
            window.windowLevel == UIWindowLevelNormal &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
        {
            return window;
        }
    }
    return [UIApplication sharedApplication].keyWindow;
}

+ (NSString *)getCurrentTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [NSLocale systemLocale];
    formatter.calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierISO8601];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
}

+ (NSString *)getCurrentDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [NSLocale systemLocale];
    formatter.calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierISO8601];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
}

+ (UIViewController *)getTopMostController
{
    UIViewController* currentViewController = [self returnWindowWithWindowLevelNormal];
    BOOL runLoopFind = YES;
    while (runLoopFind)
    {
        if (currentViewController.presentedViewController)
        {
            currentViewController = currentViewController.presentedViewController;
        }
        else if ([currentViewController isKindOfClass:[UINavigationController class]])
        {
            UINavigationController* navigationController = (UINavigationController* )currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];
            
        }
        else if ([currentViewController isKindOfClass:[UITabBarController class]])
        {
            UITabBarController* tabBarController = (UITabBarController* )currentViewController;
            currentViewController = tabBarController.selectedViewController;
        }
        else
        {
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0)
            {
                currentViewController = currentViewController.childViewControllers.lastObject;
                return currentViewController;
            }
            else
            {
                return currentViewController;
            }
        }
        
    }
    return currentViewController;
}

+ (UIViewController *)returnWindowWithWindowLevelNormal
{
    UIWindow* window = [self getCurrentWindow];
    NSAssert(window, @"The window is empty");
    return window.rootViewController;
}

+ (void)logout
{
    [DDDataStorageManage userDefaultsSaveObject:@"" forKey:TOKENKEY];
    [[[UIApplication sharedApplication] delegate] performSelector:@selector(loginMainView)];
}

+ (void)addViewWithTitle:(NSString *)title
             placeholder:(NSString *)placeholder
                textback:(AddCompentBack)back
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *blackViiew = [UIView new];
    blackViiew.backgroundColor = [UIColor blackColor];
    blackViiew.alpha = 0.6;
    [window addSubview:blackViiew];
    [blackViiew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(window);
    }];
    
    AddCompent *addCompent = [AddCompent new];
    [addCompent loadViewWithTitle:title placeholder:placeholder];
    [addCompent.subject subscribeNext:^(id  _Nullable x) {
        [blackViiew removeFromSuperview];
        if (back)
        {
            back((NSString *)x);
        }
    }];
    [addCompent.cancelSubject subscribeNext:^(id  _Nullable x) {
        [blackViiew removeFromSuperview];
    }];
    [window addSubview:addCompent];
    [addCompent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(window);
        make.left.equalTo(window).offset(36);
        make.right.equalTo(window).offset(-36);
    }];
    
}

+ (NSMutableArray *)cutArry:(int)number array:(NSArray *)array
{
    NSMutableArray *resultArr = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *newArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < array.count; i++)
    {
        if ((i + 1) % number == 0)
        {
            [newArray addObject:array[i]];
            [resultArr addObject:newArray];
            newArray = [NSMutableArray arrayWithCapacity:0];
        }
        else
        {
            [newArray addObject:array[i]];
        }
        if ((i == array.count - 1 && newArray.count > 0))
        {
            [resultArr addObject:newArray];
        }
    }
    return resultArr;
}

+ (void)showCancelAlert:(NSString *)time carNo:(NSString *)carNo admin:(NSString *)admin block:(void (^)(NSString *))block
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *blackView = [UIView new];
    blackView.backgroundColor = [UIColor blackColor];
    blackView.alpha = 0.6;
    [window addSubview:blackView];
    [blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(window);
    }];
    DeleteAlertCompent *deleteAlertComoent = [DeleteAlertCompent new];
    [deleteAlertComoent.subject subscribeNext:^(id  _Nullable x) {
        if ([x isKindOfClass:NSString.class])
        {
            block(x);
        }
        [blackView removeFromSuperview];
    }];
    [deleteAlertComoent loadView:time carNo:carNo admin:admin];
    [window addSubview:deleteAlertComoent];
    [deleteAlertComoent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(window).offset(20);
        make.right.equalTo(window).offset(-20);
        make.center.equalTo(window);
    }];
    
}

+ (void)showSeletedWokrType:(void (^)(NSString *))block
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIView *view = [window viewWithTag:1000088];
    if (view)
    {
        return;
    }
    
    UIView *blackView = [UIView new];
    blackView.backgroundColor = [UIColor blackColor];
    blackView.alpha = 0.6;
    [window addSubview:blackView];
    [blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(window);
    }];
    
    SeletedWorkTypeCompent *compent = [SeletedWorkTypeCompent new];
    compent.tag = 1000088;
    [compent.subject subscribeNext:^(id  _Nullable x) {
        NSString *result = (NSString *)x;
        if ([result isEqualToString:@"1"])
        {
            block(@"DAY_WORK");
        }
        else if ([result isEqualToString:@"2"])
        {
            block(@"NIGHT_WORK");
        }
        [blackView removeFromSuperview];
    }];
    [window addSubview:compent];
    [compent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(window).offset(20);
        make.right.equalTo(window).offset(-20);
        make.center.equalTo(window);
        make.height.equalTo(280);
    }];
}

+ (NSString *)dateToString:(NSDate *)date withDateFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

+ (void)showAlertWithTitle:(NSString *)titleStr
                   content:(NSString *)contentStr
                      left:(NSString *)leftStr
                     right:(NSString *)rightStr
                     block:(void (^)(void))block
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *blackView = [UIView new];
    blackView.backgroundColor = [UIColor blackColor];
    blackView.alpha = 0.6;
    [window addSubview:blackView];
    [blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(window);
    }];
    
    AlertCompent *alertCompent = [AlertCompent new];
    [alertCompent loadViewWithTitle:titleStr content:contentStr left:leftStr right:rightStr];
    [alertCompent.subject subscribeNext:^(id  _Nullable x) {
        NSString *result = (NSString *)x;
        if ([result isEqualToString:@"2"])
        {
            block();
        }
        [blackView removeFromSuperview];
    }];
    [window addSubview:alertCompent];
    [alertCompent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(window).offset(20);
        make.right.equalTo(window).offset(-20);
        make.center.equalTo(window);
    }];
}

+ (void)showCarNoChangeView:(NSString *)carNo image:(UIImage *)image
                     rescan:(void (^)(void))recan
                       sure:(void (^)(NSString *))sure
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *blackView = [UIView new];
    blackView.backgroundColor = [UIColor blackColor];
    blackView.alpha = 0.6;
    [window addSubview:blackView];
    [blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(window);
    }];
    
    ChangeCarNoView *changeCarNoView = [ChangeCarNoView new];
    
    ProvinceCompent *provinceCompent = [ProvinceCompent new];
    provinceCompent.hidden = YES;
    [provinceCompent.subject subscribeNext:^(id  _Nullable x) {
        [changeCarNoView setCurrentLb:x back:NO];
    }];
    [provinceCompent.buttonSubject subscribeNext:^(id  _Nullable x) {
        if ([x isEqualToString:@"2"])
        {
            [changeCarNoView setCurrentLb:@"" back:YES];
        }
        else
        {
            [changeCarNoView recoverState];
        }
    }];
    [window addSubview:provinceCompent];
    [provinceCompent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(window);
    }];
    
    CarNoCompent *carNoCompent = [CarNoCompent new];
    carNoCompent.hidden = YES;
    [carNoCompent.subject subscribeNext:^(id  _Nullable x) {
        [changeCarNoView setCurrentLb:x back:NO];
    }];
    [carNoCompent.buttonSubject subscribeNext:^(id  _Nullable x) {
        if ([x isEqualToString:@"2"])
        {
            [changeCarNoView setCurrentLb:@"" back:YES];
        }
        else
        {
            [changeCarNoView recoverState];
        }
    }];
    [window addSubview:carNoCompent];
    [carNoCompent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(window);
    }];
    
    [changeCarNoView loadViewWithCarNo:carNo image:image];
    [changeCarNoView.subject subscribeNext:^(id  _Nullable x) {
        int row = [x intValue];
        provinceCompent.hidden = row != 0;
        carNoCompent.hidden = row == 0;
    }];
    [changeCarNoView.cancelSubject subscribeNext:^(id  _Nullable x) {
        [blackView removeFromSuperview];
        [carNoCompent removeFromSuperview];
        [provinceCompent removeFromSuperview];
    }];
    [changeCarNoView.buttonSubject subscribeNext:^(id  _Nullable x) {
        if ([x isEqualToString:@"1"])
        {
            recan();
        }
        else
        {
            sure(x);
        }
        [blackView removeFromSuperview];
        [carNoCompent removeFromSuperview];
        [provinceCompent removeFromSuperview];
    }];
    [window addSubview:changeCarNoView];
    [changeCarNoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(window).offset(20);
        make.right.equalTo(window).offset(-20);
        make.center.equalTo(window);
    }];
}

+ (void)showAddSoilCompent:(NSArray<CarSizeModel *> *)array name:(NSString *)name back:(void (^)(NSString *))back
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *blackView = [UIView new];
    blackView.backgroundColor = [UIColor blackColor];
    blackView.alpha = 0.6;
    [window addSubview:blackView];
    [blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(window);
    }];
    AddSoilCompent *compent = [AddSoilCompent new];
    [compent.subject subscribeNext:^(id  _Nullable x) {
        back(x);
        [blackView removeFromSuperview];
    }];
    [compent.closeSubject subscribeNext:^(id  _Nullable x) {
        [blackView removeFromSuperview];
    }];
    
    [compent loadViewWithArray:array name:name];
    [window addSubview:compent];
    [compent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(window).offset(20);
        make.right.equalTo(window).offset(-20);
        make.center.equalTo(window);
    }];
}

+ (void)showErrorWorkPlace:(NSString *)workPlace distance:(NSString *)distance block:(void (^)(NSString *))block
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIView *view = [window viewWithTag:1000086];
    if (view)
    {
        return;
    }
    
    UIView *blackView = [UIView new];
    blackView.backgroundColor = [UIColor blackColor];
    blackView.alpha = 0.6;
    [window addSubview:blackView];
    [blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(window);
    }];
    
    EnterErrorWorkPlaceView *enterErrorWorkPlaceView = [EnterErrorWorkPlaceView new];
    enterErrorWorkPlaceView.tag = 1000086;
    [enterErrorWorkPlaceView.subject subscribeNext:^(id  _Nullable x) {
        [blackView removeFromSuperview];
        block(x);
    }];
    [enterErrorWorkPlaceView setPlaceWithName:workPlace distance:distance];
    [window addSubview:enterErrorWorkPlaceView];
    [enterErrorWorkPlaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(window).offset(20);
        make.right.equalTo(window).offset(-20);
        make.center.equalTo(window);
    }];
}

+ (NSDate *)stringTodate:(NSString *)string
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    return [formatter dateFromString:string];
}

+ (NSString *)getNowTimeStamp
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *dateNow = [NSDate date];
    NSString *timeStamp = [NSString stringWithFormat:@"%ld", (long)[dateNow timeIntervalSince1970]];
    return timeStamp;
}

+ (NSString *)getAppVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return version;
}

+ (void)getUserInfo
{
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:userinfo argument:@{}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            PersonalCenterResponse *respose = [PersonalCenterResponse mj_objectWithKeyValues:result[@"data"]];
            [LoginInfoManage shareInstance].personalResponse = respose;
            [DDDataStorageManage userDefaultsSaveObject:@{@"name":respose.name,
                                                          @"phone":respose.phone,
                                                          @"approveStatus":respose.approveStatus,
                                                          @"tenantId":respose.tenantId} forKey:INFOKEY];
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

+ (void)printWithProjectName:(NSString *)projectName
                  codeString:(NSString *)codeString
                       carNo:(NSString *)carNo
                     company:(NSString *)company
                     orderNo:(NSString *)orderNo
                     soilWay:(NSString *)soilWay
                       ztWay:(NSString *)ztWay
                 carTeamName:(NSString *)carTeamName
                   outPeople:(NSString *)outPeople
                     classNo:(NSString *)classNo
                     outTime:(NSString *)outTime
                   printTime:(NSString *)printTime
                       count:(int)count
                       price:(NSString *)price
                 isShowPrice:(BOOL)isShowPrice
{
    NSInteger fontSize = 25; /// 字体大小 24
    NSInteger differHeight = 38; /// 相差高度 36
    NSInteger topHeight = 120; /// 第一行字的高度 90
    /// 高度相差 36
    PTCommandZPL *cmd = [[PTCommandZPL alloc] init];
    
    [cmd XA_FormatStart];
    [cmd PQ_PrintQuantity:1];
    
    /// 高度加2
    
    //连续纸需要设置标签长度，标签纸可不用
    [cmd LL_LabelLength:650]; /// 600
    [cmd PW_PrintWidth:700];
    
    [cmd A_SetFontWithOrientation:PTZplOrientation_N height:20 width:20 location:PTZplFileLocation_E];
    [cmd CI_ChangeInternationalCharacterSet:@"14"];
    [cmd FO_FieldOriginWithXAxis:0 YAxis:0];
    [cmd FD_FieldData:@"好运来监制"];
    [cmd FS_FieldSeparator];
    
    [cmd A_SetFontWithOrientation:PTZplOrientation_N height:32 width:32 location:PTZplFileLocation_E];
    [cmd CI_ChangeInternationalCharacterSet:@"14"];
    [cmd FO_FieldOriginWithXAxis:200 YAxis:64];
    [cmd FD_FieldData:projectName];
    [cmd FS_FieldSeparator];
    
    //b0 二维码
    [cmd FO_FieldOriginWithXAxis:0 YAxis:topHeight];
    [cmd BQ_BarcodeQRcodeWithOrientation:PTZplOrientation_R model:PTZplQrModel_1 magnification:5 reliabilityLevel:PTZplQrReliabilityLevel_H];
    [cmd FD_FieldData:codeString];
    [cmd FS_FieldSeparator];
    
    [cmd A_SetFontWithOrientation:PTZplOrientation_N height:fontSize width:fontSize location:PTZplFileLocation_E];
    [cmd CI_ChangeInternationalCharacterSet:@"14"];
    [cmd FO_FieldOriginWithXAxis:122 YAxis:topHeight];
    [cmd FD_FieldData:@"车牌："];
    [cmd FS_FieldSeparator];
    
    [cmd A_SetFontWithOrientation:PTZplOrientation_N height:32 width:32 location:PTZplFileLocation_E];
    [cmd CI_ChangeInternationalCharacterSet:@"14"];
    [cmd FO_FieldOriginWithXAxis:190 YAxis:114];
    [cmd FD_FieldData:carNo];
    [cmd FS_FieldSeparator];
    
    [cmd A_SetFontWithOrientation:PTZplOrientation_N height:fontSize width:fontSize location:PTZplFileLocation_E];
    [cmd CI_ChangeInternationalCharacterSet:@"14"];
    [cmd FO_FieldOriginWithXAxis:122 YAxis:(topHeight + differHeight*1)];
    [cmd FD_FieldData:[NSString stringWithFormat:@"土方单位：%@",company]];
    [cmd FS_FieldSeparator];
    
    [cmd A_SetFontWithOrientation:PTZplOrientation_N height:fontSize width:fontSize location:PTZplFileLocation_E];
    [cmd CI_ChangeInternationalCharacterSet:@"14"];
    [cmd FO_FieldOriginWithXAxis:120 YAxis:(topHeight + differHeight*2)];
    [cmd FD_FieldData:[NSString stringWithFormat:@"工单：%@",orderNo]];
    [cmd FS_FieldSeparator];
    
    [cmd A_SetFontWithOrientation:PTZplOrientation_N height:fontSize width:fontSize location:PTZplFileLocation_E];
    [cmd CI_ChangeInternationalCharacterSet:@"14"];
    [cmd FO_FieldOriginWithXAxis:0 YAxis:(topHeight + differHeight*3)];
    [cmd FD_FieldData:[NSString stringWithFormat:@"倒土方式：%@",soilWay]];
    [cmd FS_FieldSeparator];
    
    [cmd A_SetFontWithOrientation:PTZplOrientation_N height:fontSize width:fontSize location:PTZplFileLocation_E];
    [cmd CI_ChangeInternationalCharacterSet:@"14"];
    [cmd FO_FieldOriginWithXAxis:0 YAxis:(topHeight + differHeight*4)];
    [cmd FD_FieldData:[NSString stringWithFormat:@"渣土类型：%@",ztWay]];
    [cmd FS_FieldSeparator];
    
    [cmd A_SetFontWithOrientation:PTZplOrientation_N height:fontSize width:fontSize location:PTZplFileLocation_E];
    [cmd CI_ChangeInternationalCharacterSet:@"14"];
    [cmd FO_FieldOriginWithXAxis:0 YAxis:(topHeight + differHeight*5)];
    [cmd FD_FieldData:[NSString stringWithFormat:@"车队名称：%@",carTeamName]];
    [cmd FS_FieldSeparator];
    
    [cmd A_SetFontWithOrientation:PTZplOrientation_N height:fontSize width:fontSize location:PTZplFileLocation_E];
    [cmd CI_ChangeInternationalCharacterSet:@"14"];
    [cmd FO_FieldOriginWithXAxis:0 YAxis:(topHeight + differHeight*6)];
    [cmd FD_FieldData:[NSString stringWithFormat:@"放行人员：%@",outPeople]];
    [cmd FS_FieldSeparator];
    
    if (isShowPrice)
    {
        [cmd A_SetFontWithOrientation:PTZplOrientation_N height:fontSize width:fontSize location:PTZplFileLocation_E];
        [cmd CI_ChangeInternationalCharacterSet:@"14"];
        [cmd FO_FieldOriginWithXAxis:0 YAxis:(topHeight + differHeight*7)];
        [cmd FD_FieldData:[NSString stringWithFormat:@"价       格：%@",price]];
        [cmd FS_FieldSeparator];
    }
    
    [cmd A_SetFontWithOrientation:PTZplOrientation_N height:fontSize width:fontSize location:PTZplFileLocation_E];
    [cmd CI_ChangeInternationalCharacterSet:@"14"];
    [cmd FO_FieldOriginWithXAxis:0 YAxis:isShowPrice? (topHeight + differHeight*8) : (topHeight + differHeight*7)];
    [cmd FD_FieldData:[NSString stringWithFormat:@"班       次：%@",classNo]];
    [cmd FS_FieldSeparator];
    
    [cmd A_SetFontWithOrientation:PTZplOrientation_N height:fontSize width:fontSize location:PTZplFileLocation_E];
    [cmd CI_ChangeInternationalCharacterSet:@"14"];
    [cmd FO_FieldOriginWithXAxis:0 YAxis:isShowPrice? (topHeight + differHeight*9) : (topHeight + differHeight*8)];
    [cmd FD_FieldData:[NSString stringWithFormat:@"出场时间：%@",outTime]];
    [cmd FS_FieldSeparator];
    
    [cmd A_SetFontWithOrientation:PTZplOrientation_N height:fontSize width:fontSize location:PTZplFileLocation_E];
    [cmd CI_ChangeInternationalCharacterSet:@"14"];
    [cmd FO_FieldOriginWithXAxis:0 YAxis:isShowPrice? (topHeight + differHeight*10) : (topHeight + differHeight*9)];
    [cmd FD_FieldData:[NSString stringWithFormat:@"打印时间：%@",printTime]];
    [cmd FS_FieldSeparator];
    
    [cmd A_SetFontWithOrientation:PTZplOrientation_N height:22 width:22 location:PTZplFileLocation_E];
    [cmd CI_ChangeInternationalCharacterSet:@"14"];
    [cmd FO_FieldOriginWithXAxis:0 YAxis:isShowPrice? (topHeight + differHeight*11) : (topHeight + differHeight*10)];
    [cmd FD_FieldData:[NSString stringWithFormat:@"第%d联(电子联单)",count]];
    [cmd FS_FieldSeparator];
    
    [cmd XZ_FormatEnd];
    
    [SVProgressHUD show];
    [[PTDispatcher share] sendData:cmd.cmdData];
    /// 这个只是数据发送成功 不是打印成功
    [[PTDispatcher share] whenSendSuccess:^(int64_t dataCount, double time) {
        [SVProgressHUD showSuccessWithStatus:@"数据发送成功"];
    }];
    
    [[PTDispatcher share] whenSendProgressUpdate:^(NSNumber *number) {
        [SVProgressHUD showProgress:number.floatValue];
    }];
    
    /// 实现不处理
    [[PTDispatcher share] whenReceiveData:^(NSData *data) {
        
    }];
    
    [[PTDispatcher share] whenSendFailure:^{
        [SVProgressHUD showErrorWithStatus:@"数据发送失败"];
    }];
}

@end
