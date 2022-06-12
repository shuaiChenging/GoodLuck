//
//  RegistVM.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegisterVM : NSObject
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *setPassword;
@property (nonatomic, copy) NSString *reSetPassword;
@property (nonatomic, strong) RACSignal *btnEnableSignal;
@property (nonatomic, strong) RACCommand *loginCommand;
@property (nonatomic, strong) RACCommand *sendCodeCommand;
@end

NS_ASSUME_NONNULL_END
