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
    func playOrPause(sender: AnyObject)
    func movePlayHeadBackward(sender: AnyObject)
    func movePlayHeadForward(sender: AnyObject)
    func setCurrentTime(sender: AnyObject, currentTime: TimeInterval)
    func setVolume(sender: AnyObject, volume: Float)
    func setPlayRate(sender: AnyObject, playRate: Float)
}

protocol SettingAudioPlayerDelegate {
    func setPlayItem(sender: AnyObject, playItem: PlayItem)
    func triggerMiniPlayBar(sender: AnyObject, playItem: PlayItem)
    func triggerAudioPlayerViewController(sender: AnyObject, playItem: PlayItem)
}


protocol AudioPlayStatusObserver {
    func update(currentTime: TimeInterval, isPlaying: Bool)
}

class LaunchViewController: UIViewController, SettingAudioPlayerDelegate, AudioPlayDelegate {
    
    // MARK: - Properties, etc
    var audioPlayer = AVAudioPlayer()
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.style
    }
    var style:UIStatusBarStyle = .default
    
    private var observerArray = [AudioPlayStatusObserver]()
    private var currentPlayItem: PlayItem?
    private var timer = Timer()

    private var playerPopupAnimationController: MiniPlayPopupAnimationController?
    
    // MARK: - View/VC Init
//    @IBOutlet weak var miniBarBottomConstraint: NSLayoutConstraint!
    
    lazy var audioPlayerViewController: AudioPlayerViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AudioPlayerViewController") as! AudioPlayerViewController
        
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = self
        viewController.audioPlayDelegate = self
        self.observerArray.append(viewController)
        
        return viewController
    }()
    
    private var miniPlayBarController: MiniPlayBarController!
    private var mainTabBarController: MainTabBarController!
    private let miniPlayBarHeight: CGFloat = 80
    
//    @IBOutlet weak var miniPlayBar: MiniPlayBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // embed tab bar controller
        initEmbeddedTabBarController()
        miniPlayBarController = MiniPlayBarController(hostingView: self.view, bottomInset: mainTabBarController.tabBar.bounds.height)
        
        
        // create mini play bar, set delegate
        miniPlayBarController.miniPlayBar.audioPlayDelegate = self
        miniPlayBarController.miniPlayBar.settingAudioPlayerDelegate = self
        observerArray.append(miniPlayBarController.miniPlayBar)
        
        miniPlayBarController.showMiniPlayBarTop()
    }
    
    
    private func initEmbeddedTabBarController(){

        self.mainTabBarController = MainTabBarController.newInstance(audioListViewControllerDelegate: self, audioListViewControllerBottomInset: self.miniPlayBarHeight)
        
        // add main tab bar controller
        self.addChildViewController(mainTabBarController)
        self.view.addSubview(mainTabBarController.view)

        mainTabBarController.view.translatesAutoresizingMaskIntoConstraints = false
        
        mainTabBarController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        mainTabBarController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        mainTabBarController.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        mainTabBarController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        // set launchViewController's view hierarchy
//        self.view.bringSubview(toFront: self.miniPlayBarController.miniPlayBar)
        
        // reposition mini play bar
//        miniBarBottomConstraint.constant = mainTabBarController.tabBar.bounds.height
    }
    
    // MARK: - AudioPlayDelegate
    func playOrPause(sender: AnyObject) {
        
        if let currentPlayItem = currentPlayItem {
            
            if (audioPlayer.isPlaying) {
                audioPlayer.pause()

                timer.invalidate()
                
                let currentTime = self.audioPlayer.currentTime
                let isPlaying = self.audioPlayer.isPlaying
                
                for observer in self.observerArray {
                    observer.update(currentTime: currentTime, isPlaying: isPlaying)
                }
                
                currentPlayItem.playHead = currentTime
                print(currentPlayItem.playHead)

            } else {
                audioPlayer.play()
                timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) {[unowned self] (timer: Timer) in
                    
                    let currentTime = self.audioPlayer.currentTime
                    let isPlaying = self.audioPlayer.isPlaying
                    
                    for observer in self.observerArray {
                        observer.update(currentTime: currentTime, isPlaying: isPlaying)
                    }
                    
                    currentPlayItem.playHead = currentTime
                }
                
                timer.fire()
            }
        }
    }
    
    func movePlayHeadBackward(sender: AnyObject) {
        audioPlayer.currentTime = audioPlayer.currentTime - 1
    }
    
    func movePlayHeadForward(sender: AnyObject) {
        audioPlayer.currentTime = audioPlayer.currentTime + 1
    }
    
    func setCurrentTime(sender: AnyObject, currentTime: TimeInterval) {
        audioPlayer.currentTime = currentTime        
        currentPlayItem?.playHead = currentTime
        
        for observer in self.observerArray {
            observer.update(currentTime: currentTime, isPlaying: audioPlayer.isPlaying)
        }
    }
    
    func setVolume(sender: AnyObject, volume: Float) {
        audioPlayer.volume = volume
    }
    
    func setPlayRate(sender: AnyObject, playRate: Float) {
        audioPlayer.rate = playRate
    }
    
    
    // MARK: - SettingAudioPlayerDelegate
    func setPlayItem(sender: AnyObject, playItem: PlayItem) {
        
        timer.invalidate()
        
        guard let fileName = playItem.fileName else {
            print("audio fileName is nil")
            return
        }
        
        
        do {
            let resourceFilePath = "\(Bundle.main.bundlePath)/\(fileName)"
            try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: resourceFilePath))
        } catch {
            print("Could not load file")
            return
        }

        currentPlayItem = playItem
        audioPlayer.currentTime = playItem.playHead
        self.playOrPause(sender: self)
        
        
        // save what's been newly selected to play in nsuserdefault
        UserDefaults.standard.set(playItem.id, forKey: "CurrentPlayItem")
    }
    
    func triggerMiniPlayBar(sender: AnyObject, playItem: PlayItem) {
        miniPlayBarController.miniPlayBar.isHidden = false
        
        if let currentPlayItem = currentPlayItem {
            miniPlayBarController.miniPlayBar.configureView(playItem: currentPlayItem, isPlaying: audioPlayer.isPlaying)
        }
        
        
    }
    
    func triggerAudioPlayerViewController(sender: AnyObject, playItem: PlayItem) {
        
        let playerViewSnapshot = audioPlayerViewController.view.snapshotView(afterScreenUpdates: true)
        let miniPlayBarSnapshot = miniPlayBarController.miniPlayBar.snapshotView(afterScreenUpdates: true)
        
        playerPopupAnimationController = MiniPlayPopupAnimationController(playerViewSnapshot: playerViewSnapshot!, miniPlayBarSnapshot: miniPlayBarSnapshot!, miniPlayBarSnapshotStartingFrame: miniPlayBarController.miniPlayBar.frame)
        
        
        self.present(audioPlayerViewController, animated: true, completion: nil)
        
        if currentPlayItem != nil {
            
            audioPlayerViewController.configureView(playItem: playItem, isPlaying: audioPlayer.isPlaying, volume: audioPlayer.volume, rate: audioPlayer.rate)
            
        }
        
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
