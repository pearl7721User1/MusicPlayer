//
//  LaunchViewController.swift
//  WorkAround3
//
//  Created by SeoGiwon on 23/02/2018.
//  Copyright © 2018 SeoGiwon. All rights reserved.
//

import UIKit
import AVFoundation

protocol AudioPlayDelegate {
    func play(sender: AnyObject)
    func pause(sender: AnyObject)
    func movePlayHeadBackward(sender: AnyObject)
    func movePlayHeadForward(sender: AnyObject)
}

protocol SettingAudioPlayerDelegate {
    func setPlayItem(sender: AnyObject, playItem: PlayItem)
    func triggerMiniPlayBar(sender: AnyObject, playItem: PlayItem)
    func triggerAudioPlayerViewController(sender: AnyObject, playItem: PlayItem)
}

protocol AudioListDataSourceDelegate {
    func playItems(sender: UIViewController) -> [PlayItem]
}

class LaunchViewController: UIViewController, SettingAudioPlayerDelegate, AudioPlayDelegate, AudioListDataSourceDelegate {
    
    // MARK: - Properties, etc
    var audioPlayer = AVAudioPlayer()
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.style
    }
    var style:UIStatusBarStyle = .default
    
    
    // MARK: - View/VC Init
    @IBOutlet weak var miniBarBottomConstraint: NSLayoutConstraint!
    
    lazy var audioPlayerViewController: AudioPlayerViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AudioPlayerViewController") as! AudioPlayerViewController
        
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = self
        viewController.audioPlayDelegate = self
        
        return viewController
    }()
    
    
    lazy var mainTabBarController: UITabBarController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarViewController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
        
        let audioListViewController = tabBarViewController.audioListViewController()
        audioListViewController.settingAudioPlayerDelegate = self
        audioListViewController.dataSourceDelegate = self
        
        return tabBarViewController
    }()
    
    @IBOutlet weak var miniPlayBar: MiniPlayBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // embed tab bar controller
        embedTabBarController()
        
        // get existing playItems from Core Data Stack
        
        
        // create mini play bar, set delegate
        miniPlayBar.audioPlayDelegate = self
        miniPlayBar.settingAudioPlayerDelegate = self
        
        //
        
    }
    
    
    func embedTabBarController(){

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
        
        // reposition mini play bar
        if self.tabBarController != nil {
            miniBarBottomConstraint.constant = self.tabBarController!.tabBar.bounds.height
        }
    }
    
    // MARK: - AudioPlayDelegate
    func play(sender: AnyObject) {
        audioPlayer.play()
    }
    
    func pause(sender: AnyObject) {
        audioPlayer.pause()
    }
    
    func movePlayHeadBackward(sender: AnyObject) {
        audioPlayer.currentTime = audioPlayer.currentTime - 1
    }
    
    func movePlayHeadForward(sender: AnyObject) {
        audioPlayer.currentTime = audioPlayer.currentTime + 1
    }
    
    
    // MARK: - SettingAudioPlayerDelegate
    func setPlayItem(sender: AnyObject, playItem: PlayItem) {
        
        guard let fileName = playItem.fileName else {
            print("audio fileName is nil")
            return
        }
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileName))
        } catch {
            print("Could not load file")
        }
        
    }
    
    func triggerMiniPlayBar(sender: AnyObject, playItem: PlayItem) {
        miniPlayBar.isHidden = false
        miniPlayBar.configureView(playItem: playItem)
    }
    
    func triggerAudioPlayerViewController(sender: AnyObject, playItem: PlayItem) {
        self.present(audioPlayerViewController, animated: true, completion: nil)
        audioPlayerViewController.configureView(playItem: playItem)
    }
    
    // MARK: - AudioListDataSourceDelegate
    func playItems(sender: UIViewController) -> [PlayItem] {
        return (UIApplication.shared.delegate as! AppDelegate).coreDataStack.playItems
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
