//
//  AppDelegate.swift
//  TransitioningExample
//
//  Created by 王欣 on 11/14/19.
//  Copyright © 2019 王欣. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let mview = ViewController.init()
        let root = BaseViewController.init(rootViewController: mview)
        window?.rootViewController = root
        return true
    }
    
    
    
    
}

