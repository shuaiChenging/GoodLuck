//
//  PrintNumberModel.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PrintNumberModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL isSelected;

- (instancetype)initWithName:(NSString *)name
                  isSelected:(BOOL)isSelected;
@end

NS_ASSUME_NONNULL_END
