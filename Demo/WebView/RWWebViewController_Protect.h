//
//  RWWebViewController_Protect.h
//  Demo
//
//  Created by 许宗城 on 16/7/1.
//  Copyright © 2016年 许宗城. All rights reserved.
//

#import "RWWebViewController.h"
#import "RWWebViewMessageHandler.h"
#import "UINavigationBar+RWWebProgress.h"

@import WebKit;

@interface RWWebViewController () <WKUIDelegate, WKNavigationDelegate, RWWebViewMessageHandlerDelegate>

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) WKWebViewConfiguration *config;

@property (nonatomic, strong) RWWebViewMessageHandler *messageHandler;

@property (nonatomic, weak) RWWebProgressView *progressView;



// override if need
- (WKWebViewConfiguration *)configForWebView;




@end
