//
//  DeleteAlertCompent.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeleteAlertCompent : UIView
@property (nonatomic, strong) RACSubject *subject;
- (void)loadView:(NSString *)time carNo:(NSString *)carNo admin:(NSString *)admin;
@end

NS_ASSUME_NONNULL_END
