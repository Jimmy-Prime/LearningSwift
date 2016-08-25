//
//  PopAnimator.swift
//  LearningSwift
//
//  Created by Prime on 8/23/16.
//  Copyright © 2016 prime. All rights reserved.
//

import UIKit
import pop

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!

        toView.tintAdjustmentMode = UIViewTintAdjustmentMode.Normal
        toView.frame = transitionContext.containerView()!.frame
        transitionContext.containerView()?.addSubview(toView)
        transitionContext.containerView()?.sendSubviewToBack(toView)

        UIGraphicsBeginImageContext(fromView.frame.size)
        fromView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        let width = fromView.frame.size.width / 2.0
        let height = fromView.frame.size.height / 4.0

        for y in 0...3 {
            for x in 0...1 {
                let frame = CGRectMake(CGFloat(x) * width, CGFloat(y) * height, width, height)
                let croppedCGImage = CGImageCreateWithImageInRect(image.CGImage, frame)
                let croppedImage = UIImage(CGImage: croppedCGImage!)

                let imageView = UIImageView(image: croppedImage)
                imageView.frame = frame

                transitionContext.containerView()?.addSubview(imageView)

                let translationAnimation = POPSpringAnimation(propertyNamed: kPOPViewCenter)
                translationAnimation.toValue = NSValue(CGPoint: CGPointMake(
                    3.0 * imageView.center.x - 2.0 * transitionContext.containerView()!.center.x, // P - 2*(c-P) = 3*P - 2*c
                    3.0 * imageView.center.y - 2.0 * transitionContext.containerView()!.center.y
                ))

                translationAnimation.completionBlock = {(animation, finished) in
                    imageView.removeFromSuperview()
                }

                translationAnimation.beginTime = CACurrentMediaTime() + drand48() * 0.5
                imageView.pop_addAnimation(translationAnimation, forKey: "translationPopAnimation")
            }
        }

        transitionContext.completeTransition(true)
    }
}
