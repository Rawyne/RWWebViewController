//
//  UINavigationBar+RWWebProgress.h
//  Demo
//
//  Created by 许宗城 on 16/7/1.
//  Copyright © 2016年 许宗城. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWWebProgressView.h"

@interface UINavigationBar (RWWebProgress)

@property (nonatomic, weak, readonly) RWWebProgressView *rw_webProgressView;

@end
