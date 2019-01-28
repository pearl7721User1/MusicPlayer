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


protocol AudioPlayStatusObserver {
    func update(currentTime: TimeInterval, isPlaying: Bool)
}

class LaunchViewController: UIViewController {
    
    // MARK: - Properties, etc
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.style
    }
    var style:UIStatusBarStyle = .default

    private var playerPopupAnimationController: MiniPlayPopupAnimationController?
    
    
    lazy var audioPlayerViewController: AudioPlayerViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AudioPlayerViewController") as! AudioPlayerViewController
        
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = self
        
        return viewController
    }()
    
    private var miniPlayBarController: MiniPlayBarController!
    private var mainTabBarController: MainTabBarController!
    private let miniPlayBarHeight: CGFloat = 80
    
    // MARK: - Core Data
    var context: NSManagedObjectContext!
    var coreDataStack: CoreDataStack!
    var audioPlayerController = AudioPlayerController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // embed tab bar controller
        initEmbeddedTabBarController(with: self.coreDataStack.allPlayItems(context: self.context))
        miniPlayBarController = MiniPlayBarController(hostingView: self.view, bottomInset: mainTabBarController.tabBar.bounds.height, viewPresentationDelegate:self)
        
        // save what's been newly selected to play in nsuserdefault
        let recentlyPlayedItemId = UserDefaults.standard.integer(forKey: "CurrentPlayItem")

        // if available?
        if let recentlyPlayedItem = self.coreDataStack.playItem(of: recentlyPlayedItemId, context: self.context) {
            self.audioPlayerController.currentPlayItem = recentlyPlayedItem
            self.audioPlayerController.setPlayItem(sender: self, playItem: recentlyPlayedItem)
            
            if let delegate = self as? AudioPlayAssociatedViewsPresentationDelegate {
                delegate.triggerMiniPlayBar(sender: self)
            }
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
    
    
}

extension LaunchViewController: AudioPlayAssociatedViewsPresentationDelegate {
    
    
    func triggerMiniPlayBar(sender: AnyObject) {
        
        miniPlayBarController.showMiniPlayBar()
        miniPlayBarController.setAudioPlayControllerToMiniPlayBar(audioPlayerController: self.audioPlayerController)
        
        /*
        if let currentPlayItem = self.audioPlayerController.currentPlayItem {
            
            miniPlayBarController.configureMiniPlayBar(with: currentPlayItem, isPlaying: self.audioPlayerController.audioPlayer.isPlaying)
        }
        */
        
    }
    
    func triggerAudioPlayerViewController(sender: AnyObject) {
        
        audioPlayerViewController.audioPlayerController = self.audioPlayerController
        
        let playerViewSnapshot = audioPlayerViewController.view.snapshotView(afterScreenUpdates: true)
        let miniPlayBarSnapshot = miniPlayBarController.miniPlayBar.snapshotView(afterScreenUpdates: true)
        
        playerPopupAnimationController = MiniPlayPopupAnimationController(playerViewSnapshot: playerViewSnapshot!, miniPlayBarSnapshot: miniPlayBarSnapshot!, miniPlayBarSnapshotStartingFrame: miniPlayBarController.miniPlayBarFrame())
        
        self.present(audioPlayerViewController, animated: true, completion: nil)
        /*
        if let currentPlayItem = self.audioPlayerController.currentPlayItem {
            
            audioPlayerViewController.configureView(playItem: playItem, isPlaying: audioPlayer.isPlaying, volume: audioPlayer.volume, rate: audioPlayer.rate)
            
        }
        */
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
