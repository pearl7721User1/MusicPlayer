//
//  MainWireFrame.swift
//  WorkAround3
//
//  Created by SeoGiwon on 27/02/2018.
//  Copyright © 2018 SeoGiwon. All rights reserved.
//

import UIKit

class MainWireFrame {
    
    lazy var audioPlayerViewController: AudioPlayerViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AudioPlayerbackViewController") as! AudioPlayerViewController
        
        return viewController
    }()
    
    lazy var launchViewController: LaunchViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LaunchViewController") as! LaunchViewController
        
        return viewController
    }()
    
    lazy var mainTabBarController: UITabBarController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
        
        return viewController
    }()
    
    func setRootViewController(from window: UIWindow) {
        
        window.rootViewController = launchViewController
        
        // add mainTabBarController to launchViewController
        launchViewController.addChildViewController(mainTabBarController)
        launchViewController.view.addSubview(mainTabBarController.view)
        
        // have mainTabBarController's view bounded by launchViewController's view
        mainTabBarController.view.translatesAutoresizingMaskIntoConstraints = false
        
        mainTabBarController.view.leftAnchor.constraint(equalTo: launchViewController.view.leftAnchor).isActive = true
        mainTabBarController.view.rightAnchor.constraint(equalTo: launchViewController.view.rightAnchor).isActive = true
        mainTabBarController.view.topAnchor.constraint(equalTo: launchViewController.view.topAnchor).isActive = true
        mainTabBarController.view.bottomAnchor.constraint(equalTo: launchViewController.view.bottomAnchor).isActive = true
        
        
    }
}
