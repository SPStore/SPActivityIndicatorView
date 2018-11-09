//
//  SPActivityIndicatorLoadingSuccessAnimation.m
//  SPActivityIndicatorExample
//
//  Created by Libo on 2017/12/28.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "SPActivityIndicatorLoadingSuccessAnimation.h"

static CGFloat lineWidth = 2.0f;
static CGFloat duration = 0.5f;

@implementation SPActivityIndicatorLoadingSuccessAnimation

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    
    CGFloat oX = (layer.bounds.size.width-size.width)*0.5;
    CGFloat oY = (layer.bounds.size.height-size.height)*0.5;
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.frame = CGRectMake(oX, oY, size.width, size.height);
    circleLayer.fillColor =  [[UIColor clearColor] CGColor];
    circleLayer.strokeColor  = tintColor.CGColor;
    circleLayer.lineWidth = lineWidth;
    circleLayer.lineCap = kCALineCapRound;
    [layer addSublayer:circleLayer];
    
    
    CGFloat radius = size.width/2.0f - lineWidth/2.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(circleLayer.frame.size.width*0.5, circleLayer.frame.size.height*0.5) radius:radius startAngle:-M_PI/2 endAngle:M_PI*3/2 clockwise:true];
    circleLayer.path = path.CGPath;
    
    CABasicAnimation *circleAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    circleAnimation.duration = duration;
    circleAnimation.fromValue = @(0.0f);
    circleAnimation.toValue = @(1.0f);
    circleAnimation.autoreverses = NO;
    circleAnimation.fillMode = kCAFillModeForwards;
    circleAnimation.removedOnCompletion = false;
    [circleAnimation setValue:@"circleAnimation" forKey:@"animationName"];
    [circleLayer addAnimation:circleAnimation forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 对号
        CGFloat a = circleLayer.bounds.size.width;
        
        UIBezierPath *checkPath = [UIBezierPath bezierPath];
        [checkPath moveToPoint:CGPointMake(a*2.7/10,a*5.4/10)];
        [checkPath addLineToPoint:CGPointMake(a*4.5/10,a*7/10)];
        [checkPath addLineToPoint:CGPointMake(a*7.8/10,a*3.8/10)];
        
        CAShapeLayer *checkLayer = [CAShapeLayer layer];
        checkLayer.path = checkPath.CGPath;
        checkLayer.fillColor = [UIColor clearColor].CGColor;
        checkLayer.strokeColor = tintColor.CGColor;
        checkLayer.lineWidth = lineWidth;
        checkLayer.lineCap = kCALineCapRound;
        checkLayer.lineJoin = kCALineJoinRound;
        [circleLayer addSublayer:checkLayer];
        
        CABasicAnimation *checkAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        checkAnimation.duration = duration;
        checkAnimation.fromValue = @(0.0f);
        checkAnimation.toValue = @(1.0f);
        checkAnimation.autoreverses = NO;
        checkAnimation.fillMode = kCAFillModeForwards;
        checkAnimation.removedOnCompletion = false;
        [checkAnimation setValue:@"checkAnimation" forKey:@"checkAnimation"];
        [checkLayer addAnimation:checkAnimation forKey:nil];
    });
    
}
@end
