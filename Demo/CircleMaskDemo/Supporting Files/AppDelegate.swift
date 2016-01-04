//
//  AppDelegate.swift
//  CircleMaskDemo
//
//  Created by Willow Bumby on 05/03/2015.
//  Copyright (c) 2015-2016 Ali Karagoz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let firstViewController = FirstViewController()
        window?.backgroundColor = UIColor.whiteColor()
        window?.rootViewController = firstViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}
