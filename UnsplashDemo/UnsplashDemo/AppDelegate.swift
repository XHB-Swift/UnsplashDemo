//
//  AppDelegate.swift
//  UnsplashDemo
//
//  Created by xiehongbiao on 2022/7/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = .init(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = HomeViewController()
        window?.makeKeyAndVisible()
        
        return true
    }

}

