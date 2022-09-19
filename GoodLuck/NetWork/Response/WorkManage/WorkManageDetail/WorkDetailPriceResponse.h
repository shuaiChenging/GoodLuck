//
//  WorkDetailPriceResponse.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/8.
//

#import "BaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface WorkDetailPriceResponse : BaseResponse
@property (nonatomic, copy) NSString *bodySize;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *projectId;
@property (nonatomic, copy) NSString *tlxId;
@property (nonatomic, copy) NSString *tlxName;
@property (nonatomic, copy) NSString *ztcId;
@property (nonatomic, copy) NSString *ztcName;
@end

@interface WorkDetailPrceHeaderResponse : BaseResponse
@property (nonatomic, copy) NSString *headerName;
@property (nonatomic, copy) NSString *soilType;
@property (nonatomic, copy) NSString *footerName;
@property (nonatomic, strong) NSMutableArray *contentDatas;
@end

NS_ASSUME_NONNULL_END
