//
//  OAOViewController.swift
//  LearningSwift
//
//  Created by Prime on 8/22/16.
//  Copyright © 2016 prime. All rights reserved.
//

import UIKit

class OAOViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()

        let out = UIView(frame: CGRectMake(0, 0, 150, 150))
        out.center = self.view.center
        out.backgroundColor = UIColor.orangeColor()
        out.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
        out.clipsToBounds = true
        self.view.addSubview(out)

        let container = UIView(frame: CGRectMake(0, 0, 150, 150))
        container.center = CGPointMake(75, 75)
        container.backgroundColor = UIColor.redColor()
        container.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_4))
        out.addSubview(container)

        let spotify = UIImageView(image: UIImage(named: "spotify.png"))
        spotify.frame = CGRectMake(0, 0, 128, 128)
        spotify.center = CGPointMake(75, 75)
        container.addSubview(spotify)
    }
}
