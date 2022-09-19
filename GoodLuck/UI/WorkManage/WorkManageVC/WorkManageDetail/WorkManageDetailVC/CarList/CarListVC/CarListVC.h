//
//  CarListVC.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/25.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface CarListVC : BaseVC
@property (nonatomic, strong) RACSubject *subject;
@property (nonatomic, copy) NSString *projectId;
@property (nonatomic, copy) NSString *workerId;
@end

NS_ASSUME_NONNULL_END
