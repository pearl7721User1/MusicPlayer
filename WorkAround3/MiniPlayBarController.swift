//
//  MiniPlayBarController.swift
//  WorkAround3
//
//  Created by SeoGiwon on 19/12/2018.
//  Copyright © 2018 SeoGiwon. All rights reserved.
//

import UIKit

class MiniPlayBarController: NSObject {

    private var hostingView: UIView!
    private var bottomInset: CGFloat = 0
    private var bottomAnchorConstraint: NSLayoutConstraint!
    
    var miniPlayBar = MiniPlayBar(frame: CGRect.zero)
    
    init(hostingView: UIView, bottomInset:CGFloat, audioPlayDelegate: AudioPlayDelegate, settingAudioPlayerDelegate: SettingAudioPlayerDelegate) {
        self.hostingView = hostingView
        self.bottomInset = bottomInset
        
        miniPlayBar.audioPlayDelegate = audioPlayDelegate
        miniPlayBar.settingAudioPlayerDelegate = settingAudioPlayerDelegate
        
        hostingView.addSubview(miniPlayBar)
        miniPlayBar.translatesAutoresizingMaskIntoConstraints = false
        miniPlayBar.leftAnchor.constraint(equalTo: hostingView.leftAnchor, constant: 0).isActive = true
        miniPlayBar.rightAnchor.constraint(equalTo: hostingView.rightAnchor, constant: 0).isActive = true
        
        bottomAnchorConstraint = miniPlayBar.bottomAnchor.constraint(equalTo: hostingView.bottomAnchor, constant: 0)
        bottomAnchorConstraint.isActive = true
        
        miniPlayBar.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func showMiniPlayBar() {
        
        bottomAnchorConstraint.constant = -bottomInset

        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: [], animations: {
            self.hostingView.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    func configureMiniPlayBar(with playItem: PlayItem, isPlaying: Bool) {
        miniPlayBar.configureView(playItem: playItem, isPlaying: isPlaying)
    }
    
    func snapShot() -> UIView? {
        return miniPlayBar.snapshotView(afterScreenUpdates: true)
    }
    
    func miniPlayBarFrame() -> CGRect {
        return miniPlayBar.frame
    }
}
