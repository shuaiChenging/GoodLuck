//
//  WorkConfigManageResponse.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/11.
//

#import "BaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface WorkConfigManageResponse : BaseResponse
@property (nonatomic, copy) NSString *workId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *projectId;
@property (nonatomic, assign) BOOL isSelected;
@end

NS_ASSUME_NONNULL_END
