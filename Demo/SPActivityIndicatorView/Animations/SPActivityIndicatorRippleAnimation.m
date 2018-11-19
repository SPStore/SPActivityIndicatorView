//
//  SPActivityIndicatorRippleAnimation.m
//  SPActivityIndicatorView
//
//  Created by 乐升平 on 2018/11/19.
//  Copyright © 2018 乐升平. All rights reserved.
//

#import "SPActivityIndicatorRippleAnimation.h"

@implementation SPActivityIndicatorRippleAnimation

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    CAShapeLayer *pulseLayer = [CAShapeLayer layer];
    pulseLayer.frame = CGRectInset(layer.bounds, 5, 5);
    pulseLayer.path = [UIBezierPath bezierPathWithOvalInRect:pulseLayer.bounds].CGPath;
    pulseLayer.fillColor = tintColor.CGColor;//填充色
    pulseLayer.opacity = 0.0;
    
    //可以复制layer
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectInset(layer.bounds, 5, 5);
    replicatorLayer.instanceCount = 4;//创建副本的数量,包括源对象。
    replicatorLayer.instanceDelay = 1;//复制副本之间的延迟
    [replicatorLayer addSublayer:pulseLayer];
    [layer addSublayer:replicatorLayer];
    
    CABasicAnimation *opacityAnima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnima.fromValue = @(0.7);
    opacityAnima.toValue = @(0.0);
    
    CABasicAnimation *scaleAnima = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnima.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.0, 0.0, 0.0)];
    scaleAnima.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
    
    CAAnimationGroup *groupAnima = [CAAnimationGroup animation];
    groupAnima.animations = @[opacityAnima, scaleAnima];
    groupAnima.duration = 4.0;
    groupAnima.autoreverses = NO;
    groupAnima.repeatCount = HUGE;
    groupAnima.removedOnCompletion = NO;
    [pulseLayer addAnimation:groupAnima forKey:@"groupAnimation"];
}
@end
