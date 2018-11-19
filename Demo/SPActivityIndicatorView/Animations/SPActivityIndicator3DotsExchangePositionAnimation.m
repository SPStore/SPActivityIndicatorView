//
//  SPActivityIndicator3DotsExchangePositionAnimation.m
//  SPActivityIndicatorExample
//
//  Created by Libo on 2017/12/29.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "SPActivityIndicator3DotsExchangePositionAnimation.h"

@implementation SPActivityIndicator3DotsExchangePositionAnimation

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    NSTimeInterval beginTime = CACurrentMediaTime();
    NSTimeInterval duration = 0.5f;
    
    CGFloat circleSize = size.width / 4.0f;
    CGFloat circlePadding = circleSize / 2.0f;
    
    CGFloat oX = (layer.bounds.size.width - size.width) / 2.0f;
    CGFloat oY = (layer.bounds.size.height - size.height) / 2.0f;
    
    for (int i = 0; i < 3; i++) {
        CALayer *circle = [CALayer layer];
        circle.frame = CGRectMake(oX + (circleSize + circlePadding) * (i % 3), oY+(size.height-circleSize)/2, circleSize, circleSize);
        circle.backgroundColor = tintColor.CGColor;
        circle.anchorPoint = CGPointMake(0.5f, 0.5f);
        circle.opacity = 1.0f;
        circle.cornerRadius = circleSize / 2.0f;
        [layer addSublayer:circle];
    }
    CALayer *circle1 = [layer.sublayers objectAtIndex:0];
    CALayer *circle2 = [layer.sublayers objectAtIndex:1];
    CALayer *circle3 = [layer.sublayers objectAtIndex:2];
    UIColor *circle1Color = [tintColor colorWithAlphaComponent:1];
    UIColor *circle2Color = [tintColor colorWithAlphaComponent:0.6];
    UIColor *circle3Color = [tintColor colorWithAlphaComponent:0.3];
    
    CGPoint otherRoundCenter1 = CGPointMake(oX+circleSize+circlePadding*0.5, layer.bounds.size.height*0.5);
    CGPoint otherRoundCenter2 = CGPointMake(oX+circleSize*2+circlePadding+circlePadding*0.5, layer.bounds.size.height*0.5);
    
    //圆1的路径
    UIBezierPath *path1 = [[UIBezierPath alloc] init];
    [path1 addArcWithCenter:otherRoundCenter1 radius:circleSize*0.5+circlePadding*0.5 startAngle:-M_PI endAngle:0 clockwise:true];
    UIBezierPath *path1_1 = [[UIBezierPath alloc] init];
    [path1_1 addArcWithCenter:otherRoundCenter2 radius:circleSize*0.5+circlePadding*0.5 startAngle:-M_PI endAngle:0 clockwise:false];
    [path1 appendPath:path1_1];
    [self viewMovePathAnimWith:circle1 path:path1 andTime:duration brginTime:beginTime];
    [self viewColorAnimWith:circle1 fromColor:circle1Color toColor:circle3Color andTime:duration];
    
    UIBezierPath *path2 = [[UIBezierPath alloc] init];
    [path2 addArcWithCenter:otherRoundCenter1 radius:circleSize*0.5+circlePadding*0.5 startAngle:0 endAngle:-M_PI clockwise:true];
    [self viewMovePathAnimWith:circle2 path:path2 andTime:duration brginTime:beginTime];
    [self viewColorAnimWith:circle2 fromColor:circle2Color toColor:circle1Color andTime:duration];
    
    UIBezierPath *path3 = [[UIBezierPath alloc] init];
    [path3 addArcWithCenter:otherRoundCenter2 radius:circleSize*0.5+circlePadding*0.5 startAngle:0 endAngle:-M_PI clockwise:false];
    [self viewMovePathAnimWith:circle3 path:path3 andTime:duration brginTime:beginTime];
    [self viewColorAnimWith:circle3 fromColor:circle3Color toColor:circle2Color andTime:duration];
    
}

- (void)viewMovePathAnimWith:(CALayer *)layer path:(UIBezierPath *)path andTime:(CGFloat)time brginTime:(NSTimeInterval)beginTime {
    
    CAKeyframeAnimation *anim = [self createKeyframeAnimationWithKeyPath:@"position"];
    
    anim.path = [path CGPath];
    anim.beginTime = beginTime;
    anim.removedOnCompletion = false;
    anim.fillMode = kCAFillModeForwards;
    anim.calculationMode = kCAAnimationCubic;
    anim.repeatCount = HUGE_VALF;
    anim.duration = time;
    anim.autoreverses = NO;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [layer addAnimation:anim forKey:@"animation"];
    
}

///设置view的颜色动画
- (void)viewColorAnimWith:(CALayer *)layer fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor andTime:(CGFloat)time {
    CABasicAnimation *colorAnim = [self createBasicAnimationWithKeyPath:@"backgroundColor"];
    colorAnim.toValue = (__bridge id _Nullable)([toColor CGColor]);
    colorAnim.fromValue = (__bridge id _Nullable)([fromColor CGColor]);
    colorAnim.duration = time;
    colorAnim.autoreverses = NO;
    colorAnim.fillMode = kCAFillModeForwards;
    colorAnim.removedOnCompletion = false;
    colorAnim.repeatCount = HUGE_VALF;
    [layer addAnimation:colorAnim forKey:@"backgroundColor"];
    
}

@end
