//
//  SongCell.swift
//  LearningSwift
//
//  Created by Prime on 9/5/16.
//  Copyright © 2016 prime. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {
    class func identifier() -> String! {
        return "SongCellIdentifier"
    }

    class func height() -> CGFloat {
        return 60
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .None

        self.backgroundColor = UIColor.whiteColor()

        self.textLabel?.textColor = UIColor.blackColor()
        self.textLabel?.font = UIFont(name: "Avenir-Heavy", size: 14)

        self.detailTextLabel?.textColor = UIColor.redColor()
        self.detailTextLabel?.font = UIFont(name: "Avenir-Heavy", size: 12)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
