//
//  ChangeCarNoView.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChangeCarNoView : UIView
@property (nonatomic, strong) RACSubject *subject;
@property (nonatomic, strong) RACSubject *buttonSubject;
@property (nonatomic, strong) RACSubject *cancelSubject;
- (void)loadViewWithCarNo:(NSString *)carNo image:(UIImage *)image;
- (void)setCurrentLb:(NSString *)name back:(BOOL)back;
- (void)recoverState;
@end

NS_ASSUME_NONNULL_END
