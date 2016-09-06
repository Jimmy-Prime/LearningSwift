//
//  TableSelectionViewController.swift
//  LearningSwift
//
//  Created by Prime on 9/5/16.
//  Copyright © 2016 prime. All rights reserved.
//

import UIKit
import pop

class TableSelectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var direction: UISwipeGestureRecognizerDirection = .Right

    var songs: [Song] = [Song]()
    var selections: [Song] = [Song]()
    let list = UITableView(frame: CGRectZero, style: .Plain)
    let selection = UITableView(frame: CGRectZero, style: .Plain)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipe(_:)))
        swipeLeft.direction = .Left;
        self.view.addGestureRecognizer(swipeLeft);

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipe(_:)))
        swipeRight.direction = .Right
        self.view.addGestureRecognizer(swipeRight)

        var frame = CGRectMake(0, 64, 0.8 * self.view.frame.size.width, self.view.frame.size.height - 64.0)
        list.frame = frame
        list.dataSource = self
        list.delegate = self
        list.showsVerticalScrollIndicator = false
        list.rowHeight = SongCell.height()
        self.view.addSubview(list)

        frame.origin.x = frame.size.width
        selection.frame = frame
        selection.dataSource = self
        selection.delegate = self
        selection.showsVerticalScrollIndicator = false
        selection.rowHeight = 44.0
        selection.layer.shadowColor = UIColor.blackColor().CGColor
        selection.layer.shadowRadius = 10.0
        selection.layer.shadowOpacity = 0.8
        selection.layer.shadowOffset = CGSizeMake(-1, 0)
        selection.clipsToBounds = false
        selection.layer.masksToBounds = false
        self.view.addSubview(selection)

        self.automaticallyAdjustsScrollViewInsets = false

        let names: [String] = ["8track.png", "kkbox.png", "soundcloud.png", "spotify.png"]
        for i in 0...99 {
            let song = Song()
            song.art = UIImage(named: names[Int(arc4random()%4)])!
            song.name = "\(i) Name \(arc4random())"
            song.artist = "\(i) Artist \(arc4random())"
            song.order = i

            songs.append(song)
        }
    }

    func swipe(swipe: UISwipeGestureRecognizer) {
        if swipe.direction == direction {
            return
        }

        direction = swipe.direction

        let width = list.frame.size.width
        let listFrame = POPSpringAnimation(propertyNamed: kPOPViewFrame)
        let selectionFrame = POPSpringAnimation(propertyNamed: kPOPViewFrame)

        if swipe.direction == .Left {
            selection.rowHeight = SongCell.height()

            var frame = selection.frame
            frame.origin.x = self.view.frame.size.width - width
            selectionFrame.toValue = NSValue(CGRect: frame)

            frame.origin.x = frame.origin.x - width
            listFrame.toValue = NSValue(CGRect: frame)
        }
        else {
            var frame = list.frame
            frame.origin.x = 0.0
            listFrame.toValue = NSValue(CGRect: frame)

            frame.origin.x = width
            selectionFrame.toValue = NSValue(CGRect: frame)

            selection.rowHeight = 44.0
        }

        list.pop_addAnimation(listFrame, forKey: "Frame")
        selection.pop_addAnimation(selectionFrame, forKey: "Frame")

        selection.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
    }

// MARK: - Helper
    func findIndex(index: Int) -> Int {
        var target: Int = 0
        for i in 0 ... songs.count-1 {
            let song = songs[i]
            if song.order > index {
                target = i
                break
            }
            else {
                target = i + 1
            }
        }

        return target
    }

    func snapshotView(view: UIView) -> UIImage {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    func rectOfRow(row: Int, inTableView tableView: UITableView) -> CGRect {
        var frame = CGRectMake(0, 0, tableView.frame.size.width, tableView.rowHeight)

        frame = CGRectOffset(frame, tableView.frame.origin.x, -tableView.contentOffset.y + tableView.rowHeight * CGFloat(row) + tableView.frame.origin.y)

        return frame
    }

// MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == list {
            return songs.count
        }
        else {
            return selections.count
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(SongCell.identifier())
        if cell == nil {
            cell = SongCell.init(style: .Subtitle, reuseIdentifier: SongCell.identifier())
        }

        let song = (tableView == list) ? songs[indexPath.row] : selections[indexPath.row]
        cell!.imageView?.image = song.art
        cell!.textLabel?.text = song.name
        cell!.detailTextLabel?.text = song.artist

        return cell!
    }

// MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        let cell = tableView.cellForRowAtIndexPath(indexPath)!
        let flyingCell = UIImageView(image: snapshotView(cell))
        let cellFrameInSelf = rectOfRow(indexPath.row, inTableView: tableView)
        flyingCell.frame = cellFrameInSelf

        if tableView == list {
            selections.append(songs.removeAtIndex(indexPath.row))

            self.view.addSubview(flyingCell)
            cell.alpha = 0.0

            let frameAnimation = POPBasicAnimation(propertyNamed: kPOPViewFrame)
            frameAnimation.toValue = NSValue(CGRect: rectOfRow(selections.count - 1, inTableView: selection))
            flyingCell.pop_addAnimation(frameAnimation, forKey: "Frame")

            frameAnimation.completionBlock = {(animation, finished) in
                self.list.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)

                var selectionIndexPath = NSIndexPath(index: 0)
                selectionIndexPath = selectionIndexPath.indexPathByAddingIndex(self.selections.count-1)
                self.selection.insertRowsAtIndexPaths([selectionIndexPath], withRowAnimation: .None)

                flyingCell.removeFromSuperview()
            }
        }
        else {
            let song = selections.removeAtIndex(indexPath.row)
            let newIndex = findIndex(song.order)
            songs.insert(song, atIndex: newIndex)

            self.view.addSubview(flyingCell)
            cell.alpha = 0.0

            let frameAnimation = POPBasicAnimation(propertyNamed: kPOPViewFrame)
            frameAnimation.toValue = NSValue(CGRect: rectOfRow(newIndex, inTableView: list))
            flyingCell.pop_addAnimation(frameAnimation, forKey: "Frame")

            frameAnimation.completionBlock = {(animation, finished) in
                self.selection.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)

                var listIndexPath = NSIndexPath(index: 0)
                listIndexPath = listIndexPath.indexPathByAddingIndex(newIndex)
                self.list.insertRowsAtIndexPaths([listIndexPath], withRowAnimation: .None)

                flyingCell.removeFromSuperview()
            }
        }
    }
}
