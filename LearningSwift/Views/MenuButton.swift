//
//  MenuButton.swift
//  LearningSwift
//
//  Created by Prime on 8/23/16.
//  Copyright © 2016 prime. All rights reserved.
//

import UIKit
import pop

class MenuButton: UIButton {
    private var upLine: UIView = UIView()
    private var midLine: UIView = UIView()
    private var downLine: UIView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addTarget(self, action: #selector(tap), forControlEvents: UIControlEvents.TouchUpInside)

        upLine.userInteractionEnabled = false
        midLine.userInteractionEnabled = false
        downLine.userInteractionEnabled = false

        upLine.exclusiveTouch = false
        midLine.exclusiveTouch = false
        downLine.exclusiveTouch = false
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

// MARK: - Setters
    override var frame: CGRect {
        didSet {
            if self.frame == CGRectZero {
                return
            }

            self.layer.cornerRadius = self.frame.size.width / 2.0
            self.clipsToBounds = true

            let width = self.frame.size.width * 0.6
            let height = self.frame.size.height * 0.08
            let corner = height / 2.0
            let lineFrame = CGRectMake(0, 0, width, height)

            self.upLine.frame = lineFrame
            self.upLine.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height * 0.3)
            self.upLine.layer.cornerRadius = corner
            self.addSubview(upLine)

            self.midLine.frame = lineFrame
            self.midLine.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height * 0.5)
            self.midLine.layer.cornerRadius = corner
            self.addSubview(midLine)

            self.downLine.frame = lineFrame
            self.downLine.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height * 0.7)
            self.downLine.layer.cornerRadius = corner
            self.addSubview(downLine)
        }
    }

    override var tintColor: UIColor! {
        didSet {
            self.upLine.backgroundColor = self.tintColor
            self.midLine.backgroundColor = self.tintColor
            self.downLine.backgroundColor = self.tintColor
        }
    }

    var popped: Bool = false {
        didSet {
            let rotate = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
            let upCenter = POPSpringAnimation(propertyNamed: kPOPViewCenter)
            let upRotate = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
            let midAlpha = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
            let downCenter = POPSpringAnimation(propertyNamed: kPOPViewCenter)
            let downRotate = POPSpringAnimation(propertyNamed: kPOPLayerRotation)

            if popped == true {
                rotate.toValue = M_PI
                upCenter.toValue = NSValue(CGPoint: CGPointMake(self.frame.size.width / 2.0, self.frame.size.height * 0.5))
                upRotate.toValue = M_PI_4
                midAlpha.toValue = 0.0
                downCenter.toValue = NSValue(CGPoint: CGPointMake(self.frame.size.width / 2.0, self.frame.size.height * 0.5))
                downRotate.toValue = -M_PI_4
            }
            else {
                rotate.toValue = 0.0
                upCenter.toValue = NSValue(CGPoint: CGPointMake(self.frame.size.width / 2.0, self.frame.size.height * 0.3))
                upRotate.toValue = 0.0
                midAlpha.toValue = 1.0
                downCenter.toValue = NSValue(CGPoint: CGPointMake(self.frame.size.width / 2.0, self.frame.size.height * 0.7))
                downRotate.toValue = 0.0
            }

            self.layer.pop_addAnimation(rotate, forKey: "RotateAnimation")
            self.upLine.pop_addAnimation(upCenter, forKey: "CenterAnimation")
            self.upLine.layer.pop_addAnimation(upRotate, forKey: "RotateAnimation")
            self.midLine.pop_addAnimation(midAlpha, forKey: "AlphaAnimation")
            self.downLine.pop_addAnimation(downCenter, forKey: "CenterAnimation")
            self.downLine.layer.pop_addAnimation(downRotate, forKey: "RotateAnimation")
        }
    }

    @objc private func tap() {
        self.popped = !self.popped
    }
}
