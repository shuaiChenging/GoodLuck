//
//  RoleModel.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RoleModel : NSObject
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL isSeleted;
@end

NS_ASSUME_NONNULL_END
