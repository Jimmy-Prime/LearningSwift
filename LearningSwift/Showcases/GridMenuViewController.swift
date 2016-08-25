//
//  GridMenuViewController.swift
//  LearningSwift
//
//  Created by Prime on 8/23/16.
//  Copyright © 2016 prime. All rights reserved.
//

import UIKit
import pop

class GridMenuViewController: UIViewController {
    var menuButton: MenuButton = MenuButton()
    var views: [UIView] = [UIView]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()

        self.navigationController?.navigationBarHidden = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tap))
        self.view.addGestureRecognizer(tap)

        let centerFrame = CGRectMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0, 0, 0)
        for _ in 0...7 {
            let button = UIButton()
            button.frame = centerFrame
            button.backgroundColor = UIColor.init(hue: CGFloat(drand48()), saturation: 0.7, brightness: 0.7, alpha: 1.0)
            button.addTarget(self, action: #selector(menuTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(button)
            self.views.append(button)
        }

        menuButton = MenuButton(frame: CGRectMake(0, 0, 66, 66))
        menuButton.center = self.view.center
        menuButton.tintColor = UIColor.redColor()
        menuButton.backgroundColor = UIColor.blackColor()
        self.view.addSubview(menuButton)

        menuButton.addTarget(self, action: #selector(buttonTapped), forControlEvents: UIControlEvents.TouchUpInside)
    }

    func tap() {
        self.navigationController?.navigationBarHidden = !(self.navigationController?.navigationBarHidden)!
    }

    func buttonTapped() {
        menuButton.popped ? show() : hide()
    }

    func menuTapped(button: UIButton) {
        menuButton.popped = !menuButton.popped
        self.buttonTapped()
        self.view.backgroundColor = button.backgroundColor?.colorWithAlphaComponent(0.7)
    }

    func show() {
        let width = self.view.frame.size.width / 2.0
        let height = self.view.frame.size.height / 4.0
        for x in 0...1 {
            for y in 0...3 {
                let spring = POPSpringAnimation(propertyNamed: kPOPViewFrame)
                spring.toValue = NSValue(CGRect: CGRectMake(width * CGFloat(x), height * CGFloat(y), width, height))
                spring.beginTime = CACurrentMediaTime() + drand48() * 0.5

                let view: UIView = self.views[x * 4 + y]
                view.pop_addAnimation(spring, forKey: "POP")
            }
        }
    }

    func hide() {
        let centerFrame = CGRectMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0, 0, 0)
        for view in self.views {
            let spring = POPSpringAnimation(propertyNamed: kPOPViewFrame)
            spring.toValue = NSValue(CGRect: centerFrame)
            spring.beginTime = CACurrentMediaTime() + drand48() * 0.5

            view.pop_addAnimation(spring, forKey: "POP")
        }
    }
}
