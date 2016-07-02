//
//  RWWebViewController.m
//  Demo
//
//  Created by 许宗城 on 16/7/1.
//  Copyright © 2016年 许宗城. All rights reserved.
//

#import "RWWebViewController.h"
#import "RWWebViewController_Protect.h"
#import "RWWebViewMessageHandler.h"
#import "UINavigationBar+RWWebProgress.h"


@interface RWWebViewController () 

@property (nonatomic, copy) NSString *urlStr;



@end

@implementation RWWebViewController

- (instancetype)initWithURLString:(NSString *)urlStr {
    if (self = [super init]) {
        _urlStr = urlStr;
        
    }
    return self;
}

- (void)dealloc {
    self.progressView.progress = 0;
    [self.messageHandler removeAllListen];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    NSLog(@"dealloc - webvc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.navigationController) {
        self.progressView = self.navigationController.navigationBar.rw_webProgressView;
    }
    
    WKWebViewConfiguration *config = [self configForWebView];
    self.config = config;
    
    RWWebViewMessageHandler *msgHandler = [[RWWebViewMessageHandler alloc] initWithWebViwConfig:config];
    msgHandler.delegate = self;
    self.messageHandler = msgHandler;
    
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:webView];
    self.webView = webView;
    
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    
    [self loadURL];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.webView stopLoading];
}

- (void)loadURL {
    if (self.urlStr.length == 0) {
        return;
    }
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:req];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        if (self.navigationController) {
            self.progressView.progress = self.webView.estimatedProgress;
        }
    } else if ([keyPath isEqualToString:@"title"]) {
        self.navigationItem.title = self.webView.title;
    }
}

- (WKWebViewConfiguration *)configForWebView {
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *userContent = [[WKUserContentController alloc] init];
    
    WKUserScript *disableSelect = [[WKUserScript alloc] initWithSource:@"document.documentElement.style.webkitUserSelect='none';" injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
    WKUserScript *disableCallout = [[WKUserScript alloc] initWithSource:@"document.documentElement.style.webkitTouchCallout='none';" injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
    [userContent addUserScript:disableSelect];
    [userContent addUserScript:disableCallout];
    
    config.userContentController = userContent;
    return config;
}


#pragma mark - Receive Message

- (void)webViewMessageHandler:(RWWebViewMessageHandler *)msgHandler didReceiveMessage:(WKScriptMessage *)message {
    
}


#pragma mark - UIDelegate

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - Nav Delegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSURL *URL = navigationAction.request.URL;
    
    if ([URL.scheme isEqualToString:@"tel"]) {
        if ([[UIApplication sharedApplication] canOpenURL:URL]) {
            NSString *phone = URL.resourceSpecifier;
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"拨打电话" message:phone preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:URL];
            }];
            [alert addAction:cancel];
            [alert addAction:confirm];
            [self presentViewController:alert animated:YES completion:nil];
            
            
        }
        
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    
    decisionHandler(WKNavigationActionPolicyAllow);
}



@end
