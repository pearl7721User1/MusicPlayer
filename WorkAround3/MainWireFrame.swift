//
//  MainWireFrame.swift
//  WorkAround3
//
//  Created by SeoGiwon on 27/02/2018.
//  Copyright © 2018 SeoGiwon. All rights reserved.
//

import UIKit

class MainWireFrame: NSObject {
    
    // presenter
    lazy var presenter: MainWireFramePresenter = {
        
        var presenter = MainWireFramePresenter()
        presenter.wireFrame = self
//        presenter.interactor = MomentsInteractor()
        
        return presenter
    }()
    
    // view controllers
    lazy var audioPlayerViewController: AudioPlayerViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AudioPlayerViewController") as! AudioPlayerViewController
        
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = self
        
        return viewController
    }()
    
    lazy var launchViewController: LaunchViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LaunchViewController") as! LaunchViewController
        
        viewController.presenter = self.presenter
        
        return viewController
    }()
    
    lazy var mainTabBarController: MainTabBarController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
        
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
        
        // set launchViewController's view hierarchy
        launchViewController.view.bringSubview(toFront: launchViewController.miniPlayView)
        launchViewController.view.bringSubview(toFront: launchViewController.btn)
        
        // set mainTabBarController
        mainTabBarController.setWireFramesAndTabViewControllers()
    }
    
    // animation controllers
    lazy var popupAnimationController: MiniPlayPopupAnimationController = {
       return MiniPlayPopupAnimationController()
    }()
}

extension MainWireFrame: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        return DimmingPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return popupAnimationController
    }
    /*
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideOutAnimationController()
    }
    */
}
