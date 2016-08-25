//
//  ListTableViewCell.swift
//  LearningSwift
//
//  Created by Prime on 8/22/16.
//  Copyright © 2016 prime. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    class func identifier() -> String {
        return "ListTableViewCellIdentifier"
    }

    class func height(indexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.textLabel?.textColor = UIColor.lightGrayColor()
        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.textLabel?.font = UIFont(name: "Avenir-Light", size: 20)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}
