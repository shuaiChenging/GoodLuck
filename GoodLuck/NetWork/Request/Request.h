//
//  Request.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/5/30.
//

#import <Foundation/Foundation.h>
#import "YTKRequest.h"
NS_ASSUME_NONNULL_BEGIN
@class Request;

typedef void(^RequestCompletionBlock)(__kindof Request *request, NSDictionary *result, BOOL success);

typedef void(^RequestCompletionFailureBlock)(__kindof Request *request, NSString *errorInfo);

@interface Request : YTKRequest
/// 请求URL地址
@property (nonatomic, copy) NSString *requestUrl;

/// 请求参数
@property (nonatomic, strong) id requestArgument;

/// 错误提示
@property (nonatomic, copy) NSString *errorInfo;

/// 请求类型
@property (nonatomic, assign) YTKRequestSerializerType requestSerializerType;

/// 是否校验json数据格式，默认YES
@property (nonatomic, assign) BOOL verifyJSONFormat;

/// 开始请求数据
/// @param success 成功回调
/// @param failure 失败回调，返回error信息
- (void)startWithCompletionBlockWithSuccess:(nullable RequestCompletionBlock)success
                                    failure:(nullable RequestCompletionFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
