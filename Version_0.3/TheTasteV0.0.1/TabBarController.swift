//
//  TabBarController.swift
//  UITest2
//
//  Created by Danyal Cetin on 13/05/19.
//  Copyright © 2019 The AR Taste Team. All rights reserved.
//
import UIKit

class TabBarController: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        //Set tab bar Size and Location
        self.tabBar.frame = CGRect(x:(self.view.frame.origin.x), y:110, width: (self.tabBar.frame.width), height: (35))

        super.viewDidLayoutSubviews()
    }
}
