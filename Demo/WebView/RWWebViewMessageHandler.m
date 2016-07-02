//
//  RWWebViewMessageHandler.m
//  Demo
//
//  Created by 许宗城 on 16/7/1.
//  Copyright © 2016年 许宗城. All rights reserved.
//

#import "RWWebViewMessageHandler.h"

@import WebKit;


@interface RWWebViewMessageHandler () <WKScriptMessageHandler>

@property (nonatomic, weak) WKWebViewConfiguration *config;

@property (nonatomic, strong) NSMutableArray *names;

@end

@implementation RWWebViewMessageHandler

- (instancetype)initWithWebViwConfig:(WKWebViewConfiguration *)config {
    if (self = [super init]) {
        _config = config;
        
        _names = [NSMutableArray array];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"dealloc - msg handler");
}

- (void)addMessageListenWithName:(NSString *)name {
    [self.names addObject:name];
    [self.config.userContentController addScriptMessageHandler:self name:name];
}

- (void)removeAllListen {
    for (NSString *name in self.names) {
        [self.config.userContentController removeScriptMessageHandlerForName:name];
    }
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([self.delegate respondsToSelector:@selector(webViewMessageHandler:didReceiveMessage:)]) {
        [self.delegate webViewMessageHandler:self didReceiveMessage:message];
    }
}

@end
