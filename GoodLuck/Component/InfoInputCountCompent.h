//
//  InfoInputCountCompent.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InfoInputCountCompent : UIView
@property (nonatomic, strong) UITextField *textField;
- (void)setName:(NSString *)name placeholder:(NSString *)placehodler;
@end

NS_ASSUME_NONNULL_END
