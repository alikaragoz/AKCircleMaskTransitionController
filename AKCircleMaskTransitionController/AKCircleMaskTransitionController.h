//
//  AKCircleMaskTransitionController.h
//
//  Created by Ali Karagoz on 16/12/14.
//  Copyright (c) 2014 Ali Karagoz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AKCircleMaskTransitionController : NSObject <UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate>

/*!
 * Duration of the animation in seconds.
 * Default duration is 0.5.
 */
@property (readwrite, nonatomic, assign) NSTimeInterval duration;

/*!
 * Center of the animated circle center.
 */
@property (readwrite, nonatomic, assign) CGPoint center;

/*!
 * Convenient initializer which allows you to directly pass the circle's center.
 *
 * @param point Center of the animated circle center.
 *
 * @return returns an instance of the transition controller with the provided point.
 */
- (instancetype)initWithCenter:(CGPoint)center;

@end
