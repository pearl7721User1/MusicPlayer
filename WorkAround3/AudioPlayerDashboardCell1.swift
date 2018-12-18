//
//  AudioPlayerDashboardCell1.swift
//  WorkAround3
//
//  Created by SeoGiwon on 06/06/2018.
//  Copyright © 2018 SeoGiwon. All rights reserved.
//


import UIKit
import AVFoundation

class AudioPlayerDashboardCell1: UITableViewCell {

    var audioPlayDelegate: AudioPlayDelegate?
    
    @IBOutlet weak var playItemImageView: ImageShadeEffectView!
    @IBOutlet weak var playHeadSlider: UISlider!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var currentPlayTimeLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    
    func configureView(isPlaying: Bool, volume: Float, rate: Float, currentTime: TimeInterval, duration: TimeInterval, image:UIImage?) {
        
        // set playhead slider units
        playHeadSlider.minimumValue = 0
        playHeadSlider.maximumValue = Float(duration.rounded(.awayFromZero))
        playHeadSlider.value = 0
        
        // set playhead slide value
        playHeadSlider.value = Float(currentTime.rounded(.toNearestOrAwayFromZero))
        
        // set playhead label
        currentPlayTimeLabel.text = String(format:"%.0f", currentTime.rounded(.toNearestOrAwayFromZero))
        
        // set play button
        if isPlaying {
            playButton.setImage(UIImage(named:"pause.png")!, for: .normal)
        } else {
            playButton.setImage(UIImage(named:"play.png")!, for: .normal)
        }
        
        // set volume slide value
        volumeSlider.minimumValue = 0
        volumeSlider.maximumValue = 100
        volumeSlider.value = volume * 100
        
        // set rate button title
        
        // set image
        playItemImageView.image = image
        playItemImageView.isScaledUp = isPlaying
        
        // set duration
        durationLabel.text = String(format:"%.0f", duration)
    }
    
    
    @IBAction func playBtnTapped(_ sender: UIButton) {
        
        // TODO : - make sure that the audioPlayer is a class so that 'let' doesn't create a copy
        if let audioPlayDelegate = audioPlayDelegate {
            
            // change model
            audioPlayDelegate.playOrPause(sender: self)
            
        }
    }
    @IBAction func backwardBtnTapped(_ sender: UIButton) {
        
        if let audioPlayDelegate = audioPlayDelegate {
            
            audioPlayDelegate.movePlayHeadBackward(sender: self)
        }
    }
    
    @IBAction func forwardBtnTapped(_ sender: UIButton) {
        
        if let audioPlayDelegate = audioPlayDelegate {
         
            audioPlayDelegate.movePlayHeadForward(sender: self)
        }
    }
    
    @IBAction func rateBtnTapped(_ sender: UIButton) {
        /*
        if let audioPlayDelegate = audioPlayDelegate {
            let rate = nextPlayRate(rate: audioPlayer.rate)
            audioPlayer.rate = rate
            
//            updateUI()
        }
 */
    }
    
    private func nextPlayRate(rate: Float) -> Float {
        
        var newRate = rate
        if (rate <= 1.0) {
            newRate = 2.0
        } else if (rate <= 2.0) {
            newRate = 1.0
        }
        
        return newRate
    }
    
    @IBAction func playHeadValueChanged(_ sender: UISlider) {
        if let audioPlayDelegate = audioPlayDelegate {
            
            audioPlayDelegate.setCurrentTime(sender: self, currentTime: TimeInterval(sender.value))
        }
    }
    
    @IBAction func volumeValueChanged(_ sender: UISlider) {
        if let audioPlayDelegate = audioPlayDelegate {
            
            audioPlayDelegate.setVolume(sender: self, volume: sender.value / 100.0)
        }
        
    }
    
    /*
    func updateUI() {
        
        
        if let audioPlayer = audioPlayer {
            
            // audio play button image
            if audioPlayer.isPlaying {
                playButton.setImage(UIImage(named:"pause.png")!, for: .normal)
            } else {
                playButton.setImage(UIImage(named:"play.png")!, for: .normal)
            }
            
//            print("original:\(audioPlayer.currentTime)")
//            print("down:\(audioPlayer.currentTime.rounded(.toNearestOrAwayFromZero))")
            
            // playtime
            currentPlayTimeLabel.text = String(format:"%.0f", audioPlayer.currentTime.rounded(.toNearestOrAwayFromZero))
            
            // rate
            rateButton.setTitle(String(format:"%.0f", audioPlayer.rate), for: .normal)
            
            // volume
            volumeSlider.value = audioPlayer.volume * 100
            
            // playhead
            playHeadSlider.setValue(Float(audioPlayer.currentTime.rounded(.toNearestOrAwayFromZero)), animated: false)
        }
    }
    */
    
    func update(currentTime: TimeInterval, isPlaying: Bool) {
        
        // set play head slider value
        playHeadSlider.setValue(Float(currentTime.rounded(.toNearestOrAwayFromZero)), animated: false)
        
        // set play head label
        currentPlayTimeLabel.text = String(format:"%.0f", currentTime.rounded(.toNearestOrAwayFromZero))
        
        // set play button
        if isPlaying {
            playButton.setImage(UIImage(named:"pause.png")!, for: .normal)
        } else {
            playButton.setImage(UIImage(named:"play.png")!, for: .normal)
        }
        
        // set image
        playItemImageView.isScaledUp = isPlaying
    }
}
