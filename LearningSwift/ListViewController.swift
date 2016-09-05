//
//  ListViewController.swift
//  LearningSwift
//
//  Created by Prime on 8/22/16.
//  Copyright © 2016 prime. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController, UINavigationControllerDelegate {
    var items: NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.delegate = self

        self.configureTitleView()
        self.configureTableView()
    }

// MARK: - Private Helper
    func configureTitleView() {
        self.title = "Prime"

        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "Avenir-Heavy", size: 20)
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.textColor = UIColor.blackColor()

        let attributedString = NSMutableAttributedString(string: self.title!)
        attributedString.addAttributes([NSForegroundColorAttributeName : UIColor.redColor()], range: NSMakeRange(2, 1))
        attributedString.addAttributes([NSForegroundColorAttributeName : UIColor.redColor()], range: NSMakeRange(4, 1))

        titleLabel.attributedText = attributedString
        titleLabel.sizeToFit()

        self.navigationItem.titleView = titleLabel
    }

    func configureTableView() {
        self.items = [
            ["OAO", OAOViewController.self],
            ["Grid Menu", GridMenuViewController.self],
            ["W Swipe", WSwipeViewController.self],
            ["Player", PlayerViewController.self],
            ["Table Selection", TableSelectionViewController.self]
        ];

        self.tableView.registerClass(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier())
    }

// MARK: - UINavigationControllerDelegate
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return operation == UINavigationControllerOperation.Push ? PushAnimator() : PopAnimator()
    }

// MARK: - UITableViewDataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ListTableViewCell.identifier(), forIndexPath: indexPath)

        cell.textLabel?.text = self.items[indexPath.row].firstObject as? String

        return cell
    }

// MARK: - UITableViewDelegate
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return ListTableViewCell.height(indexPath: indexPath)
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let viewControllerClass: UIViewController.Type = self.items[indexPath.row].lastObject as! UIViewController.Type
        let viewController = viewControllerClass.init()
        viewController.title = self.items[indexPath.row].firstObject as? String
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
