//
//  WSwipeViewController.swift
//  LearningSwift
//
//  Created by Prime on 8/25/16.
//  Copyright © 2016 prime. All rights reserved.
//

import UIKit
import pop

class WSwipeViewController: UIViewController {
    var squares: [UIView] = [UIView]()
    var centers: [CGPoint] = [CGPoint]()

    let leftBlock = UIView()
    let midBlock = UIView()
    let rightBlock = UIView()

    var leftBlockCenter: CGPoint = CGPointZero
    var midBlockCenter: CGPoint = CGPointZero
    var rightBlockCenter: CGPoint = CGPointZero

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()

        self.setupViews()

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeLeft))
        swipeLeft.direction = .Left
        self.view.addGestureRecognizer(swipeLeft(_:))

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeRight(_:)))
        swipeRight.direction = .Right
        self.view.addGestureRecognizer(swipeRight)
    }

    func setupViews() {
        // squares
        let leftSquare3 = UIView()
        let leftSquare2 = UIView()
        let leftSquare = UIView()
        let midSquare = UIView()
        let rightSquare = UIView()
        let rightSquare2 = UIView()
        let rightSquare3 = UIView()

        self.squares.appendContentsOf([
            leftSquare3,
            leftSquare2,
            leftSquare,
            midSquare,
            rightSquare,
            rightSquare2,
            rightSquare3])

        let width: CGFloat = 150
        let sizeFrame = CGRectMake(0, 0, width, width)

        for view in squares {
            view.frame = sizeFrame
            view.backgroundColor = self.randomColor()
            view.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
            self.view.addSubview(view)
        }

        midSquare.center = CGPointMake(self.view.center.x, 200)
        let midCenter = midSquare.center

        leftSquare.center = CGPointMake(midSquare.center.x - width / sqrt(2.0), midSquare.center.y + width / sqrt(2.0))
        let leftCenter = leftSquare.center

        rightSquare.center = CGPointMake(midSquare.center.x + width / sqrt(2.0), midSquare.center.y + width / sqrt(2.0))
        let rightCenter = rightSquare.center

        leftSquare2.center = CGPointMake(midSquare.center.x - width * sqrt(2.0), midSquare.center.y)
        let leftCenter2 = leftSquare2.center

        leftSquare3.center = CGPointMake(leftSquare2.center.x - width / sqrt(2.0), leftSquare2.center.y - width / sqrt(2.0))
        let leftCenter3 = leftSquare3.center

        rightSquare2.center = CGPointMake(midSquare.center.x + width * sqrt(2.0), midSquare.center.y)
        let rightCenter2 = rightSquare2.center

        rightSquare3.center = CGPointMake(rightSquare2.center.x + width / sqrt(2.0), rightSquare2.center.y - width / sqrt(2.0))
        let rightCenter3 = rightSquare3.center

        self.centers.appendContentsOf([
            leftCenter3,
            leftCenter2,
            leftCenter,
            midCenter,
            rightCenter,
            rightCenter2,
            rightCenter3])

        // blocks
        self.view.addSubview(self.leftBlock)
        self.view.addSubview(self.midBlock)
        self.view.addSubview(self.rightBlock)

        let blockWidth: CGFloat = 300
        let blockSizeFrame = CGRectMake(0, 0, blockWidth, blockWidth)

        midBlock.frame = blockSizeFrame
        midBlock.center = CGPointMake(self.view.center.x, midCenter.y + width / sqrt(2.0) + blockWidth / sqrt(2.0))
        midBlock.backgroundColor = midSquare.backgroundColor
        midBlock.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
        midBlockCenter = midBlock.center

        leftBlock.frame = blockSizeFrame
        leftBlock.center = CGPointMake(midBlock.center.x - blockWidth / sqrt(2.0), midBlock.center.y + blockWidth / sqrt(2.0))
        leftBlock.backgroundColor = leftSquare.backgroundColor
        leftBlock.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
        leftBlockCenter = leftBlock.center

        rightBlock.frame = blockSizeFrame
        rightBlock.center = CGPointMake(midBlock.center.x + blockWidth / sqrt(2.0), midBlock.center.y + blockWidth / sqrt(2.0))
        rightBlock.backgroundColor = rightSquare.backgroundColor
        rightBlock.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
        rightBlockCenter = rightBlock.center
    }

    func swipeLeft(swipe: UISwipeGestureRecognizer) {
        self.view.userInteractionEnabled = false

        // squares
        var animations: [POPBasicAnimation] = [POPBasicAnimation]()

        for index in 0 ... 5 {
            let animation = POPBasicAnimation(propertyNamed: kPOPViewCenter)
            animation.toValue = NSValue(CGPoint: self.centers[index])
            animations.append(animation)
        }

        for index in 1 ... 6 {
            self.squares[index].pop_addAnimation(animations[index-1], forKey: "POP")
        }

        animations.last?.completionBlock = {(animation, finished) in
            for index in 0 ..< self.squares.count - 1 {
                let this = self.squares[index]
                let next = self.squares[index+1]
                this.backgroundColor = next.backgroundColor
            }
            self.squares.last?.backgroundColor = self.randomColor()

            for index in 0 ..< self.centers.count {
                self.squares[index].center = self.centers[index]
            }

            self.view.userInteractionEnabled = true
        }

        // blocks
        let midBlockAnimation = POPBasicAnimation(propertyNamed: kPOPViewCenter)
        let rightBlockAnimation = POPBasicAnimation(propertyNamed: kPOPViewCenter)

        midBlockAnimation.toValue = NSValue(CGPoint: leftBlockCenter)
        rightBlockAnimation.toValue = NSValue(CGPoint: midBlockCenter)

        midBlock.pop_addAnimation(midBlockAnimation, forKey: "POP")
        rightBlock.pop_addAnimation(rightBlockAnimation, forKey: "POP")

        rightBlockAnimation.completionBlock = {(animation, finished) in
            self.leftBlock.backgroundColor = self.squares[2].backgroundColor
            self.midBlock.backgroundColor = self.squares[3].backgroundColor
            self.rightBlock.backgroundColor = self.squares[4].backgroundColor

            self.midBlock.center = self.midBlockCenter
            self.rightBlock.center = self.rightBlockCenter
        }
    }

    func swipeRight(swipe: UISwipeGestureRecognizer) {
        self.view.userInteractionEnabled = false

        // squares
        var animations: [POPBasicAnimation] = [POPBasicAnimation]()

        for i in 0 ... 5 {
            // 6 ... 1
            let index = 6 - i
            let animation = POPBasicAnimation(propertyNamed: kPOPViewCenter)
            animation.toValue = NSValue(CGPoint: self.centers[index])
            animations.append(animation)
        }

        for i in 0 ... 5 {
            // 5 ... 0
            let index = 5 - i
            self.squares[index].pop_addAnimation(animations[i], forKey: "POP")
        }

        animations.last?.completionBlock = {(animation, finished) in
            for i in 1 ... self.squares.count - 1 {
                // self.squares.count - 1 ... 1
                let index = self.squares.count - i
                let this = self.squares[index]
                let prev = self.squares[index-1]
                this.backgroundColor = prev.backgroundColor
            }
            self.squares.first?.backgroundColor = self.randomColor()

            for index in 0 ..< self.centers.count {
                self.squares[index].center = self.centers[index]
            }

            self.view.userInteractionEnabled = true
        }

        // blocks
        let midBlockAnimation = POPBasicAnimation(propertyNamed: kPOPViewCenter)
        let leftBlockAnimation = POPBasicAnimation(propertyNamed: kPOPViewCenter)

        midBlockAnimation.toValue = NSValue(CGPoint: rightBlockCenter)
        leftBlockAnimation.toValue = NSValue(CGPoint: midBlockCenter)

        midBlock.pop_addAnimation(midBlockAnimation, forKey: "POP")
        leftBlock.pop_addAnimation(leftBlockAnimation, forKey: "POP")

        leftBlockAnimation.completionBlock = {(animation, finished) in
            self.leftBlock.backgroundColor = self.squares[2].backgroundColor
            self.midBlock.backgroundColor = self.squares[3].backgroundColor
            self.rightBlock.backgroundColor = self.squares[4].backgroundColor

            self.midBlock.center = self.midBlockCenter
            self.leftBlock.center = self.leftBlockCenter
        }
    }

    func randomColor() -> UIColor {
        return UIColor.init(hue: CGFloat(drand48()), saturation: 0.7, brightness: 0.7, alpha: 1.0)
    }
}
