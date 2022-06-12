//
//  PostRequest.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/5/30.
//

#import <Foundation/Foundation.h>
#import "Request.h"
NS_ASSUME_NONNULL_BEGIN

@interface PostRequest : Request
/// POST 请求
/// @param url 网址
/// @param argument 参数
- (id)initWithRequestUrl:(NSString *)url argument:(id)argument;

- (id)initWithRequestUrl:(NSString *)url argument:(id)argument constructingBodyBlock:(nullable AFConstructingBlock)block;
@end

NS_ASSUME_NONNULL_END
