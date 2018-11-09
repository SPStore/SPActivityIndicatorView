//
//  ViewController.m
//  SPActivityIndicatorView
//
//  Created by 乐升平 on 2018/11/9.
//  Copyright © 2018 乐升平. All rights reserved.
//

#import "ViewController.h"
#import "SPActivityIndicatorView.h"

#define SPScreenWidth [UIScreen mainScreen].bounds.size.width
#define SPScreenHeight [UIScreen mainScreen].bounds.size.height
#define isIPhoneX MAX(SPScreenWidth, SPScreenHeight) >= 812

@interface ViewController()
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation ViewController

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    self.view.backgroundColor = [UIColor colorWithRed:237/255.0f green:85/255.0f blue:101/255.0f alpha:1.0f];
    
    [self.view addSubview:self.scrollView];
    
    NSArray *activityTypes = @[@(SPActivityIndicatorAnimationTypeNineDots),
                               @(SPActivityIndicatorAnimationTypeTriplePulse),
                               @(SPActivityIndicatorAnimationTypeFiveDots),
                               @(SPActivityIndicatorAnimationTypeRotatingSquares),
                               @(SPActivityIndicatorAnimationTypeDoubleBounce),
                               @(SPActivityIndicatorAnimationTypeTwoDots),
                               @(SPActivityIndicatorAnimationTypeThreeDots),
                               @(SPActivityIndicatorAnimationTypeBallPulse),
                               @(SPActivityIndicatorAnimationTypeBallClipRotate),
                               @(SPActivityIndicatorAnimationTypeBallClipRotatePulse),
                               @(SPActivityIndicatorAnimationTypeBallClipRotateMultiple),
                               @(SPActivityIndicatorAnimationTypeBallRotate),
                               @(SPActivityIndicatorAnimationTypeBallZigZag),
                               @(SPActivityIndicatorAnimationTypeBallZigZagDeflect),
                               @(SPActivityIndicatorAnimationTypeBallTrianglePath),
                               @(SPActivityIndicatorAnimationTypeBallScale),
                               @(SPActivityIndicatorAnimationTypeLineScale),
                               @(SPActivityIndicatorAnimationTypeLineScaleParty),
                               @(SPActivityIndicatorAnimationTypeBallScaleMultiple),
                               @(SPActivityIndicatorAnimationTypeBallPulseSync),
                               @(SPActivityIndicatorAnimationTypeBallBeat),
                               @(SPActivityIndicatorAnimationTypeLineScalePulseOut),
                               @(SPActivityIndicatorAnimationTypeLineScalePulseOutRapid),
                               @(SPActivityIndicatorAnimationTypeBallScaleRipple),
                               @(SPActivityIndicatorAnimationTypeBallScaleRippleMultiple),
                               @(SPActivityIndicatorAnimationTypeTriangleSkewSpin),
                               @(SPActivityIndicatorAnimationTypeBallGridBeat),
                               @(SPActivityIndicatorAnimationTypeBallGridPulse),
                               @(SPActivityIndicatorAnimationTypeRotatingSandglass),
                               @(SPActivityIndicatorAnimationTypeRotatingTrigons),
                               @(SPActivityIndicatorAnimationTypeTripleRings),
                               @(SPActivityIndicatorAnimationTypeCookieTerminator),
                               @(SPActivityIndicatorAnimationTypeBallSpinFadeLoader),
                               @(SPActivityIndicatorAnimationTypeExchangePosition),
                               @(SPActivityIndicatorAnimationTypeRotaingCurveEaseOut),
                               @(SPActivityIndicatorAnimationTypeLoadingSuccess),
                               @(SPActivityIndicatorAnimationTypeLoadingFail),
                               @(SPActivityIndicatorAnimationTypeBallRotaingAroundBall)];
    
    NSInteger col = 5; // 列数
    NSInteger row = (activityTypes.count%col == 0 ? activityTypes.count/col : (activityTypes.count/col+1)); // 共有多少行
    for (int i = 0; i < activityTypes.count; i++) {
        SPActivityIndicatorView *activityIndicatorView = [[SPActivityIndicatorView alloc] initWithType:(SPActivityIndicatorAnimationType)[activityTypes[i] integerValue] tintColor:[UIColor whiteColor]];
        CGFloat width = self.view.bounds.size.width / col; // 每行排5个(5列)
        CGFloat height = width;
        CGFloat padding = (self.scrollView.bounds.size.height-row*height)/(activityTypes.count-1);
        activityIndicatorView.frame = CGRectMake(width * (i % col), (height+padding) * (int)(i / col), width, height);
        [self.scrollView addSubview:activityIndicatorView];
        [activityIndicatorView startAnimating];
    }
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(0, isIPhoneX ? 44 : 20, self.view.bounds.size.width, self.view.bounds.size.height);
    }
    return _scrollView;
}


@end
