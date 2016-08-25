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

        var white: CGFloat = CGFloat(drand48())

        self.view.backgroundColor = UIColor(white: white, alpha: 1.0)

        let label = UILabel(frame: self.view.frame)

        white += 0.5;
        if (white >= 1.0) {
            white -= 1.0;
        }

        label.textColor = UIColor(white: white, alpha: 1.0)
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont(name: "Avenir-Heavy", size: 24)
        label.text = "OAO View Controller"
        self.view.addSubview(label)
    }
}
