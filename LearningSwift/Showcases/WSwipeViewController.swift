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
    var names: [String] = [String]()

    var squares: [SlideCell] = [SlideCell]()
    var centers: [CGPoint] = [CGPoint]()

    let leftBlock = SlideCell()
    let midBlock = SlideCell()
    let rightBlock = SlideCell()

    var leftBlockCenter: CGPoint = CGPointZero
    var midBlockCenter: CGPoint = CGPointZero
    var rightBlockCenter: CGPoint = CGPointZero

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        self.view.clipsToBounds = true

        self.names.appendContentsOf([
            "8track",
            "kkbox",
            "soundcloud",
            "spotify"])

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
        let leftSquare3 = SlideCell()
        let leftSquare2 = SlideCell()
        let leftSquare = SlideCell()
        let midSquare = SlideCell()
        let rightSquare = SlideCell()
        let rightSquare2 = SlideCell()
        let rightSquare3 = SlideCell()

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

            let index = Int(arc4random_uniform(UInt32(Int.max))) % self.names.count
            view.tag = index

            let image = UIImageView(image: UIImage(named: names[index]))
            image.frame = CGRectMake(0, 0, 96, 96)
            image.center = CGPointMake(75, 75)
            view.content.addSubview(image)
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

        var blocks: [SlideCell] = [SlideCell]()
        blocks.appendContentsOf([leftBlock, midBlock, rightBlock])

        for index in 0 ... 2 {
            let block = blocks[index]
            block.frame = blockSizeFrame
            block.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))

            let label = UILabel(frame: CGRectMake(0, 0, 300, 20))
            label.font = UIFont(name: "Avenir-Heavy", size: 18)
            label.textColor = UIColor.whiteColor()
            label.textAlignment = .Center
            block.content.addSubview(label)

            label.text = self.names[self.squares[index+2].tag]
        }

        midBlock.center = CGPointMake(self.view.center.x, midCenter.y + width / sqrt(2.0) + blockWidth / sqrt(2.0))
        midBlock.backgroundColor = midSquare.backgroundColor
        midBlockCenter = midBlock.center

        leftBlock.center = CGPointMake(midBlock.center.x - blockWidth / sqrt(2.0), midBlock.center.y + blockWidth / sqrt(2.0))
        leftBlock.backgroundColor = leftSquare.backgroundColor
        leftBlockCenter = leftBlock.center

        rightBlock.center = CGPointMake(midBlock.center.x + blockWidth / sqrt(2.0), midBlock.center.y + blockWidth / sqrt(2.0))
        rightBlock.backgroundColor = rightSquare.backgroundColor
        rightBlockCenter = rightBlock.center

        // direction button
        let buttonWidth = leftSquare.center.x * sqrt(2.0)
        let centerY = midCenter.y + width * sqrt(2.0)

        let leftControl = UIView(frame: CGRectMake(0, 0, buttonWidth, buttonWidth))
        leftControl.center = CGPointMake(0, centerY)
        leftControl.backgroundColor = UIColor.blackColor()
        leftControl.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
        self.view.addSubview(leftControl)

        let rightControl = UIView(frame: CGRectMake(0, 0, buttonWidth, buttonWidth))
        rightControl.center = CGPointMake(self.view.frame.size.width, centerY)
        rightControl.backgroundColor = UIColor.blackColor()
        rightControl.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
        self.view.addSubview(rightControl)

        let leftButton = UIButton(type: .System)
        leftButton.setImage(UIImage(named: "left.png"), forState: .Normal)
        leftButton.tintColor = UIColor.whiteColor()
        leftButton.frame = CGRectMake(0, 0, 30, 30)
        leftButton.center = CGPointMake(23, centerY)
        leftButton.addTarget(self, action: #selector(self.swipeLeft(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(leftButton)

        let rightButton = UIButton(type: .System)
        rightButton.setImage(UIImage(named: "right.png"), forState: .Normal)
        rightButton.tintColor = UIColor.whiteColor()
        rightButton.frame = CGRectMake(0, 0, 30, 30)
        rightButton.center = CGPointMake(self.view.frame.size.width - 23, centerY)
        rightButton.addTarget(self, action: #selector(self.swipeRight(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(rightButton)
    }

    func swipeLeft(swipe: AnyObject) {
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
            let view = self.squares.removeFirst()
            self.squares.append(view)
            view.backgroundColor = self.randomColor()
            view.center = self.centers.last!

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

            let leftLabel = self.leftBlock.content.subviews.first as! UILabel
            leftLabel.text = self.names[self.squares[2].tag]

            let midLabel = self.midBlock.content.subviews.first as! UILabel
            midLabel.text = self.names[self.squares[3].tag]

            let rightLabel = self.rightBlock.content.subviews.first as! UILabel
            rightLabel.text = self.names[self.squares[4].tag]
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
            let view = self.squares.removeLast()
            self.squares.insert(view, atIndex: 0)
            view.backgroundColor = self.randomColor()
            view.center = self.centers.first!

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

            let leftLabel = self.leftBlock.content.subviews.first as! UILabel
            leftLabel.text = self.names[self.squares[2].tag]

            let midLabel = self.midBlock.content.subviews.first as! UILabel
            midLabel.text = self.names[self.squares[3].tag]

            let rightLabel = self.rightBlock.content.subviews.first as! UILabel
            rightLabel.text = self.names[self.squares[4].tag]
        }
    }

    func randomColor() -> UIColor {
        return UIColor.init(hue: CGFloat(drand48()), saturation: 0.7, brightness: 0.7, alpha: 1.0)
    }
}
