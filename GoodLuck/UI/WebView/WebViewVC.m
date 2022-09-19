//
//  WebViewVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/2.
//

#import "WebViewVC.h"
#import <WebKit/WebKit.h>
@interface WebViewVC ()<WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation WebViewVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    // Do any additional setup after loading the view.
}

- (WKWebView *)webView
{
    if(!_webView)
    {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *userController = [[WKUserContentController alloc] init];
        configuration.userContentController = userController;
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        _webView.navigationDelegate = self;
        _webView.backgroundColor = [UIColor whiteColor];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
    }
    return _webView;
}

#pragma mark - WKNavigationDelegate
// 强制信任https无效证书
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler
{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        NSURLCredential *card = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential,card);
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
//    __weak typeof(self) weakSelf = self;
//    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable title, NSError * _Nullable error) {
//        weakSelf.title = title;
//    }];
}



@end
