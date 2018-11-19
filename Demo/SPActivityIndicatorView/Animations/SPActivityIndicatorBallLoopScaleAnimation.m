//
//  SPActivityIndicatorBallLoopScaleAnimation.m
//  SPActivityIndicatorView
//
//  Created by 乐升平 on 2018/11/19.
//  Copyright © 2018 乐升平. All rights reserved.
//

#import "SPActivityIndicatorBallLoopScaleAnimation.h"

@implementation SPActivityIndicatorBallLoopScaleAnimation
- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    
    CGFloat circleSpacing = -2;
    CGFloat circleSize = (size.width - 4 * circleSpacing) / 5;
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame          = layer.bounds;
    [layer addSublayer:replicatorLayer];
    
    
    CALayer *dot        = [CALayer layer];
    dot.bounds          = CGRectMake(0, 0, circleSize, circleSize);
    dot.position        = CGPointMake(50, 20);
    dot.backgroundColor = tintColor.CGColor;
    dot.cornerRadius    = circleSize/2.0;
    dot.masksToBounds   = YES;
    
    [replicatorLayer addSublayer:dot];
    
    
    CGFloat count                     = 10.0;
    replicatorLayer.instanceCount     = count;
    CGFloat angel                     = 2* M_PI/count;
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(angel, 0, 0, 1);
    
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration    = 1.0;
    animation.fromValue   = @1;
    animation.toValue     = @0.1;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    [dot addAnimation:animation forKey:nil];
    
    
    replicatorLayer.instanceDelay = 1.0/ count;
    
    dot.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
}

@end
