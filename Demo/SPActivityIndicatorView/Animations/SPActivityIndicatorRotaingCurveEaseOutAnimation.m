//
//  SPActivityIndicatorRotaingCurveEaseOutAnimation.m
//  SPActivityIndicatorExample
//
//  Created by Libo on 2017/12/28.
//  Copyright © 2017年 iDress. All rights reserved.
//  旋转，曲线由快到慢不断循环

#import "SPActivityIndicatorRotaingCurveEaseOutAnimation.h"

static CGFloat lineWidth = 2.0f;

@implementation SPActivityIndicatorRotaingCurveEaseOutAnimation
{
    CADisplayLink *_link;
    CAShapeLayer *_shapeLayer;
    CGFloat _startAngle;
    CGFloat _endAngle;
    CGFloat _progress;
}

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    CGFloat oX = (layer.bounds.size.width-size.width)*0.5;
    CGFloat oY = (layer.bounds.size.height-size.height)*0.5;
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(oX, oY, size.width, size.height);
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = tintColor.CGColor;
    shapeLayer.lineWidth = lineWidth;
    shapeLayer.lineCap = kCALineCapRound;
    [layer addSublayer:shapeLayer];
    _shapeLayer = shapeLayer;
    
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    _link.paused = true;
    [_link setPaused:NO];
    
}

- (void)displayLinkAction {
    _progress += [self speed];
    if (_progress >= 1) {
        _progress = 0;
    }
    [self updateAnimationLayer];
}

- (void)updateAnimationLayer {
    _startAngle = -M_PI_2;
    _endAngle = -M_PI_2 +_progress * M_PI * 2;
    if (_endAngle > M_PI) {
        CGFloat progress1 = 1 - (1 - _progress)/0.25;
        _startAngle = -M_PI_2 + progress1 * M_PI * 2;
    }
    CGFloat radius = _shapeLayer.bounds.size.width/2.0f - lineWidth/2.0f;
    CGFloat centerX = _shapeLayer.bounds.size.width/2.0f;
    CGFloat centerY = _shapeLayer.bounds.size.height/2.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:_startAngle endAngle:_endAngle clockwise:true];
    path.lineCapStyle = kCGLineCapRound;
    
    _shapeLayer.path = path.CGPath;
}

- (CGFloat)speed {
    if (_endAngle > M_PI) {
        return 0.3/60.0f;
    }
    return 2/60.0f;
}

@end
