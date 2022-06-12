//
//  GetRequest.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/5/30.
//

#import <Foundation/Foundation.h>
#import "Request.h"
NS_ASSUME_NONNULL_BEGIN

@interface GetRequest : Request
/// GET 请求
/// @param url 网址
/// @param argument 参数
/// @return DDRequest
- (id)initWithRequestUrl:(NSString *)url argument:(NSDictionary *)argument;
@end

NS_ASSUME_NONNULL_END
