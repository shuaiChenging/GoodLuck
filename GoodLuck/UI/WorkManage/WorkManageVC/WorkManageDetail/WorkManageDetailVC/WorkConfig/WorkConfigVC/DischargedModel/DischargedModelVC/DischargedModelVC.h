//
//  DischargedModelVC.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/19.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DischargedModelVC : BaseVC
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) RACSubject *subject;
@end

NS_ASSUME_NONNULL_END
