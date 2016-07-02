//
//  WebViewController.m
//  Demo
//
//  Created by 许宗城 on 16/7/1.
//  Copyright © 2016年 许宗城. All rights reserved.
//

#import "WebViewController.h"
#import "RWWebViewController_Protect.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.messageHandler addMessageListenWithName:@"JSMsg"];
}

- (void)webViewMessageHandler:(RWWebViewMessageHandler *)msgHandler didReceiveMessage:(WKScriptMessage *)message {
    
    NSString *name = message.name;
    if ([name isEqualToString:@"JSMsg"]) {
        [self.webView evaluateJavaScript:[NSString stringWithFormat:@"foo(\'HI\')"] completionHandler:^(id _Nullable ret, NSError * _Nullable error) {
            NSLog(@"%@", ret);
        }];
    }
}

@end
