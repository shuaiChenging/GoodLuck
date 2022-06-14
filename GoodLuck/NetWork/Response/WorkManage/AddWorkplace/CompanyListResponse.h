//
//  CompanyListResponse.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/8.
//

#import "BaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface CompanyListResponse : BaseResponse
@property (nonatomic, copy) NSString *companyId;
@property (nonatomic, copy) NSString *name;
@end

NS_ASSUME_NONNULL_END
