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
    var audioPlayerController: AudioPlayerController!
    
    @IBOutlet weak var imageView: ImageShadeEffectView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError()
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
        
        // configure item
        if let currentPlayItem = self.audioPlayerController.currentPlayItem {
            configureView(playItem: currentPlayItem, isPlaying: self.audioPlayerController.audioPlayer.isPlaying)
        }
    }
    
    func configureView(playItem: PlayItem, isPlaying:Bool) {
        
        if let imageData = playItem.thumbnail,
            let image = UIImage(data: imageData as Data) {
            imageView.image = image
            imageView.isScaledUp = false
            titleLabel.text = playItem.title
        }
        
        titleLabel.text = playItem.title
        
        // TODO: - set play button
        if isPlaying {
            playButton.setImage(UIImage(named:"pause.png")!, for: .normal)
        } else {
            playButton.setImage(UIImage(named:"play.png")!, for: .normal)
        }
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
        if isPlaying {
            playButton.setImage(UIImage(named:"pause.png")!, for: .normal)
        } else {
            playButton.setImage(UIImage(named:"play.png")!, for: .normal)
        }
    }

    
}
