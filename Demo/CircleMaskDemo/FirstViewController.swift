//
//  FirstViewController.swift
//  CircleMaskDemo
//
//  Created by Willow Bumby on 05/03/2015.
//  Copyright (c) 2015-2016 Ali Karagoz. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    var transitionController = AKCircleMaskTransitionController()
    let button = DemoButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 63.0/255.0, green: 81.0/255.0, blue: 181.0/255.0, alpha: 1.0)

        button.addTarget(self, action: "didTapButton:", forControlEvents: .TouchUpInside)
        button.setTitle("Present View Controller", forState: .Normal)
        button.sizeToFit()

        button.frame = CGRect(x: 0.0, y: 0.0, width: CGRectGetWidth(button.bounds) + 20.0, height: CGRectGetHeight(button.bounds) + 10.0)
        button.autoresizingMask = ([.FlexibleTopMargin, .FlexibleBottomMargin, .FlexibleLeftMargin, .FlexibleRightMargin])
        button.center = view.center
        view.addSubview(button)
    }
    
    // MARK: Button
    func didTapButton(sender: AnyObject) {
        transitionController.center = button.center
        
        let secondViewController = SecondViewController()
        secondViewController.transitioningDelegate = transitionController
        secondViewController.modalPresentationStyle = .Custom
        secondViewController.modalPresentationCapturesStatusBarAppearance = true
        self.presentViewController(secondViewController, animated: true, completion: nil)
    }
    
    // MARK: Status Bar
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}