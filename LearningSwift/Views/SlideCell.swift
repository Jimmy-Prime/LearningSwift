//
//  SlideCell.swift
//  LearningSwift
//
//  Created by Prime on 8/29/16.
//  Copyright © 2016 prime. All rights reserved.
//

import UIKit

class SlideCell: UIView {
    let content = UIView()

    override var frame: CGRect {
        didSet {
            if frame == CGRectZero {
                return
            }

            self.clipsToBounds = true

            let width = frame.size.width

            content.frame = CGRectMake(0, 0, width, width)
            content.center = CGPointMake(width / 2.0, width / 2.0)
            content.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_4))
            self.addSubview(content)
        }
    }
}
