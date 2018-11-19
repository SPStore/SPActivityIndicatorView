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
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation ViewController

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    self.view.backgroundColor = [UIColor colorWithRed:237/255.0f green:85/255.0f blue:101/255.0f alpha:1.0f];
    
    NSArray *activityTypes = @[@(SPActivityIndicatorAnimationTypeNineDots),
                               @(SPActivityIndicatorAnimationTypeTriplePulse),
                               @(SPActivityIndicatorAnimationTypeFiveDots),
                               @(SPActivityIndicatorAnimationTypeRotatingSquares),
                               @(SPActivityIndicatorAnimationTypeDoubleBounce),
                               @(SPActivityIndicatorAnimationTypeRippleAnimation),
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
                               @(SPActivityIndicatorAnimationType3DotsFadeAnimation),
                               @(SPActivityIndicatorAnimationTypeLineScalePulseOut),
                               @(SPActivityIndicatorAnimationTypeLineScalePulseOutRapid),
                               @(SPActivityIndicatorAnimationTypeLineJumpUpAndDownAnimation),
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
                               @(SPActivityIndicatorAnimationTypeBallLoopScale),
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
        self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(activityIndicatorView.frame));
        [activityIndicatorView startAnimating];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [activityIndicatorView addGestureRecognizer:tap];
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    SPActivityIndicatorView *activityIndicatorView = (SPActivityIndicatorView *)tap.view;
    id<SPActivityIndicatorAnimationProtocol> animation = [SPActivityIndicatorView activityIndicatorAnimationForAnimationType:activityIndicatorView.type];
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:NSStringFromClass([animation class]) message:nil preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertVc animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertVc dismissViewControllerAnimated:YES completion:nil];
    });
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), self.view.bounds.size.width, self.view.bounds.size.height-CGRectGetMaxY(self.titleLabel.frame));
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.frame = CGRectMake(0, isIPhoneX ? 44 : 20, self.view.bounds.size.width, 40);
        _titleLabel.text = @"单击每个动画显示对应的类名";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [self.view addSubview:_titleLabel];
    }
    return _titleLabel;
}

@end
