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
class MiniPlayBar: UIView {

    @IBOutlet var contentView: UIView!
    var audioPlayDelegate: AudioPlayDelegate?
    var settingAudioPlayerDelegate: SettingAudioPlayerDelegate?

    /*
    var playItem: PlayItem? {
        
        didSet {
            if let thumbnailImage = UIImage(data: self.playItem.thumbnail) {
                imageView.image = thumbnailImage
            }
            
            titleLabel.text = playItem.title
        }
 
    }
*/
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
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
    
    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
        
        print("tapped")
        delegate?.didTapped(miniPlayBar: self)
        
    }
    
    func update(for playItem: PlayItem) {
//        self.playItem = playItem
    }
    
    @IBAction func play(_ sender: UIButton) {
        
        if let audioPlayer = audioPlayer {
            // change model
            if audioPlayer.isPlaying {
                audioPlayer.pause()
            } else {
                audioPlayer.play()
            }
            
            // update ui
//            updateUI()
        }
        
    }
    
    @IBAction func fastForward(_ sender: UIButton) {
        if let audioPlayer = audioPlayer {
            
            audioPlayer.currentTime = audioPlayer.currentTime + 1
//            updateUI()
        }
    }
    
    /*
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 0.5
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 1.0
    }
 */
    
}
