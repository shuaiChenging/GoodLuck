//
//  InfoInputMiddleCompent.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InfoInputMiddleCompent : UIView
@property (nonatomic, strong) UIImageView *rightImg;
@property (nonatomic, strong) UITextField *textField;
- (void)setName:(NSString *)name
    placeholder:(NSString *)placehodler
      imageName:(nullable NSString *)imageName;
@end

NS_ASSUME_NONNULL_END
