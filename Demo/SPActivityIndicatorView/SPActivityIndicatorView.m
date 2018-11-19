//
//  SPActivityIndicatorView.m
//  SPActivityIndicatorExample
//
//  Created by iDress on 5/23/15.
//  Copyright (c) 2015 iDress. All rights reserved.
//

#import "SPActivityIndicatorView.h"

#import "SPActivityIndicatorNineDotsAnimation.h"
#import "SPActivityIndicatorTriplePulseAnimation.h"
#import "SPActivityIndicatorFiveDotsAnimation.h"
#import "SPActivityIndicatorRotatingSquaresAnimation.h"
#import "SPActivityIndicatorDoubleBounceAnimation.h"
#import "SPActivityIndicatorRippleAnimation.h"
#import "SPActivityIndicatorTwoDotsAnimation.h"
#import "SPActivityIndicatorThreeDotsAnimation.h"
#import "SPActivityIndicatorBallPulseAnimation.h"
#import "SPActivityIndicatorBallClipRotateAnimation.h"
#import "SPActivityIndicatorBallClipRotatePulseAnimation.h"
#import "SPActivityIndicatorBallClipRotateMultipleAnimation.h"
#import "SPActivityIndicatorBallRotateAnimation.h"
#import "SPActivityIndicatorBallZigZagAnimation.h"
#import "SPActivityIndicatorBallZigZagDeflectAnimation.h"
#import "SPActivityIndicatorBallTrianglePathAnimation.h"
#import "SPActivityIndicatorBallScaleAnimation.h"
#import "SPActivityIndicatorLineScaleAnimation.h"
#import "SPActivityIndicatorLineScalePartyAnimation.h"
#import "SPActivityIndicatorBallScaleMultipleAnimation.h"
#import "SPActivityIndicatorBallPulseSyncAnimation.h"
#import "SPActivityIndicatorBallBeatAnimation.h"
#import "SPActivityIndicatorLineScalePulseOutAnimation.h"
#import "SPActivityIndicatorLineScalePulseOutRapidAnimation.h"
#import "SPActivityIndicatorLineJumpUpAndDownAnimation.h"
#import "SPActivityIndicatorBallScaleRippleAnimation.h"
#import "SPActivityIndicatorBallScaleRippleMultipleAnimation.h"
#import "SPActivityIndicatorTriangleSkewSpinAnimation.h"
#import "SPActivityIndicatorBallGridBeatAnimation.h"
#import "SPActivityIndicatorBallGridPulseAnimation.h"
#import "SPActivityIndicatorRotatingSandglassAnimation.h"
#import "SPActivityIndicatorRotatingTrigonAnimation.h"
#import "SPActivityIndicatorTripleRingsAnimation.h"
#import "SPActivityIndicatorCookieTerminatorAnimation.h"
#import "SPActivityIndicatorBallSpinFadeLoader.h"
#import "SPActivityIndicatorBallLoopScaleAnimation.h"
#import "SPActivityIndicator3DotsExchangePositionAnimation.h"
#import "SPActivityIndicatorRotaingCurveEaseOutAnimation.h"
#import "SPActivityIndicatorLoadingSuccessAnimation.h"
#import "SPActivityIndicatorLoadingFailAnimation.h"
#import "SPActivityIndicatorBallRotaingAroundBallAnimation.h"
#import "SPActivityIndicator3DotsFadeAnimation.h"

static const CGFloat kSPActivityIndicatorDefaultSize = 40.0f;

@interface SPActivityIndicatorView () {
    CALayer *_animationLayer;
}

@end

@implementation SPActivityIndicatorView

#pragma mark -
#pragma mark Constructors

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _tintColor = [UIColor whiteColor];
        _size = kSPActivityIndicatorDefaultSize;
        [self commonInit];
    }
    return self;
}

- (id)initWithType:(SPActivityIndicatorAnimationType)type {
    return [self initWithType:type tintColor:[UIColor whiteColor] size:kSPActivityIndicatorDefaultSize];
}

- (id)initWithType:(SPActivityIndicatorAnimationType)type tintColor:(UIColor *)tintColor {
    return [self initWithType:type tintColor:tintColor size:kSPActivityIndicatorDefaultSize];
}

- (id)initWithType:(SPActivityIndicatorAnimationType)type tintColor:(UIColor *)tintColor size:(CGFloat)size {
    self = [super init];
    if (self) {
        _type = type;
        _size = size;
        _tintColor = tintColor;
        [self commonInit];
    }
    return self;
}

#pragma mark -
#pragma mark Methods

