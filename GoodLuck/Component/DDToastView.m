//
//  DDToastView.m
//  DDGameSDKDemo
//
//  Created by MHJZ on 2022/2/17.
//

#import "DDToastView.h"
@implementation DDToastView
- (void)toastWithMessage:(NSString *)message
{
    UIViewController *superView = [Tools getTopMostController];
    UIView *blackView = [UIView new];
    blackView.backgroundColor = [UIColor jk_colorWithHexString:@"#5d5d5d"];
    blackView.alpha = 0.8;
    [superView.view addSubview:blackView];
    
    UILabel *label = [UILabel new];
    label.text = message;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    [superView.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(superView.view);
    }];
    [label sizeToFit];
    [blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(superView.view);
        make.height.mas_equalTo(label).offset(20);
        make.width.mas_equalTo(label).offset(80);
        make.width.mas_lessThanOrEqualTo(superView.view.bounds.size.width - 60);
    }];
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));

    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.2 animations:^{
            blackView.alpha = 0;
        } completion:^(BOOL finished) {
            [blackView removeFromSuperview];
            [label removeFromSuperview];
        }];
    });
}

- (void)showToastOnWindowWithMessage:(NSString *)message
{
    UIWindow *window = [Tools getCurrentWindow];
    UIView *blackView = [UIView new];
    blackView.backgroundColor = [UIColor jk_colorWithHexString:@"#5d5d5d"];
    blackView.alpha = 0.8;
    [window addSubview:blackView];
    
    UILabel *label = [UILabel new];
    label.text = message;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    [window addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(window);
    }];
    [label sizeToFit];
    [blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(window);
        make.height.mas_equalTo(label).offset(20);
        make.width.mas_equalTo(label).offset(80);
        make.width.mas_lessThanOrEqualTo(window.bounds.size.width - 60);
    }];
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));

    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.2 animations:^{
            blackView.alpha = 0;
        } completion:^(BOOL finished) {
            [blackView removeFromSuperview];
            [label removeFromSuperview];
        }];
    });
}
@end
