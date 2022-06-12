//
//  AccountLoginVM.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/3.
//

#import <Foundation/Foundation.h>
#import "BaseVM.h"
NS_ASSUME_NONNULL_BEGIN

@interface AccountLoginVM : BaseVM
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, strong) RACSignal *btnEnableSignal;
@property (nonatomic, strong) RACCommand *loginCommand;
@end

NS_ASSUME_NONNULL_END
