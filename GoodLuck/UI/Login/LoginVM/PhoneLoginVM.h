//
//  PhoneLoginVM.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/3.
//

#import <Foundation/Foundation.h>
#import "BaseVM.h"
NS_ASSUME_NONNULL_BEGIN

@interface PhoneLoginVM : BaseVM
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, strong) RACSignal *btnEnableSignal;
@property (nonatomic, strong) RACCommand *loginCommand;
@property (nonatomic, strong) RACCommand *sendCodeCommand;
@end

NS_ASSUME_NONNULL_END
