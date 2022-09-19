//
//  DateSeletedCompent.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DateSeletedCompent : UIView

@property (nonatomic, strong) RACSubject *subject;
- (void)loadWithType:(DataSeletedType )type;

@end

NS_ASSUME_NONNULL_END