- (void)commonInit {
    self.userInteractionEnabled = YES;
    self.hidden = YES;
    
    _animationLayer = [[CALayer alloc] init];
    _animationLayer.frame = self.layer.bounds;
    [self.layer addSublayer:_animationLayer];

    [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
}

- (void)setupAnimation {
    _animationLayer.sublayers = nil;
    
    id<SPActivityIndicatorAnimationProtocol> animation = [SPActivityIndicatorView activityIndicatorAnimationForAnimationType:_type];
    
    if ([animation respondsToSelector:@selector(setupAnimationInLayer:withSize:tintColor:)]) {
        [animation setupAnimationInLayer:_animationLayer withSize:CGSizeMake(_size, _size) tintColor:_tintColor];
        _animationLayer.speed = 0.0f;
    }
}

- (void)startAnimating {
    if (!_animationLayer.sublayers) {
        [self setupAnimation];
    }
    self.hidden = NO;
    _animationLayer.speed = 1.0f;
    _animating = YES;
}

- (void)stopAnimating {
    _animationLayer.speed = 0.0f;
    _animating = NO;
    self.hidden = YES;
}

#pragma mark -
#pragma mark Setters

- (void)setType:(SPActivityIndicatorAnimationType)type {
    if (_type != type) {
        _type = type;
        
        [self setupAnimation];
    }
}

- (void)setSize:(CGFloat)size {
    if (_size != size) {
        _size = size;
        
        [self setupAnimation];
        [self invalidateIntrinsicContentSize];
    }
}

- (void)setTintColor:(UIColor *)tintColor {
    if (![_tintColor isEqual:tintColor]) {
        _tintColor = tintColor;
        
        CGColorRef tintColorRef = tintColor.CGColor;
        for (CALayer *sublayer in _animationLayer.sublayers) {
            sublayer.backgroundColor = tintColorRef;
            
            if ([sublayer isKindOfClass:[CAShapeLayer class]]) {
                CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
                shapeLayer.strokeColor = tintColorRef;
                shapeLayer.fillColor = tintColorRef;
            }
        }
    }
}

#pragma mark -
#pragma mark Getters

+ (id<SPActivityIndicatorAnimationProtocol>)activityIndicatorAnimationForAnimationType:(SPActivityIndicatorAnimationType)type {
    switch (type) {
        case SPActivityIndicatorAnimationTypeNineDots:
            return [[SPActivityIndicatorNineDotsAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeTriplePulse:
            return [[SPActivityIndicatorTriplePulseAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeFiveDots:
            return [[SPActivityIndicatorFiveDotsAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeRotatingSquares:
            return [[SPActivityIndicatorRotatingSquaresAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeDoubleBounce:
            return [[SPActivityIndicatorDoubleBounceAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeRippleAnimation:
            return [[SPActivityIndicatorRippleAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeTwoDots:
            return [[SPActivityIndicatorTwoDotsAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeThreeDots:
            return [[SPActivityIndicatorThreeDotsAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeBallPulse:
            return [[SPActivityIndicatorBallPulseAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeBallClipRotate:
            return [[SPActivityIndicatorBallClipRotateAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeBallClipRotatePulse:
            return [[SPActivityIndicatorBallClipRotatePulseAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeBallClipRotateMultiple:
            return [[SPActivityIndicatorBallClipRotateMultipleAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeBallRotate:
            return [[SPActivityIndicatorBallRotateAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeBallZigZag:
            return [[SPActivityIndicatorBallZigZagAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeBallZigZagDeflect:
            return [[SPActivityIndicatorBallZigZagDeflectAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeBallTrianglePath:
            return [[SPActivityIndicatorBallTrianglePathAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeBallScale:
            return [[SPActivityIndicatorBallScaleAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeLineScale:
            return [[SPActivityIndicatorLineScaleAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeLineScaleParty:
            return [[SPActivityIndicatorLineScalePartyAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeBallScaleMultiple:
            return [[SPActivityIndicatorBallScaleMultipleAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeBallPulseSync:
            return [[SPActivityIndicatorBallPulseSyncAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeBallBeat:
            return [[SPActivityIndicatorBallBeatAnimation alloc] init];
        case SPActivityIndicatorAnimationType3DotsFadeAnimation:
            return [[SPActivityIndicator3DotsFadeAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeLineScalePulseOut:
            return [[SPActivityIndicatorLineScalePulseOutAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeLineScalePulseOutRapid:
            return [[SPActivityIndicatorLineScalePulseOutRapidAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeLineJumpUpAndDownAnimation:
            return [[SPActivityIndicatorLineJumpUpAndDownAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeBallScaleRipple:
            return [[SPActivityIndicatorBallScaleRippleAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeBallScaleRippleMultiple:
            return [[SPActivityIndicatorBallScaleRippleMultipleAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeTriangleSkewSpin:
            return [[SPActivityIndicatorTriangleSkewSpinAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeBallGridBeat:
            return [[SPActivityIndicatorBallGridBeatAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeBallGridPulse:
            return [[SPActivityIndicatorBallGridPulseAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeRotatingSandglass:
            return [[SPActivityIndicatorRotatingSandglassAnimation alloc]init];
        case SPActivityIndicatorAnimationTypeRotatingTrigons:
            return [[SPActivityIndicatorRotatingTrigonAnimation alloc]init];
        case SPActivityIndicatorAnimationTypeTripleRings:
            return [[SPActivityIndicatorTripleRingsAnimation alloc]init];
        case SPActivityIndicatorAnimationTypeCookieTerminator:
            return [[SPActivityIndicatorCookieTerminatorAnimation alloc]init];
        case SPActivityIndicatorAnimationTypeBallSpinFadeLoader:
            return [[SPActivityIndicatorBallSpinFadeLoader alloc] init];
        case SPActivityIndicatorAnimationTypeBallLoopScale:
            return [[SPActivityIndicatorBallLoopScaleAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeExchangePosition:
            return [[SPActivityIndicator3DotsExchangePositionAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeRotaingCurveEaseOut:
            return [[SPActivityIndicatorRotaingCurveEaseOutAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeLoadingSuccess:
            return [[SPActivityIndicatorLoadingSuccessAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeLoadingFail:
            return [[SPActivityIndicatorLoadingFailAnimation alloc] init];
        case SPActivityIndicatorAnimationTypeBallRotaingAroundBall:
            return [[SPActivityIndicatorBallRotaingAroundBallAnimation alloc] init];
            
    }
    return nil;
}

#pragma mark -
#pragma mark Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _animationLayer.frame = self.bounds;

    BOOL animating = _animating;

    if (animating)
        [self stopAnimating];

    [self setupAnimation];

    if (animating)
        [self startAnimating];
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(_size, _size);
}

@end
