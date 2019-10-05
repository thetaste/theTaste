//
//  AppDelegate.swift
//  UITest2
//
//  Created by Danyal Cetin on 13/05/19.
//  Copyright © 2019 The AR Taste Team. All rights reserved.
//
import UIKit

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Tab Bar Selected Text Color (Orange)
        UITabBar.appearance().tintColor = .init(displayP3Red: 0.9804, green: 0.6353, blue: 0.1020, alpha: 1)
        
        //Realign Tab Bar Text
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        
        //Set Tab Bar Font and Font Size
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "GillSans-Light", size: 20)!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "GillSans-Light", size: 20)!], for: .selected)
        
        //Set Tab Bar Selected Underline
        UITabBar.appearance().selectionIndicatorImage = getImageWithColorPosition(color: .init(displayP3Red: 0.9804, green: 0.6353, blue: 0.1020, alpha: 1), size: CGSize(width:(self.window?.frame.size.width)!/3,height: 35), lineSize: CGSize(width:(self.window?.frame.size.width)!/3, height:2))
        
        return true
    }
    
    //Function for the selected underline
    func getImageWithColorPosition(color: UIColor, size: CGSize, lineSize: CGSize) -> UIImage {
        let rectLine = CGRect(x:0, y:(size.height-lineSize.height),width: lineSize.width,height: lineSize.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.clear.setFill()
        color.setFill()
        UIRectFill(rectLine)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    
}

