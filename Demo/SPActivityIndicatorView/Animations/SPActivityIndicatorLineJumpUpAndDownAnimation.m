//
//  SPActivityIndicatorLineJumpUpAndDownAnimation.m
//  SPActivityIndicatorView
//
//  Created by 乐升平 on 2018/11/19.
//  Copyright © 2018 乐升平. All rights reserved.
//

#import "SPActivityIndicatorLineJumpUpAndDownAnimation.h"

@implementation SPActivityIndicatorLineJumpUpAndDownAnimation
- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    //1.创建relicatorLayer对象
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame          = layer.bounds;
    [layer addSublayer:replicatorLayer];
    
    
    CGFloat count = 4;
    CGFloat lineH = size.height/2;
    CGFloat lineMarginX = 10;
    CGFloat lineInter = 10;
    CGFloat lineW = 5;
    
    //2.创建CALayer对象
    CALayer *lineLayer        = [CALayer layer];
    lineLayer.bounds          = CGRectMake(0, 0, lineW, lineH);
    lineLayer.position        = CGPointMake(lineMarginX, replicatorLayer.position.y);
    lineLayer.backgroundColor = tintColor.CGColor;
    
    [replicatorLayer addSublayer:lineLayer];
    
    
    replicatorLayer.instanceCount = count;
    
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(lineInter, 0, 0);
    
    
    //3.设置动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation.toValue           = @(lineH*0.5);
    animation.duration          = 0.5;
    animation.autoreverses      = YES;
    animation.repeatCount       = MAXFLOAT;
    animation.removedOnCompletion = NO;
    
    [lineLayer addAnimation:animation forKey:nil];
    
    replicatorLayer.instanceDelay = 0.5 / count;
}
@end
