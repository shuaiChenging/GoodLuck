//
//  DischargedModelModel.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DischargedModelModel : NSObject
@property (nonatomic, copy) NSString *item;
@property (nonatomic, copy) NSString *describe;
@property (nonatomic, assign) BOOL isSeleted;
- (instancetype)initWithItem:(NSString *)item describe:(NSString *)describe isSeleted:(BOOL)isSeleted;
@end

NS_ASSUME_NONNULL_END
