//
//  GetRequest.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/5/30.
//

#import "GetRequest.h"

@implementation GetRequest
- (id)initWithRequestUrl:(NSString *)url argument:(NSDictionary *)argument
{
    self = [super init];
    if (self)
    {
        self.requestUrl = url;
        self.requestArgument = argument;
    }
    return self;
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}
@end
