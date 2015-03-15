//
//  AKCircleMaskTransitionController.m
//
//  Created by Ali Karagoz on 16/12/14.
//  Copyright (c) 2014 Ali Karagoz. All rights reserved.
//

#import "AKCircleMaskTransitionController.h"

static NSTimeInterval const AKTransitionDefaultDuration = 0.5;

typedef NS_ENUM(NSUInteger, AKTransitionStatus) {
    AKTransitionStatusShow,
    AKTransitionStatusDismiss
};

@interface AKCircleMaskTransitionController ()

@property (nonatomic, assign) AKTransitionStatus transitionStatus;
@property (nonatomic, strong) UIView *maskingView;

@end

@implementation AKCircleMaskTransitionController

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _transitionStatus = AKTransitionStatusShow;
    _duration = AKTransitionDefaultDuration;
    _center = CGPointZero;
    
    return self;
}

- (instancetype)initWithCenter:(CGPoint)center {
    
    self = [self init];
    if (!self) {
        return nil;
    }
    
    _center = center;
    
    return self;
}

#pragma mark - Transition Show / Dismiss

- (void)animateShowingTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    // Getting useful references.
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = transitionContext.containerView;
    
    CGFloat radius = [self radiusWithPoint:self.center rect:containerView.frame];
    CGRect fromRect = CGRectMake(self.center.x, self.center.y, 0.0, 0.0);
    CGRect toRect = CGRectMake(self.center.x - radius, self.center.y - radius, radius * 2.0, radius * 2.0);
    
    // Masking View
    self.maskingView = [[UIView alloc] init];
    self.maskingView.layer.masksToBounds = YES;
    self.maskingView.frame = toRect;
    [containerView addSubview:self.maskingView];
    
    // To View
    toViewController.view.frame = containerView.bounds;
    [self.maskingView addSubview:toViewController.view];
    
    // Animation
    [CATransaction begin];
    
    CABasicAnimation *cornerAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    cornerAnimation.fromValue = @(0);
    cornerAnimation.toValue = @(radius);
    self.maskingView.layer.cornerRadius = radius;
    
    CABasicAnimation *sizeAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    sizeAnimation.fromValue = [NSValue valueWithCGRect:fromRect];
    sizeAnimation.toValue = [NSValue valueWithCGRect:toRect];
    self.maskingView.layer.bounds = toRect;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = self.duration;
    animationGroup.animations = @[cornerAnimation, sizeAnimation];
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4 :0.0 :0.2 :1.0];
    
    CATransaction.completionBlock = ^{
        [toViewController.view removeFromSuperview];
        [containerView addSubview:toViewController.view];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    };
    
    [self.maskingView.layer addAnimation:animationGroup forKey:@"animations"];
    
    [CATransaction commit];
}

- (void)animateDismissingTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    // Getting useful references.
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = transitionContext.containerView;
    
    CGFloat radius = [self radiusWithPoint:self.center rect:containerView.frame];
    CGRect fromRect = CGRectMake(self.center.x - radius, self.center.y - radius, radius * 2.0, radius * 2.0);
    CGRect toRect = CGRectMake(self.center.x, self.center.y, 0.0, 0.0);
    
    // To View
    [self.maskingView addSubview:fromViewController.view];
    
    // Animations
    [CATransaction begin];
    
    CABasicAnimation *cornerAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    cornerAnimation.fromValue = @(radius);
    cornerAnimation.toValue = @(0);
    self.maskingView.layer.cornerRadius = radius;
    
    CABasicAnimation *sizeAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    sizeAnimation.fromValue = [NSValue valueWithCGRect:fromRect];
    sizeAnimation.toValue = [NSValue valueWithCGRect:toRect];
    self.maskingView.layer.bounds = toRect;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = self.duration;
    animationGroup.animations = @[cornerAnimation, sizeAnimation];
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4 :0.0 :0.2 :1.0];
    
    CATransaction.completionBlock = ^{
        [fromViewController.view removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    };
    
    [self.maskingView.layer addAnimation:animationGroup forKey:@"animations"];
    
    [CATransaction commit];
}

#pragma mark - Utils

- (CGFloat)radiusWithPoint:(CGPoint)point rect:(CGRect)rect {
    
    CGFloat distX, distY;
    CGFloat distA, distB, distC, distD;
    
    // Dist A
    distX = point.x - CGRectGetMinX(rect);
    distY = point.y - CGRectGetMinY(rect);
    distA = [self hypotenuseWithDistX:distX distY:distY];
    
    // Dist B
    distX = point.x - CGRectGetMaxX(rect);
    distY = point.y - CGRectGetMinY(rect);
    distB = [self hypotenuseWithDistX:distX distY:distY];
    
    // Dist C
    distX = point.x - CGRectGetMaxX(rect);
    distY = point.y - CGRectGetMaxY(rect);
    distC = [self hypotenuseWithDistX:distX distY:distY];
    
    // Dist D
    distX = point.x - CGRectGetMinX(rect);
    distY = point.y - CGRectGetMaxY(rect);
    distD = [self hypotenuseWithDistX:distX distY:distY];
    
    return fmaxf(fmaxf(fmax(distA, distB), distC), distD);
}

- (CGFloat)hypotenuseWithDistX:(CGFloat)distX distY:(CGFloat)distY {
    return sqrt(distX * distX + distY * distY);
}

#pragma mark - <UIViewControllerTransitioningDelegate>

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.transitionStatus = AKTransitionStatusShow;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.transitionStatus = AKTransitionStatusDismiss;
    return self;
}

#pragma mark - <UIViewControllerAnimatedTransitioning>

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    switch (self.transitionStatus) {
            
        case AKTransitionStatusShow: {
            [self animateShowingTransition:transitionContext];
        } break;
            
        case AKTransitionStatusDismiss: {
            [self animateDismissingTransition:transitionContext];
        } break;
    }
}

@end
