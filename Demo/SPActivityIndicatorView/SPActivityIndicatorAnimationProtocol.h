//
//  SPActivityIndicatorAnimationProtocol.h
//  SPActivityIndicatorExample
//
//  Created by iDress on 5/23/15.
//  Copyright (c) 2015 iDress. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol SPActivityIndicatorAnimationProtocol <NSObject>

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor;

@end
