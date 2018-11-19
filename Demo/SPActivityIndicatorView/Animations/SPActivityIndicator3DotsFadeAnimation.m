//
//  SPActivityIndicator3DotsFadeAnimation.m
//  SPActivityIndicatorView
//
//  Created by 乐升平 on 2018/11/19.
//  Copyright © 2018 乐升平. All rights reserved.
//

#import "SPActivityIndicator3DotsFadeAnimation.h"

@implementation SPActivityIndicator3DotsFadeAnimation
- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    CGFloat duration = 0.5f;
    CGFloat firstBeginTime = CACurrentMediaTime(); // 不能写0，写0每次跑程序都会有些许的误差
    NSArray *beginTimes = @[@(firstBeginTime), @(firstBeginTime+0.25), @(firstBeginTime+0.5)];
    CGFloat circleSpacing = 5.0f;
    CGFloat circleSize = (size.width - circleSpacing * 2) / 3;
    CGFloat x = (layer.bounds.size.width - size.width) / 2;
    CGFloat y = (layer.bounds.size.height - circleSize) / 2;
    
    // Opacity animation
    CAKeyframeAnimation *opacityAnimation = [self createKeyframeAnimationWithKeyPath:@"opacity"];
    opacityAnimation.duration = duration;
    opacityAnimation.values = @[@1.0f,@0.0f];
    opacityAnimation.repeatCount = HUGE_VALF;
    opacityAnimation.autoreverses = YES;
    opacityAnimation.removedOnCompletion = NO;
    opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // Draw circles
    for (int i = 0; i < 3; i++) {
        CAShapeLayer *circle = [CAShapeLayer layer];
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, circleSize, circleSize) cornerRadius:circleSize / 2];
        opacityAnimation.beginTime = [beginTimes[i] floatValue];
        circle.fillColor = tintColor.CGColor;
        circle.path = circlePath.CGPath;
        [circle addAnimation:opacityAnimation forKey:@"animation"];
        circle.frame = CGRectMake(x + circleSize * i + circleSpacing * i, y, circleSize, circleSize);
        [layer addSublayer:circle];
    }
}
@end
