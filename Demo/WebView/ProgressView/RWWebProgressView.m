//
//  RWWebProgressView.m
//  Demo
//
//  Created by 许宗城 on 16/7/1.
//  Copyright © 2016年 许宗城. All rights reserved.
//

#import "RWWebProgressView.h"


@interface RWWebProgressView ()

@property (nonatomic, weak) CAShapeLayer *progressLayer;

@end

@implementation RWWebProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        self.progressLayer = layer;
        [self.layer addSublayer:layer];
        
        layer.strokeColor = self.tintColor.CGColor;
    }
    
    return self;
}

- (void)tintColorDidChange {
    [super tintColorDidChange];
    self.progressLayer.strokeColor = self.tintColor.CGColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self updatePath];
}

- (void)updatePath {
    
    CGFloat y = self.frame.size.height / 2;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, y)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, y)];
    
    self.progressLayer.path = path.CGPath;
    self.progressLayer.lineWidth = self.frame.size.height;
    
    [self animProgress:self.progress];
}



- (void)setProgress:(float)progress {
    if (progress < 0.0) {
        progress = 0.0;
    } else if (progress > 1.0) {
        progress = 1.0;
    }
    _progress = progress;
    
    [self animProgress:progress];
}

- (void)animProgress:(float)progress {
    
    self.progressLayer.strokeEnd = progress;
    
    if (progress == 1) {
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            if (finished) {
                self.progressLayer.strokeEnd = 0;
            }
        }];
    } else {
        self.alpha = 1;
    }
}

@end
