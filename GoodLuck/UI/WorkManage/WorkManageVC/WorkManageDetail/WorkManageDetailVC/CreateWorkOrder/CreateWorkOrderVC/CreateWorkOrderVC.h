//
//  CreateWorkOrderVC.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/17.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface CreateWorkOrderVC : BaseVC
@property (nonatomic, copy) RACSubject *subject;
@property (nonatomic, copy) NSString *projectId;
@property (nonatomic, copy) NSString *carName;
@property (nonatomic, strong) UIImage *carImage;
@end

NS_ASSUME_NONNULL_END
