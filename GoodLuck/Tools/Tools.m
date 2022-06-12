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

+ (NSString*)getCurrentTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [NSLocale systemLocale];
    formatter.calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierISO8601];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
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
@end
