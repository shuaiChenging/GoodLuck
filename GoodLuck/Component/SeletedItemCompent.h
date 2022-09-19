//
//  SeletedItemCompent.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SeletedItemCompent : UIView
@property (nonatomic, strong) RACSubject *subject;
- (instancetype)initWithArray:(NSArray *)array;
- (instancetype)initScrollWithArray:(NSArray *)array;
- (instancetype)initDetailScrollWithArray:(NSArray *)array;
- (void)seletedHandle:(int)index;
@end

NS_ASSUME_NONNULL_END
