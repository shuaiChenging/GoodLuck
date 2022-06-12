//
//  WorkDetailResponse.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/8.
//

#import "BaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface WorkDetailResponse : BaseResponse
@property (nonatomic, copy) NSString *projectId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *district;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *companyId;
@property (nonatomic, copy) NSString *companyName;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *deleteFlag;
@property (nonatomic, copy) NSString *createBy;
@property (nonatomic, copy) NSString *created;
@property (nonatomic, copy) NSString *updateBy;
@property (nonatomic, copy) NSString *updated;
@end

NS_ASSUME_NONNULL_END
