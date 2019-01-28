//
//  MiniPlayBar.swift
//  WorkAround3
//
//  Created by GIWON1 on 2018. 2. 28..
//  Copyright © 2018년 SeoGiwon. All rights reserved.
//

import UIKit
import AVFoundation


@IBDesignable
class MiniPlayBar: UIView, AudioPlayStatusObserver {
    

    @IBOutlet var contentView: UIView!
    var viewPresentationDelegate: AudioPlayAssociatedViewsPresentationDelegate?
    var audioPlayerController: AudioPlayerController! {
        didSet {
            configureView()
        }
    }
    
    @IBOutlet weak var imageView: ImageShadeEffectView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var playButton: GHeadTailButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("MiniPlayBar", owner: self, options: nil)
        addSubview(contentView)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        contentView.addGestureRecognizer(tapGestureRecognizer)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        
    }
    
    func configureView() {
        // configure item
        if let playItem = self.audioPlayerController.currentPlayItem {
            
            if let imageData = playItem.thumbnail,
                let image = UIImage(data: imageData as Data) {
                imageView.image = image
                
            }
            
            imageView.isScaledUp = false
            titleLabel.text = playItem.title
        }
        
        
        let isPlaying = self.audioPlayerController.isPlaying
        
        // TODO: - set play button
        playButton.showIcon(isHead: !isPlaying)
        
    }
    
    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
        
        if let delegate = viewPresentationDelegate {
            delegate.triggerAudioPlayerViewController(sender: self)
        }
        
    }
    
    @IBAction func fastForwardBtnTapped(_ sender: UIButton) {
        self.audioPlayerController.movePlayHeadForward(sender: self)
    }
    
    @IBAction func playBtnTapped(_ sender: UIButton) {
        self.audioPlayerController.playOrPause(sender: self)
    }
    
    
    func update(currentTime: TimeInterval, isPlaying: Bool) {
        playButton.showIcon(isHead: !isPlaying)
    }

    
}
