//
//  BossListResponse.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/14.
//

#import "BaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface BossListResponse : BaseResponse
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *projectId;
@property (nonatomic, assign) BOOL isSeleted;
@end

NS_ASSUME_NONNULL_END
