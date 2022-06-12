//
//  PhoneLoginView.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/5/31.
//

#import "BaseView.h"
#import "DLTextFeild.h"
#import "DLButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface PhoneLoginView : BaseView
@property (nonatomic, strong) DLTextFeild *accountTF;
@property (nonatomic, strong) DLTextFeild *codeTF;
@property (nonatomic, strong) DLButton *button;
@property (nonatomic, strong) UILabel *accountLoginLb;
@property (nonatomic, strong) UILabel *registLb;
@end

NS_ASSUME_NONNULL_END
