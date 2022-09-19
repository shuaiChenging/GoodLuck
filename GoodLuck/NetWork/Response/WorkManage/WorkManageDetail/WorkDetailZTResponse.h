//
//  WorkDetailZTResponse.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/9.
//

#import "BaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface WorkDetailZTItem : BaseResponse
@property (nonatomic, assign) long zdCount;
@property (nonatomic, assign) long ztcCount;
@end

@interface WorkztcModel : BaseResponse
@property (nonatomic, strong) NSArray *plateNumberMap;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *totalCount;
@end

@interface WorkDetailZTResponse : BaseResponse
@property (nonatomic, copy) NSString *zdCount;
@property (nonatomic, copy) NSString *ztcCount;
@property (nonatomic, strong) NSArray *details;
@property (nonatomic, strong) NSArray *ztcDetails;
@property (nonatomic, strong) NSArray *totalDetails;

@property (nonatomic, strong) NSArray *ztArr;
@property (nonatomic, strong) NSArray *zdArr;
@property (nonatomic, strong) NSArray *yArr;
@property (nonatomic, assign) long maxCount;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray *plateNumberMap;

@property (nonatomic, strong) NSArray *ztcPlateNumberMap;
@end

NS_ASSUME_NONNULL_END
