//
//  RegistView.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/4.
//

#import "BaseView.h"
#import "DLTextFeild.h"
#import "DLButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface RegisterView : BaseView
@property (nonatomic, strong) DLTextFeild *accountTF;
@property (nonatomic, strong) DLTextFeild *codeTF;
@property (nonatomic, strong) DLTextFeild *passwordTF;
@property (nonatomic, strong) DLTextFeild *rePasswordTF;
@property (nonatomic, strong) DLButton *button;
@property (nonatomic, strong) UILabel *phoneLoginLb;
@end

NS_ASSUME_NONNULL_END
