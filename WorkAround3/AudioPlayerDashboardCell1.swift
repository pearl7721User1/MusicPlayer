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

    var audioPlayer: AVAudioPlayer?
    
    @IBOutlet weak var playHeadSlider: UISlider!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var currentPlayTimeLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func playBtnTapped(_ sender: UIButton) {
        
        // TODO : - make sure that the audioPlayer is a class so that 'let' doesn't create a copy
        if let audioPlayer = audioPlayer {
            
            // change model
            if audioPlayer.isPlaying {
                audioPlayer.pause()
            } else {
                audioPlayer.play()
            }
            
            // update ui
            updateUI()
        }
    }
    @IBAction func backwardBtnTapped(_ sender: UIButton) {
        
        if let audioPlayer = audioPlayer {
            
            audioPlayer.currentTime = audioPlayer.currentTime - 1
            updateUI()
        }
    }
    
    @IBAction func forwardBtnTapped(_ sender: UIButton) {
        
        if let audioPlayer = audioPlayer {
         
            audioPlayer.currentTime = audioPlayer.currentTime + 1
            updateUI()
        }
    }
    
    @IBAction func rateBtnTapped(_ sender: UIButton) {
        if let audioPlayer = audioPlayer {
            let rate = nextPlayRate(rate: audioPlayer.rate)
            audioPlayer.rate = rate
            
            updateUI()
        }
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
        if let audioPlayer = audioPlayer {
            
            audioPlayer.currentTime = TimeInterval(sender.value)
        }
    }
    
    @IBAction func volumeValueChanged(_ sender: UISlider) {
        if let audioPlayer = audioPlayer {
            
            audioPlayer.volume = sender.value / 100.0
        }
        
    }
    
    
    func initUI() {
        
        if let audioPlayer = audioPlayer {
            
            // playhead slider units, min, max values
            playHeadSlider.minimumValue = 0
            playHeadSlider.maximumValue = Float(audioPlayer.duration.rounded(.awayFromZero))
            playHeadSlider.value = 0
            
            // duration
            durationLabel.text = String(format:"%.0f", audioPlayer.duration)
            
            // volume
            volumeSlider.minimumValue = 0
            volumeSlider.maximumValue = 100
            volumeSlider.value = audioPlayer.volume * 100
            
        }
    }
    
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
}
