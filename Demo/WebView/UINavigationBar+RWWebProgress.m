//
//  UINavigationBar+RWWebProgress.m
//  Demo
//
//  Created by 许宗城 on 16/7/1.
//  Copyright © 2016年 许宗城. All rights reserved.
//

#import "UINavigationBar+RWWebProgress.h"
#import <objc/runtime.h>


static void *kProgressViewKey = &kProgressViewKey;

@implementation UINavigationBar (RWWebProgress)

- (RWWebProgressView *)rw_addProgressView {
    CGFloat h = 2.2;
    
    RWWebProgressView *view = [[RWWebProgressView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, h)];
    view.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height - h / 2);
    view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    
    [self addSubview:view];
    objc_setAssociatedObject(self, kProgressViewKey, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return view;
}

- (RWWebProgressView *)rw_webProgressView {
    RWWebProgressView *view = objc_getAssociatedObject(self, kProgressViewKey);
    if (!view) {
        view = [self rw_addProgressView];
    }
    return view;
}

@end
