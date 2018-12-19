//
//  MainTabBarController.swift
//  WorkAround3
//
//  Created by SeoGiwon on 01/10/2018.
//  Copyright © 2018 SeoGiwon. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    
    static func newInstance(audioListViewControllerDelegate: SettingAudioPlayerDelegate, audioListViewControllerBottomInset: CGFloat) -> MainTabBarController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarViewController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
        
        let viewControllers = (tabBarViewController.viewControllers![0] as! AudioListNavigationController).viewControllers
        let audioListViewController = viewControllers[0] as! AudioListViewController
        audioListViewController.tableViewBottomInset = audioListViewControllerBottomInset
        audioListViewController.settingAudioPlayerDelegate = audioListViewControllerDelegate
        audioListViewController.fetchRequest = (UIApplication.shared.delegate as! AppDelegate).coreDataStack.allPlayItemsFetchRequest
        audioListViewController.context = (UIApplication.shared.delegate as! AppDelegate).coreDataStack.persistentContainer.viewContext
        
        return tabBarViewController
    }
    
}
