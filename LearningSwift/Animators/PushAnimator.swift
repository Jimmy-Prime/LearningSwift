//
//  PushAnimator.swift
//  LearningSwift
//
//  Created by Prime on 8/23/16.
//  Copyright © 2016 prime. All rights reserved.
//

import UIKit
import pop

class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!

        fromView.tintAdjustmentMode = UIViewTintAdjustmentMode.Dimmed

        toView.frame = transitionContext.containerView()!.frame
        toView.center = CGPointMake((transitionContext.containerView()?.center.x)! * 3.0, (transitionContext.containerView()?.center.y)!)
        transitionContext.containerView()?.addSubview(toView)

        let translationAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionX)
        translationAnimation.toValue = transitionContext.containerView()?.center.x
        translationAnimation.springBounciness = 10.0
        translationAnimation.completionBlock = {(animation, finished) in
            transitionContext.completeTransition(true)
        }

        toView.layer.pop_addAnimation(translationAnimation, forKey: "translationPushAnimation")
    }
}
