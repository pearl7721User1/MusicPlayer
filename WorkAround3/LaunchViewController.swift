//
//  LaunchViewController.swift
//  WorkAround3
//
//  Created by SeoGiwon on 23/02/2018.
//  Copyright © 2018 SeoGiwon. All rights reserved.
//

import UIKit



class LaunchViewController: UIViewController, MiniPlayBarDelegate {
    
    
    
    // MARK: - view controllers
    lazy var audioPlayerViewController: AudioPlayerViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AudioPlayerViewController") as! AudioPlayerViewController
        
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = self
        
        return viewController
    }()
    
    
    lazy var mainTabBarController: UITabBarController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
        
        return viewController
    }()
    
    // MARK: - views
    @IBOutlet weak var miniPlayBar: MiniPlayBar!
    
    // MARK: - functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewHierarchyAndLayout()
        miniPlayBar.delegate = self
    }
    
    func setViewHierarchyAndLayout() {

        // add main tab bar controller
        self.addChildViewController(mainTabBarController)
        self.view.addSubview(mainTabBarController.view)

        mainTabBarController.view.translatesAutoresizingMaskIntoConstraints = false
        
        mainTabBarController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        mainTabBarController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        mainTabBarController.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        mainTabBarController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        // set launchViewController's view hierarchy
        self.view.bringSubview(toFront: self.miniPlayBar)
    }
    
    func play(playItem: PlayItem) {
        // set mini play bar
//        (UIApplication.shared.delegate as! AppDelegate).audioPlayer
        
        //
    }
    
    func didTapped(miniPlayBar: MiniPlayBar) {
        self.present(audioPlayerViewController, animated: true, completion: nil)
    }
}

extension LaunchViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        return DimmingPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil//popupAnimationController
    }
    /*
     func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
     return SlideOutAnimationController()
     }
     */
}
