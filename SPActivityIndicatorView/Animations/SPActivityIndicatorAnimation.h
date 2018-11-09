//
//  SPActivityIndicatorAnimation.h
//  SPActivityIndicatorExample
//
//  Created by iDress on 8/10/16.
//  Copyright © 2016 iDress. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SPActivityIndicatorAnimationProtocol.h"

@interface SPActivityIndicatorAnimation : NSObject <SPActivityIndicatorAnimationProtocol>

- (CABasicAnimation *)createBasicAnimationWithKeyPath:(NSString *)keyPath;
- (CAKeyframeAnimation *)createKeyframeAnimationWithKeyPath:(NSString *)keyPath;
- (CAAnimationGroup *)createAnimationGroup;

@end
