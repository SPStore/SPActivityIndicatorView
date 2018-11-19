//
//  SPActivityIndicatorBallRotaingAroundBallAnimation.m
//  SPActivityIndicatorExample
//
//  Created by Libo on 2017/12/29.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "SPActivityIndicatorBallRotaingAroundBallAnimation.h"

@interface SPActivityIndicatorBallRotaingAroundBallAnimation() <CAAnimationDelegate>
@property (nonatomic, strong) CALayer *layer;
@property (nonatomic, strong) CALayer *circle1;
@property (nonatomic, strong) CALayer *circle2;
@property (nonatomic, strong) CALayer *circle3;
@property (nonatomic, assign) CGFloat areaX;
@property (nonatomic, assign) CGFloat areaY;
@property (nonatomic, assign) CGSize areaSize;
@property (nonatomic, assign) CGFloat circleSize;
@property (nonatomic, assign) CGFloat circleRadius;
@end

@implementation SPActivityIndicatorBallRotaingAroundBallAnimation

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    
    _layer = layer;
    _areaSize = size;
    
    _circleSize = size.width / 5.0f;
    
    // 相对layer的x和y
    _areaX = (layer.bounds.size.width - size.width) / 2.0f;
    _areaY = (layer.bounds.size.height - size.height) / 2.0f;
    _circleRadius = _circleSize * 0.5;
    
    // 创建3个小圆点
    for (int i = 0; i < 3; i++) {
        CALayer *circle = [CALayer layer];
        circle.frame = CGRectMake(_areaX + _circleSize * (i % 3) + _circleSize, _areaY + (size.height - _circleSize) / 2, _circleSize, _circleSize);
        circle.backgroundColor = tintColor.CGColor;
        circle.anchorPoint = CGPointMake(0.5f, 0.5f);
        circle.opacity = 1.0f;
        circle.backgroundColor = tintColor.CGColor;
        circle.cornerRadius = _circleSize / 2.0f;
        [layer addSublayer:circle];
    }
    CALayer *circle1 = [layer.sublayers objectAtIndex:0];
    CALayer *circle2 = [layer.sublayers objectAtIndex:1];
    CALayer *circle3 = [layer.sublayers objectAtIndex:2];
    
    _circle1 = circle1;
    _circle2 = circle2;
    _circle3 = circle3;
    
    [self configureAnimation];
 
}

- (void)configureAnimation {
    // 第一个小球和第三个小球的第一段轨迹都是大圆，第二段轨迹是小圆，以下R表示大圆半径，r表示小圆半径
    CGFloat r = _circleSize;
    CGFloat R = _circleSize*1.5;
    
    // 第1个圆的中点
    CGPoint centerBall1 = _circle1.position;
    // 第2个圆的中点
    CGPoint centerBall2 = _circle2.position;
    // 第3个圆的中点
    CGPoint centerBall3 = _circle3.position;
    
    // 第1个圆的第一段轨迹,轨迹呈直线
    UIBezierPath *ball1_path1 = [UIBezierPath bezierPath];
    [ball1_path1 moveToPoint:centerBall1];
    [ball1_path1 addLineToPoint:CGPointMake(_areaX+_circleRadius, _layer.frame.size.height/2)];
    // 第1个圆的第二段轨迹，轨迹呈大圆
    UIBezierPath *ball1_path2 = [UIBezierPath bezierPath];
    [ball1_path2 addArcWithCenter:CGPointMake(_areaX+2*_circleSize, _layer.frame.size.height/2) radius:R startAngle:M_PI endAngle:2*M_PI clockwise:NO];
    // 第1个圆的第三段轨迹，轨迹呈小圆
    UIBezierPath *ball1_path3 = [UIBezierPath bezierPath];
    [ball1_path3 addArcWithCenter:centerBall2 radius:r startAngle:0 endAngle:M_PI clockwise:NO];
    [ball1_path2 appendPath:ball1_path3];
    [ball1_path1 appendPath:ball1_path2];
    
    // 第1个圆的动画
    CAKeyframeAnimation *keyAnimation1 = [self createKeyframeAnimationWithKeyPath:@"position"];
    keyAnimation1.path = ball1_path1.CGPath;
    keyAnimation1.removedOnCompletion = NO;
    keyAnimation1.fillMode = kCAFillModeForwards;
    keyAnimation1.calculationMode = kCAAnimationCubic;
    keyAnimation1.repeatCount = 1;
    keyAnimation1.duration = 1.4;
    keyAnimation1.autoreverses = YES;
    keyAnimation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_circle1 addAnimation:keyAnimation1 forKey:@"rotation1"];
    
    // 第3个圆的第一段轨迹，轨迹呈直线
    UIBezierPath *ball3_path1 = [UIBezierPath bezierPath];
    [ball3_path1 moveToPoint:centerBall3];
    [ball3_path1 addLineToPoint:CGPointMake(_areaX+_areaSize.width-_circleRadius, _layer.frame.size.height/2)];
    // 第3个圆的第二段轨迹，轨迹呈大圆
    UIBezierPath *ball3_path2 = [UIBezierPath bezierPath];
    [ball3_path2 addArcWithCenter:CGPointMake(_areaX+3*_circleSize, _layer.frame.size.height/2) radius:R startAngle:0 endAngle:M_PI clockwise:NO];
    // 第3个圆的第三段轨迹，轨迹呈小圆
    UIBezierPath *ball3_path3 = [UIBezierPath bezierPath];
    [ball3_path3 addArcWithCenter:centerBall2 radius:r startAngle:M_PI endAngle:2*M_PI clockwise:NO];
    [ball3_path2 appendPath:ball3_path3];
    [ball3_path1 appendPath:ball3_path2];
    
    // 第3个圆的动画
    CAKeyframeAnimation *keyAnimation3 = [self createKeyframeAnimationWithKeyPath:@"position"];
    keyAnimation3.path = ball3_path1.CGPath;
    keyAnimation3.removedOnCompletion = NO;
    keyAnimation3.fillMode = kCAFillModeForwards;
    keyAnimation3.calculationMode = kCAAnimationCubic;
    keyAnimation3.repeatCount = 1;
    keyAnimation3.duration = 1.4;
    keyAnimation3.autoreverses = YES;
    keyAnimation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_circle3 addAnimation:keyAnimation3 forKey:@"rotation3"];
    
    // 执行缩放动画
    [self configureScaleAnimationWithStop:NO];
}

