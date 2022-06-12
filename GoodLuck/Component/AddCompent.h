//
//  AddCompent.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddCompent : UIView
@property (nonatomic, strong) RACSubject *subject;
@property (nonatomic, strong) RACSubject *cancelSubject;
- (void)loadViewWithTitle:(NSString *)title placeholder:(NSString *)placeholder;
@end

NS_ASSUME_NONNULL_END
