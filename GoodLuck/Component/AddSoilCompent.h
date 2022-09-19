//
//  AddSoilCompent.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/13.
//

#import <UIKit/UIKit.h>
#import "CarSizeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AddSoilCompent : UIView
@property (nonatomic, strong) RACSubject *closeSubject;
@property (nonatomic, strong) RACSubject *subject;
- (void)loadViewWithArray:(NSArray<CarSizeModel *> *)array name:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
