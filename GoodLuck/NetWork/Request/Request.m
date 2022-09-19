//
//  Request.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/5/30.
//

#import "Request.h"
#import "LoginInfoManage.h"
@implementation Request
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        //AFNet支持Https 测试环境下忽略https证书。。
//        [agent setValue:@YES forKeyPath:@"_manager.securityPolicy.allowInvalidCertificates"];
        self.verifyJSONFormat = YES;
    }
    return self;
}

- (YTKRequestSerializerType)requestSerializerType
{
    return YTKRequestSerializerTypeJSON;
}

- (NSDictionary *)requestHeaderFieldValueDictionary
{
    NSString *token = [LoginInfoManage shareInstance].token;
    if ([Tools isEmpty:token])
    {
        return @{};
    }
    else
    {
        return @{@"token":token};
    }
    
}

- (NSString *)baseUrl
{
    return BASEURL;
}

- (NSTimeInterval)requestTimeoutInterval
{
    return 30;
}

- (id)jsonValidator
{
    return nil;
}

- (void)startWithCompletionBlockWithSuccess:(nullable RequestCompletionBlock)success
                                    failure:(nullable RequestCompletionFailureBlock)failure
{
    [super startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *result = [request responseJSONObject];
        BOOL isSuccess = [[result objectForKey:@"code"] intValue] == 200;
        if (!isSuccess)
        {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[result objectForKey:@"msg"]];
        }
        success(request,result,isSuccess);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"%@",self.description);
        failure(request,[self handleErrorInfo:request]);
    }];
}



- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ \nstatusCode:%ld\nresponseJSONObject:\n%@",super.description,self.responseStatusCode,self.responseJSONObject];
}

- (NSString *)handleErrorInfo:(YTKBaseRequest *)request
{
    NSString * info = @"";
    if (request && request.error)
    {
        if (request.error.code==NSURLErrorNotConnectedToInternet)
        {
            info = @"请检查网络!";
        }
        else if (request.error.code==NSURLErrorTimedOut)
        {
            info = @"请求超时,请重试!";
        }
        else if (request.responseStatusCode == 401)
        {
            info = @"token失效,请重新登录";
            [LoginInfoManage shareInstance].token = @"";
            [Tools logout];
        }
        else if (request.responseStatusCode == 500)
        {
            info = @"服务器报错,请稍后再试!";
        }
        else
        {
            info = @"获取数据失败,请重试!";
        }
    }
    [SVProgressHUD showImage:[UIImage imageNamed:@""] status:info];
    self.errorInfo = info;
    return info;
}
@end
