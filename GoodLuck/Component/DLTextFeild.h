//
//  DLTextFeild.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/5/31.
//

#import <UIKit/UIKit.h>
#import "DLButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface DLTextFeild : UIView
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) DLButton *sendCode;
- (instancetype)initWithType:(TextFeildType)type;
@end

NS_ASSUME_NONNULL_END
