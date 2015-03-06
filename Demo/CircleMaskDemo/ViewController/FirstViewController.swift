//
//  FirstViewController.swift
//  CircleMaskDemo
//
//  Created by Douglas Bumby on 05/03/2015.
//  Copyright (c) 2015 Douglas Bumby. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    var button = UIButton()
    var transitionController: AKCircleMaskTransitionController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor(red: 63.0/255.0, green: 81.0/255.0, blue: 181.0/255.0, alpha: 1.0)
        button.autoresizingMask = (.FlexibleTopMargin | .FlexibleBottomMargin | .FlexibleLeftMargin | .FlexibleRightMargin)
        button.setTitle("Present View Controller", forState: .Normal)
        button.addTarget(self, action: "didTapButton:", forControlEvents: .TouchUpInside)
        button.titleLabel?.font = UIFont(name: "Avenir Light", size: 20.0)
        button.setTitleColor(UIColor(red: 90.0/255.0, green: 93.0/255.0, blue: 107.0/255.0, alpha: 1.0), forState: .Normal)
        button.setTitleColor(UIColor(red: 60.0/255.0, green: 63.0/255.0, blue: 87.0/255.0, alpha: 1.0), forState: .Highlighted)
        button.backgroundColor = UIColor(red: 197.0/255.0, green: 202.0/255.0, blue: 233.0/255.0, alpha: 1.0)
        button.layer.cornerRadius = 5.0
        button.frame = CGRect(x: 0.0, y: 0.0, width: CGRectGetWidth(button.bounds) + 20.0, height: CGRectGetHeight(button.bounds) + 10.0)
        button.center = view.center
        button.sizeToFit()
        view.addSubview(button)
        
        // Transition
        transitionController = AKCircleMaskTransitionController()
    }
    
    // MARK: Button

    func didTapButton(sender: AnyObject) {
        transitionController?.center = button.center
        
        let secondViewController = SecondViewController()
        secondViewController.transitioningDelegate = transitionController
        secondViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        secondViewController.modalPresentationCapturesStatusBarAppearance = true
        self.presentViewController(secondViewController, animated: true, completion: nil)
    }
    
    // MARK: Status Bar
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
}