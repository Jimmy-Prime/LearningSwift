//
//  Switch.swift
//  LearningSwift
//
//  Created by Prime on 9/6/16.
//  Copyright © 2016 prime. All rights reserved.
//

import UIKit
import pop

class Switch: UIView {
    private let background = UIView()
    private let thumb = UIView()
    private let slash0 = UIView()
    private let slash1 = UIView()

    private let thumbScale: CGFloat = 0.8

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(background)
        self.addSubview(thumb)
        thumb.addSubview(slash0)
        thumb.addSubview(slash1)

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tap(_:)))
        self.addGestureRecognizer(tap)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


    override var frame: CGRect {
        didSet {
            if frame == CGRectZero {
                return
            }

            var innerFrame = frame
            innerFrame.origin = CGPointZero
            background.frame = innerFrame

            let path = UIBezierPath(roundedRect: innerFrame, cornerRadius: frame.size.height / 2.0)
            let layer = CAShapeLayer()
            layer.path = path.CGPath
            background.layer.mask = layer

            thumb.layer.cornerRadius = frame.size.height * thumbScale / 2.0

            let thumbWidth = frame.size.height * thumbScale
            slash0.layer.cornerRadius = thumbWidth * 0.1 / 2.0
            slash1.layer.cornerRadius = thumbWidth * 0.1 / 2.0

            setViews(false)
        }
    }

    var on: Bool = false {
        willSet {
            if newValue == on {
                return
            }
        }
        didSet {
            setViews(true)
        }
    }

    var bgTintColor: UIColor! {
        didSet {
            background.backgroundColor = bgTintColor
        }
    }

    var lineTintColor: UIColor! = UIColor.clearColor() {
        didSet {
            slash0.backgroundColor = lineTintColor
            slash1.backgroundColor = lineTintColor
        }
    }

    var onTintColor: UIColor! = UIColor.clearColor() {
        didSet {
            if on {
                thumb.backgroundColor = onTintColor
            }
        }
    }

    var offTintColor: UIColor! = UIColor.clearColor() {
        didSet {
            if !on {
                thumb.backgroundColor = offTintColor
            }
        }
    }

    @objc private func tap(tap: UITapGestureRecognizer) {
        on = !on
    }

    private func setViews(animated: Bool) {
        let thumbFrame = POPBasicAnimation(propertyNamed: kPOPViewFrame)
        let thumbWidth = frame.size.height * thumbScale
        let thumbOffset = frame.size.height * (1.0 - thumbScale) / 2.0
        thumbFrame.duration = animated ? 0.4 : 0.0

        let thumbBackgroundColor = POPBasicAnimation(propertyNamed: kPOPViewBackgroundColor)
        thumbBackgroundColor.duration = animated ? 0.4 : 0.0

        let slash0Bounds = POPBasicAnimation(propertyNamed: kPOPViewBounds)
        slash0Bounds.duration = animated ? 0.4 : 0.0

        let slash0Center = POPBasicAnimation(propertyNamed: kPOPViewCenter)
        slash0Center.duration = animated ? 0.4 : 0.0

        let slash0Rotation = POPBasicAnimation(propertyNamed: kPOPLayerRotation)
        slash0Rotation.duration = animated ? 0.4 : 0.0

        let slash1Bounds = POPBasicAnimation(propertyNamed: kPOPViewBounds)
        slash1Bounds.duration = animated ? 0.4 : 0.0

        let slash1Center = POPBasicAnimation(propertyNamed: kPOPViewCenter)
        slash1Center.duration = animated ? 0.4 : 0.0

        let slash1Rotation = POPBasicAnimation(propertyNamed: kPOPLayerRotation)
        slash1Rotation.duration = animated ? 0.4 : 0.0

        if on {
            thumbFrame.toValue = NSValue(CGRect: CGRectMake(frame.size.width - frame.size.height + thumbOffset, thumbOffset, thumbWidth, thumbWidth))
            thumbBackgroundColor.toValue = onTintColor

            slash0Bounds.toValue = NSValue(CGRect: CGRectMake(0, 0, thumbWidth * 0.3, thumbWidth * 0.1))
            slash0Center.toValue = NSValue(CGPoint: CGPointMake(thumbWidth / 3.0, thumbWidth * 2.0 / 3.0))
            slash0Rotation.toValue = M_PI_4

            slash1Bounds.toValue = NSValue(CGRect: CGRectMake(0, 0, thumbWidth * 0.6, thumbWidth * 0.1))
            slash1Center.toValue = NSValue(CGPoint: CGPointMake(thumbWidth * 2.0 / 3.0, thumbWidth / 2.0))
            slash1Rotation.toValue = -M_PI_4
        }
        else {
            thumbFrame.toValue = NSValue(CGRect: CGRectMake(thumbOffset, thumbOffset, thumbWidth, thumbWidth))
            thumbBackgroundColor.toValue = offTintColor

            slash0Bounds.toValue = NSValue(CGRect: CGRectMake(0, 0, thumbWidth * 0.6, thumbWidth * 0.1))
            slash0Center.toValue = NSValue(CGPoint: CGPointMake(thumbWidth / 2.0, thumbWidth / 2.0))
            slash0Rotation.toValue = -M_PI_4

            slash1Bounds.toValue = NSValue(CGRect: CGRectMake(0, 0, thumbWidth * 0.6, thumbWidth * 0.1))
            slash1Center.toValue = NSValue(CGPoint: CGPointMake(thumbWidth / 2.0, thumbWidth / 2.0))
            slash1Rotation.toValue = M_PI_4
        }

        thumb.pop_addAnimation(thumbFrame, forKey: "Frame")
        thumb.pop_addAnimation(thumbBackgroundColor, forKey: "BackgroundColor")

        slash0.pop_addAnimation(slash0Bounds, forKey: "Bounds")
        slash0.pop_addAnimation(slash0Center, forKey: "Center")
        slash0.layer.pop_addAnimation(slash0Rotation, forKey: "Rotation")

        slash1.pop_addAnimation(slash1Bounds, forKey: "Bounds")
        slash1.pop_addAnimation(slash1Center, forKey: "Center")
        slash1.layer.pop_addAnimation(slash1Rotation, forKey: "Rotation")

        thumbBackgroundColor.completionBlock = {(animation, finished) in
            self.thumb.backgroundColor = self.on ? self.onTintColor : self.offTintColor
        }
    }
}
