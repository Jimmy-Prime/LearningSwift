//
//  SwitchViewController.swift
//  LearningSwift
//
//  Created by Prime on 9/8/16.
//  Copyright © 2016 prime. All rights reserved.
//

import UIKit

class SwitchViewController: UIViewController {
    let mySwitch = Switch(frame: CGRectMake(0, 0, 180, 120))

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()

        mySwitch.center = self.view.center
        mySwitch.bgTintColor = UIColor.blackColor()
        mySwitch.offTintColor = UIColor.grayColor()
        mySwitch.onTintColor = UIColor.greenColor()
        mySwitch.lineTintColor = UIColor.whiteColor()
        self.view.addSubview(mySwitch)

        let toggleButton = UIButton(type: .System)
        toggleButton.setTitle("Toggle State", forState: .Normal)
        toggleButton.frame = CGRectMake(0, CGRectGetMaxY(mySwitch.frame) + 8, self.view.frame.size.width, 60)
        toggleButton.layer.borderColor = toggleButton.tintColor.CGColor
        toggleButton.layer.borderWidth = 2.0
        toggleButton.layer.cornerRadius = 30
        toggleButton.addTarget(self, action: #selector(self.toggle), forControlEvents: .TouchUpInside)
        self.view.addSubview(toggleButton)
    }

    func toggle() {
        mySwitch.on = !mySwitch.on
    }
}
