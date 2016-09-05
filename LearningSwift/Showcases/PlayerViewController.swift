//
//  PlayerViewController.swift
//  LearningSwift
//
//  Created by Prime on 8/30/16.
//  Copyright © 2016 prime. All rights reserved.
//

import UIKit
import pop

class PlayerViewController: UIViewController {
    let cover = UIImageView(image: UIImage(named: "cover.jpg"))
    let light = UIImageView(image: UIImage(named: "light.png"))
    let lightRotate = POPBasicAnimation.linearAnimation()

    let width: CGFloat = 250.0
    var normalFrame = CGRectZero
    var playingFrame = CGRectZero

    var isPlaying = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        self.navigationController?.navigationBarHidden = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tap))
        self.view.addGestureRecognizer(tap)

        normalFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width)
        playingFrame = CGRectMake((self.view.frame.size.width - width) / 2.0, 100, width, width)

        cover.frame = normalFrame
        cover.contentMode = .ScaleAspectFill
        cover.clipsToBounds = true
        self.view.addSubview(cover)

        light.frame = CGRectMake(0, 0, width, width)
        light.alpha = 0.0
        cover.addSubview(light)

        lightRotate.property = POPAnimatableProperty.propertyWithName(kPOPLayerRotation) as! POPAnimatableProperty

        let play = UIButton(type: .System)
        play.frame = CGRectMake(0, 0, 60, 60)
        play.center = CGPointMake(self.view.center.x, self.view.frame.size.height - 50)
        play.setImage(UIImage(named: "PlayControl_Play"), forState: .Normal)
        play.tintColor = UIColor.redColor()
        play.addTarget(self, action: #selector(self.play(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(play)
    }

    func tap() {
        self.navigationController?.navigationBarHidden = !(self.navigationController?.navigationBarHidden)!
    }

    func play(button: UIButton) {
        isPlaying = !isPlaying

        let coverFrame = POPBasicAnimation(propertyNamed: kPOPViewFrame)
        let coverCorner = POPBasicAnimation(propertyNamed: kPOPLayerCornerRadius)
        let lightAlpha = POPBasicAnimation(propertyNamed: kPOPViewAlpha)

        if isPlaying {
            button.setImage(UIImage(named: "PlayControl_Pause"), forState: .Normal)

            coverFrame.toValue = NSValue(CGRect: playingFrame)
            coverCorner.toValue = width / 2.0
            lightAlpha.toValue = 1.0
            lightRotate.toValue = M_PI
            lightRotate.repeatForever = true

            cover.pop_addAnimation(coverFrame, forKey: "Frame")
            cover.layer.pop_addAnimation(coverCorner, forKey: "Corner")
            coverCorner.completionBlock = {(animation, finished) in
                self.light.pop_addAnimation(lightAlpha, forKey: "Alpha")
            }
            lightAlpha.completionBlock = {(animation, finished) in
                self.light.layer.pop_addAnimation(self.lightRotate, forKey: "Rotation")
            }
        }
        else {
            button.setImage(UIImage(named: "PlayControl_Play"), forState: .Normal)

            coverFrame.toValue = NSValue(CGRect: normalFrame)
            coverCorner.toValue = 0.0
            lightAlpha.toValue = 0.0
            lightRotate.toValue = 0.0
            lightRotate.repeatForever = false

            light.pop_addAnimation(lightAlpha, forKey: "Alpha")
            lightAlpha.completionBlock = {(animation, finished) in
                self.cover.pop_addAnimation(coverFrame, forKey: "Frame")
                self.cover.layer.pop_addAnimation(coverCorner, forKey: "Corner")
            }
        }

    }
}
