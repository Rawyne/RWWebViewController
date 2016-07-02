//
//  RWWebViewMessageHandler.h
//  Demo
//
//  Created by 许宗城 on 16/7/1.
//  Copyright © 2016年 许宗城. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RWWebViewMessageHandler, WKScriptMessage, WKWebViewConfiguration;

@protocol RWWebViewMessageHandlerDelegate <NSObject>

- (void)webViewMessageHandler:(RWWebViewMessageHandler *)msgHandler didReceiveMessage:(WKScriptMessage *)message;

@end



@interface RWWebViewMessageHandler : NSObject

- (instancetype)initWithWebViwConfig:(WKWebViewConfiguration *)config;

@property (nonatomic, weak) id<RWWebViewMessageHandlerDelegate> delegate;

/**
 *  添加JS函数监听
 */
- (void)addMessageListenWithName:(NSString *)name;

/**
 *  webview销毁时调用
 */
- (void)removeAllListen;

@end
