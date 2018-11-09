//
//  SPActivityIndicatorLoadingFailAnimation.m
//  SPActivityIndicatorExample
//
//  Created by Libo on 2017/12/28.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "SPActivityIndicatorLoadingFailAnimation.h"

static CGFloat lineWidth = 2.0f;
static CGFloat duration = 0.5f;

@implementation SPActivityIndicatorLoadingFailAnimation

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
    
    // 画叉
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        CGFloat a = circleLayer.bounds.size.width;
        
        // 已知:
        // 1.圆点坐标：(x0,y0)
        // 2.半径：r
        // 3.角度：radians(弧度制)
        // 则:
        // 则圆上任一点为：（x,y）
        // x   =   x0   +   r   *   cos(radians)
        // y   =   y0   +   r   *   sin(radians)
        
        CGFloat x0 = circleLayer.frame.size.width*0.5;
        CGFloat y0 = circleLayer.frame.size.height*0.5;
        
        CGFloat x = x0 + radius * cos(-M_PI*3/4);
        CGFloat y = y0 + radius * sin(-M_PI*3/4);

        CGFloat margin = 4;
        UIBezierPath *chaPath1 = [UIBezierPath bezierPath];
        [chaPath1 moveToPoint:CGPointMake(x+lineWidth*0.5+margin,y+lineWidth*0.5+margin)];
        [chaPath1 addLineToPoint:CGPointMake(a-x-lineWidth*0.5-margin,a-y-lineWidth*0.5-margin)];
        
        CAShapeLayer *chaLayer1 = [CAShapeLayer layer];
        chaLayer1.path = chaPath1.CGPath;
        chaLayer1.fillColor = [UIColor clearColor].CGColor;
        chaLayer1.strokeColor = tintColor.CGColor;
        chaLayer1.lineWidth = lineWidth;
        chaLayer1.lineCap = kCALineCapRound;
        chaLayer1.lineJoin = kCALineJoinRound;
        [circleLayer addSublayer:chaLayer1];
        
        CABasicAnimation *checkAnimation1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        checkAnimation1.duration = duration;
        checkAnimation1.fromValue = @(0.0f);
        checkAnimation1.toValue = @(1.0f);
        checkAnimation1.autoreverses = NO;
        checkAnimation1.fillMode = kCAFillModeForwards;
        checkAnimation1.removedOnCompletion = false;
        [checkAnimation1 setValue:@"chaAnimation" forKey:@"chaAnimation1"];
        [chaLayer1 addAnimation:checkAnimation1 forKey:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            CGFloat x0 = circleLayer.frame.size.width*0.5;
            CGFloat y0 = circleLayer.frame.size.height*0.5;
            
            CGFloat x = x0 + radius * cos(-M_PI/4);
            CGFloat y = y0 + radius * sin(-M_PI/4);
            
            CGFloat margin = 4;
            UIBezierPath *chaPath2 = [UIBezierPath bezierPath];
            [chaPath2 moveToPoint:CGPointMake(x-lineWidth*0.5-margin,y+lineWidth*0.5+margin)];
            [chaPath2 addLineToPoint:CGPointMake(a-x+lineWidth*0.5+margin,a-y-lineWidth*0.5-margin)];
            
            CAShapeLayer *chaLayer2 = [CAShapeLayer layer];
            chaLayer2.path = chaPath2.CGPath;
            chaLayer2.fillColor = [UIColor clearColor].CGColor;
            chaLayer2.strokeColor = tintColor.CGColor;
            chaLayer2.lineWidth = lineWidth;
            chaLayer2.lineCap = kCALineCapRound;
            chaLayer2.lineJoin = kCALineJoinRound;
            [circleLayer addSublayer:chaLayer2];
            
            CABasicAnimation *checkAnimation2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            checkAnimation2.duration = duration;
            checkAnimation2.fromValue = @(0.0f);
            checkAnimation2.toValue = @(1.0f);
            checkAnimation2.autoreverses = NO;
            checkAnimation2.fillMode = kCAFillModeForwards;
            checkAnimation2.removedOnCompletion = false;
            [checkAnimation2 setValue:@"chaAnimation" forKey:@"chaAnimation2"];
            [chaLayer2 addAnimation:checkAnimation2 forKey:nil];
            
        });
    });
    
}

@end
