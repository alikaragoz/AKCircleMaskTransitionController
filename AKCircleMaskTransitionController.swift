//
//  AKCircleMaskTransitionController.swift
//
//  Created by Ali Karagoz and Willow Bumby on 05/03/2015.
//  Copyright (c) 2015-2016 Ali Karagoz. All rights reserved.
//

import UIKit

enum AKTransitionStatus: UInt {
    case Show
    case Dismiss
}

class AKCircleMaskTransitionController: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    // Duration of the animation in seconds
    // Default duration is 0.5
    let duration: NSTimeInterval = 0.5
    
    // Center of the animated circle
    var center = CGPointZero

    var transitionStatus: AKTransitionStatus = .Show
    var maskingView = UIView()
    
    // MARK: Transition Show / Dismiss
    func animateShowingTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        // Getting useful references.
        let toViewController: UIViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        guard let containerView = transitionContext.containerView() else { return }
        
        let radius = radiusWithPoint(center, rect: containerView.frame)
        let fromRect = CGRect(x: center.x, y: center.y, width: 0.0, height: 0.0)
        let toRect = CGRect(x: center.x - radius, y: center.y - radius, width: radius * 2.0, height: radius * 2.0)
        
        // Masking View
        maskingView.layer.masksToBounds = true
        maskingView.frame = toRect
        containerView.addSubview(maskingView)
        
        // To View
        toViewController.view.frame = containerView.bounds
        maskingView.addSubview(toViewController.view)
        
        // Animation
        CATransaction.begin()
    
        let cornerAnimation = CABasicAnimation(keyPath: "cornerRadius")
        cornerAnimation.fromValue = NSNumber(integer: 0)
        cornerAnimation.toValue = NSNumber(float: Float(radius))
        maskingView.layer.cornerRadius = radius
        
        let sizeAnimation = CABasicAnimation(keyPath: "bounds")
        sizeAnimation.fromValue = NSValue(CGRect: fromRect)
        sizeAnimation.toValue = NSValue(CGRect: toRect)
        maskingView.layer.bounds = toRect
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = duration
        animationGroup.animations = [cornerAnimation, sizeAnimation]
        animationGroup.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0.0, 0.2, 1.0)
        
        CATransaction.setCompletionBlock { () -> Void in
            toViewController.view.removeFromSuperview()
            containerView.addSubview(toViewController.view)
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
        
        maskingView.layer.addAnimation(animationGroup, forKey: "animations")
        CATransaction.commit()
    }
    
    func animateDismissingTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        // Getting useful references.
        let fromViewController: UIViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        guard let containerView = transitionContext.containerView() else { return }
        
        let radius = radiusWithPoint(center, rect: containerView.frame)
        let fromRect = CGRect(x: center.x - radius, y: center.y - radius, width: radius * 2.0, height: radius * 2.0)
        let toRect = CGRect(x: center.x, y: center.y, width: 0.0, height: 0.0)
        
        // To View
        maskingView.addSubview(fromViewController.view)
        
        // Animations
        CATransaction.begin()
        
        let cornerAnimation = CABasicAnimation(keyPath: "cornerRadius")
        cornerAnimation.fromValue = NSNumber(float: Float(radius))
        cornerAnimation.toValue = NSNumber(integer: 0)
        maskingView.layer.cornerRadius = radius
        
        let sizeAnimation = CABasicAnimation(keyPath: "bounds")
        sizeAnimation.fromValue = NSValue(CGRect: fromRect)
        sizeAnimation.toValue = NSValue(CGRect: toRect)
        maskingView.layer.bounds = toRect
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = duration
        animationGroup.animations = [cornerAnimation, sizeAnimation]
        animationGroup.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0.0, 0.2, 1.0)
        
        CATransaction.setCompletionBlock { () -> Void in
            fromViewController.view.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
        
        maskingView.layer.addAnimation(animationGroup, forKey: "animations")
        CATransaction.commit()
    }
    
    // MARK: Utilities
    func radiusWithPoint(point: CGPoint, rect: CGRect) -> CGFloat {
        var distX: CGFloat?
        var distY: CGFloat?
        var distA: CGFloat?
        var distB: CGFloat?
        var distC: CGFloat?
        var distD: CGFloat?
        
        // Dist A
        distX = point.x - CGRectGetMinX(rect)
        distY = point.y - CGRectGetMinY(rect)
        distA = hypotenuseWithDistX(distX!, distY: distY!)
        
        // Dist B
        distX = point.x - CGRectGetMaxX(rect)
        distY = point.y - CGRectGetMinY(rect)
        distB = hypotenuseWithDistX(distX!, distY: distY!)
        
        // Dist C
        distX = point.x - CGRectGetMaxX(rect)
        distY = point.y - CGRectGetMaxY(rect)
        distC = hypotenuseWithDistX(distX!, distY: distY!)
        
        // Dist D
        distX = point.x - CGRectGetMinX(rect)
        distY = point.y - CGRectGetMaxY(rect)
        distD = hypotenuseWithDistX(distX!, distY: distY!)
        
        return fmax(fmax(fmax(distA!, distB!), distC!), distD!)
    }
    
    func hypotenuseWithDistX(distX: CGFloat, distY: CGFloat) -> CGFloat {
        return sqrt(distX * distX + distY * distY)
    }
    
    // MARK: UIViewControllerTransitioningDelegate
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitionStatus = .Show

        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitionStatus = .Dismiss

        return self
    }
    
    // MARK: UIViewControllerAnimatedTransitioning
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        switch self.transitionStatus {
        case .Show:
            self.animateShowingTransition(transitionContext)
        case .Dismiss:
            self.animateDismissingTransition(transitionContext)
        }
    }
}
