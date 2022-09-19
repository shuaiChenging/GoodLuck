//
//  PostImgRequest.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/10.
//

#import "RequestImg.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostImgRequest : RequestImg
- (id)initWithRequestUrl:(NSString *)url argument:(id)argument constructingBodyBlock:(nullable AFConstructingBlock)block;
@end

NS_ASSUME_NONNULL_END