// 缩放动画
- (void)configureScaleAnimationWithStop:(BOOL)stop {
    if (!stop) {
        CABasicAnimation *circle1_basicAnimation1 = [self setupShrinkScaleAnimation];
        circle1_basicAnimation1.delegate = self;
        [_circle1 addAnimation:circle1_basicAnimation1 forKey:@"circle1_basicAnimation1"];
        
        CABasicAnimation *circle2_basicAnimation1 = [self setupShrinkScaleAnimation];
        [_circle2 addAnimation:circle2_basicAnimation1 forKey:@"circle2_basicAnimation1"];
        
        CABasicAnimation *circle3_basicAnimation1 = [self setupShrinkScaleAnimation];
        [_circle3 addAnimation:circle3_basicAnimation1 forKey:@"circle3_basicAnimation1"];
        
    } else {
        CABasicAnimation *circle1_basicAnimation2 = [self setupEnlargeScaleAnimation];
        circle1_basicAnimation2.delegate = self;
        [_circle1 addAnimation:circle1_basicAnimation2 forKey:@"circle1_basicAnimation2"];
        
        CABasicAnimation *circle2_basicAnimation2 = [self setupEnlargeScaleAnimation];
        [_circle2 addAnimation:circle2_basicAnimation2 forKey:@"circle2_basicAnimation2"];
        
        CABasicAnimation *circle3_basicAnimation2 = [self setupEnlargeScaleAnimation];
        [_circle3 addAnimation:circle3_basicAnimation2 forKey:@"circle3_basicAnimation2"];
    }
}

// 设置缩小动画
- (CABasicAnimation *)setupShrinkScaleAnimation {
    CABasicAnimation *animation = [self createBasicAnimationWithKeyPath:@"transform.scale"];
    animation.fromValue = @1;
    animation.toValue = @0.7;
    animation.repeatCount = 1;
    animation.duration = 0.3;
    animation.autoreverses = YES;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

// 设置放大动画
- (CABasicAnimation *)setupEnlargeScaleAnimation {
    CABasicAnimation *animation = [self createBasicAnimationWithKeyPath:@"transform.scale"];
    animation.fromValue = @0.7;
    animation.toValue = @1;
    animation.repeatCount = 1;
    animation.duration = 0.3;
    animation.autoreverses = NO;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

- (void)animationDidStart:(CAAnimation *)anim {
    if (anim == [_circle1 animationForKey:@"circle1_basicAnimation1"]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self configureScaleAnimationWithStop:YES];
        });
    }
//    else if (anim == [_circle1 animationForKey:@"circle1_basicAnimation2"]) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self configureAnimation];
//        });
//    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag == 1) {
        if (anim == [_circle1 animationForKey:@"circle1_basicAnimation2"]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self configureAnimation];
            });
        }
    }
    
}


@end
