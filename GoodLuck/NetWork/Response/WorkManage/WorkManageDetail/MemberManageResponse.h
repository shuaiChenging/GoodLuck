//
//  MemberManageResponse.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/8.
//

#import "BaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface MemberManageResponse : BaseResponse
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *nameId;
@end

@interface MemberHeaderResponse : BaseResponse
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *describe;
- (instancetype)initWithName:(NSString *)name describe:(NSString *)describe;
@end

@interface ManageResponse : BaseResponse
@property (nonatomic, strong) MemberHeaderResponse *header;
@property (nonatomic, strong) NSArray *content;
@end

NS_ASSUME_NONNULL_END
