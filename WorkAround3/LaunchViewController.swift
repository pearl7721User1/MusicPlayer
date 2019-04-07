//
//  LaunchViewController.swift
//  WorkAround3
//
//  Created by SeoGiwon on 23/02/2018.
//  Copyright © 2018 SeoGiwon. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData


protocol AudioPlayAssociatedViewsPresentationDelegate {
    func triggerMiniPlayBar(sender: AnyObject)
    func triggerAudioPlayerViewController(sender: AnyObject)
}

class LaunchViewController: UIViewController {
    
    // MARK: - Properties, etc
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.style
    }
    var style:UIStatusBarStyle = .default

    private var playerPopupAnimationController: MiniPlayPopupAnimationController?
    private var audioPlayerViewController: AudioPlayerViewController!
    private var miniPlayBarController: MiniPlayBarController!
    private var mainTabBarController: MainTabBarController!
    private let miniPlayBarHeight: CGFloat = 80
    
    // MARK: - Core Data
    var context: NSManagedObjectContext!
    var coreDataStack: CoreDataStack!
    var audioPlayerController = AudioPlayerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init view controllers
        initEmbeddedTabBarController(with: self.coreDataStack.allPlayItems(context: self.context))
        miniPlayBarController = MiniPlayBarController(hostingView: self.view, bottomInset: mainTabBarController.tabBar.bounds.height, viewPresentationDelegate:self)
        audioPlayerViewController = AudioPlayerViewController.newAudioPlayerController()
        audioPlayerViewController.transitioningDelegate = self
        
        // continue most recent play item
        if let mostRecentPlayItem = self.mostRecentPlayItem(from: self.coreDataStack) {
            self.play(item: mostRecentPlayItem, with: self.audioPlayerController)
            self.triggerMiniPlayBar(sender: self)
        }
    }
    
    
    private func initEmbeddedTabBarController(with playItems: [PlayItem]) {

        self.mainTabBarController = MainTabBarController.newInstance(viewPresentationDelegate: self, audioPlayerController:self.audioPlayerController, audioListViewControllerBottomInset: self.miniPlayBarHeight, audioListPlayItems: playItems)
        
        // add main tab bar controller
        self.addChildViewController(mainTabBarController)
        self.view.addSubview(mainTabBarController.view)

        mainTabBarController.view.translatesAutoresizingMaskIntoConstraints = false
        
        mainTabBarController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        mainTabBarController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        mainTabBarController.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        mainTabBarController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
    }
    
    private func mostRecentPlayItem(from coreDataStack: CoreDataStack) -> PlayItem? {
        
        let recentlyPlayedItemId = UserDefaults.standard.integer(forKey: "CurrentPlayItem")
        
        return coreDataStack.playItem(of: recentlyPlayedItemId, context: self.context)
    }
    
    private func play(item: PlayItem, with audioPlayerController: AudioPlayerController) {
        audioPlayerController.currentPlayItem = item
        audioPlayerController.setPlayItem(sender: self, playItem: item)
    }
    
}

extension LaunchViewController: AudioPlayAssociatedViewsPresentationDelegate {
    
    func triggerMiniPlayBar(sender: AnyObject) {
        miniPlayBarController.showMiniPlayBar()
        miniPlayBarController.setAudioPlayControllerToMiniPlayBar(audioPlayerController: self.audioPlayerController)
    }
    
    func triggerAudioPlayerViewController(sender: AnyObject) {
        
        audioPlayerViewController.audioPlayerController = self.audioPlayerController
        
        let playerViewSnapshot = audioPlayerViewController.view.snapshotView(afterScreenUpdates: true)
        let miniPlayBarSnapshot = miniPlayBarController.miniPlayBar.snapshotView(afterScreenUpdates: true)
        
        playerPopupAnimationController = MiniPlayPopupAnimationController(playerViewSnapshot: playerViewSnapshot!, miniPlayBarSnapshot: miniPlayBarSnapshot!, miniPlayBarSnapshotStartingFrame: miniPlayBarController.miniPlayBarFrame())
        
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
        return playerPopupAnimationController
    }
    /*
     func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
     return SlideOutAnimationController()
     }
     */
}
