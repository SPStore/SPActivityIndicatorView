//
//  SPActivityIndicatorView.h
//  SPActivityIndicatorExample
//
//  Created by iDress on 5/23/15.
//  Copyright (c) 2015 iDress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPActivityIndicatorAnimationProtocol.h"

typedef NS_ENUM(NSUInteger, SPActivityIndicatorAnimationType) {
    SPActivityIndicatorAnimationTypeNineDots,
    SPActivityIndicatorAnimationTypeTriplePulse,
    SPActivityIndicatorAnimationTypeFiveDots,
    SPActivityIndicatorAnimationTypeRotatingSquares,
    SPActivityIndicatorAnimationTypeDoubleBounce,
    SPActivityIndicatorAnimationTypeRippleAnimation,
    SPActivityIndicatorAnimationTypeTwoDots,
    SPActivityIndicatorAnimationTypeThreeDots,
    SPActivityIndicatorAnimationTypeBallPulse,
    SPActivityIndicatorAnimationTypeBallClipRotate,
    SPActivityIndicatorAnimationTypeBallClipRotatePulse,
    SPActivityIndicatorAnimationTypeBallClipRotateMultiple,
    SPActivityIndicatorAnimationTypeBallRotate,
    SPActivityIndicatorAnimationTypeBallZigZag,
    SPActivityIndicatorAnimationTypeBallZigZagDeflect,
    SPActivityIndicatorAnimationTypeBallTrianglePath,
    SPActivityIndicatorAnimationTypeBallScale,
    SPActivityIndicatorAnimationTypeLineScale,
    SPActivityIndicatorAnimationTypeLineScaleParty,
    SPActivityIndicatorAnimationTypeBallScaleMultiple,
    SPActivityIndicatorAnimationTypeBallPulseSync,
    SPActivityIndicatorAnimationTypeBallBeat,
    SPActivityIndicatorAnimationType3DotsFadeAnimation,
    SPActivityIndicatorAnimationTypeLineScalePulseOut,
    SPActivityIndicatorAnimationTypeLineScalePulseOutRapid,
    SPActivityIndicatorAnimationTypeLineJumpUpAndDownAnimation,
    SPActivityIndicatorAnimationTypeBallScaleRipple,
    SPActivityIndicatorAnimationTypeBallScaleRippleMultiple,
    SPActivityIndicatorAnimationTypeTriangleSkewSpin,
    SPActivityIndicatorAnimationTypeBallGridBeat,
    SPActivityIndicatorAnimationTypeBallGridPulse,
    SPActivityIndicatorAnimationTypeRotatingSandglass,
    SPActivityIndicatorAnimationTypeRotatingTrigons,
    SPActivityIndicatorAnimationTypeTripleRings,
    SPActivityIndicatorAnimationTypeCookieTerminator,
    SPActivityIndicatorAnimationTypeBallSpinFadeLoader,
    SPActivityIndicatorAnimationTypeBallLoopScale,
    SPActivityIndicatorAnimationTypeExchangePosition,
    SPActivityIndicatorAnimationTypeRotaingCurveEaseOut,
    SPActivityIndicatorAnimationTypeLoadingSuccess,
    SPActivityIndicatorAnimationTypeLoadingFail,
    SPActivityIndicatorAnimationTypeBallRotaingAroundBall,
};

@interface SPActivityIndicatorView : UIView

- (id)initWithType:(SPActivityIndicatorAnimationType)type;
- (id)initWithType:(SPActivityIndicatorAnimationType)type tintColor:(UIColor *)tintColor;
- (id)initWithType:(SPActivityIndicatorAnimationType)type tintColor:(UIColor *)tintColor size:(CGFloat)size;

@property (nonatomic) SPActivityIndicatorAnimationType type;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic) CGFloat size;

@property (nonatomic, readonly) BOOL animating;

+ (id<SPActivityIndicatorAnimationProtocol>)activityIndicatorAnimationForAnimationType:(SPActivityIndicatorAnimationType)type;

- (void)startAnimating;
- (void)stopAnimating;

@end
