//
//  PostImgRequest.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/10.
//

#import "PostImgRequest.h"

@implementation PostImgRequest
- (id)initWithRequestUrl:(NSString *)url argument:(id)argument
{
    return [self initWithRequestUrl:url argument:argument constructingBodyBlock:nil];
}

- (id)initWithRequestUrl:(NSString *)url argument:(id)argument constructingBodyBlock:(nullable AFConstructingBlock)block
{
    self = [super init];
    if (self)
    {
        self.requestUrl = url;
        self.requestArgument = argument;
        self.constructingBodyBlock = block;
    }
    return self;
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}
@end
