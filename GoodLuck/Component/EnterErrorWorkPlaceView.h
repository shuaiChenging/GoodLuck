//
//  EnterErrorWorkPlaceView.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EnterErrorWorkPlaceView : UIView

@property (nonatomic, strong) RACSubject *subject;

- (void)setPlaceWithName:(NSString *)name distance:(NSString *)distance;
@end

NS_ASSUME_NONNULL_END
