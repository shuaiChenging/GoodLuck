//
//  InfoInputRightCompent.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InfoInputRightCompent : UIView
@property (nonatomic, strong) GLTextField *textField;
- (void)setName:(NSString *)name placeholder:(NSString *)placehodler;
@end

NS_ASSUME_NONNULL_END
