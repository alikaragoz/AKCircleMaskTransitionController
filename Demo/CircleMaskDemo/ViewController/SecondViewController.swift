//
//  SecondViewController.swift
//  CircleMaskDemo
//
//  Created by Douglas Bumby on 05/03/2015.
//  Copyright (c) 2015 Douglas Bumby. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(red: 63.0/255.0, green: 81.0/255.0, blue: 181.0/255.0, alpha: 1.0)
        button.autoresizingMask = (.FlexibleTopMargin | .FlexibleBottomMargin | .FlexibleLeftMargin | .FlexibleRightMargin)
        button.setTitle("Dismiss", forState: .Normal)
        button.addTarget(self, action: "didTapButton:", forControlEvents: .TouchUpInside)
        button.titleLabel?.font = UIFont(name: "Avenir Light", size: 20.0)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.setTitleColor(UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0), forState: .Highlighted)
        button.backgroundColor = UIColor(red: 63.0/255.0, green: 81.0/255.0, blue: 181.0/255.0, alpha: 1.0)
        button.layer.cornerRadius = 5.0
        button.frame = CGRect(x: 0.0, y: 0.0, width: CGRectGetWidth(button.bounds) + 20.0, height: CGRectGetHeight(button.bounds) + 10.0)
        button.center = view.center
        button.sizeToFit()
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