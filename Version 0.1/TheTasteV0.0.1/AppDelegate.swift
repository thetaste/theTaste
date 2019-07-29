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
        
        //Tab Bar Color (Dark Grey)
        //UITabBar.appearance().barTintColor = .init(displayP3Red: 0.1372549, green: 0.1215686, blue: 0.1254901, alpha: 0)
        
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
    
    //Function for the selected underline (ADD ANIMATION)
    func getImageWithColorPosition(color: UIColor, size: CGSize, lineSize: CGSize) -> UIImage {
        //let rect = CGRect(x:0, y: 0, width: size.width, height: size.height)
        let rectLine = CGRect(x:0, y:(size.height-lineSize.height),width: lineSize.width,height: lineSize.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.clear.setFill()
        //UIRectFill(rect)
        color.setFill()
        UIRectFill(rectLine)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

