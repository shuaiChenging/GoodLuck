//
//  WorkOrderResponse.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/14.
//

#import "BaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface WorkOrderResponse : BaseResponse
@property (nonatomic, copy) NSString *allCount;
@property (nonatomic, copy) NSString *ztcCount;
@property (nonatomic, copy) NSString *zdCount;
@property (nonatomic, copy) NSString *exceptionCount;
@property (nonatomic, copy) NSString *delCount;
@property (nonatomic, copy) NSString *historyCount;
@end

NS_ASSUME_NONNULL_END
