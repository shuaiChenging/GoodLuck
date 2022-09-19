//
//  CarSizeModel.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CarSizeModel : NSObject
@property (nonatomic, assign) BOOL isSeleted;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *size;
- (instancetype)initWithName:(NSString *)name isSeleted:(BOOL)isSeleted size:(NSString *)size;
@end

NS_ASSUME_NONNULL_END
