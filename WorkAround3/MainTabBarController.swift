//
//  MainTabBarController.swift
//  WorkAround3
//
//  Created by SeoGiwon on 01/10/2018.
//  Copyright © 2018 SeoGiwon. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    func audioListViewController() -> AudioListViewController {
        
        let viewControllers = (self.viewControllers![0] as! AudioListNavigationController).viewControllers
        
        return viewControllers[0] as! AudioListViewController
    }
    
    func setAudioList(bottomInset: CGFloat) {
        
        audioListViewController().tableView.contentInset = UIEdgeInsetsMake(0, 0, bottomInset, 0)
//        audioListViewController().tableView.contentInset = UIEdgeInsetsMake(0, 0, bottomInset, 0)
    }
}
