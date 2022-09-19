//
//  CarNoCompent.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CarNoCompent : UIView
@property (nonatomic, strong) RACSubject *subject;
@property (nonatomic, strong) RACSubject *buttonSubject;
@end

NS_ASSUME_NONNULL_END
