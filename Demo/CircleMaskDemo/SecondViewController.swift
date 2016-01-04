//
//  SecondViewController.swift
//  CircleMaskDemo
//
//  Created by Willow Bumby on 05/03/2015.
//  Copyright (c) 2015-2016 Ali Karagoz. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    let button = DemoButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 197.0/255.0, green: 202.0/255.0, blue: 233.0/255.0, alpha: 1.0)

        button.addTarget(self, action: "didTapButton:", forControlEvents: .TouchUpInside)
        button.setTitle("Dismiss", forState: .Normal)
        button.sizeToFit()

        button.frame = CGRect(x: 0.0, y: 0.0, width: CGRectGetWidth(button.bounds) + 20.0, height: CGRectGetHeight(button.bounds) + 10.0)
        button.autoresizingMask = ([.FlexibleTopMargin, .FlexibleBottomMargin, .FlexibleLeftMargin, .FlexibleRightMargin])
        button.center = view.center
        view.addSubview(button)
    }
    
    // MARK: Button
    func didTapButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Status Bar
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .Default
    }
}