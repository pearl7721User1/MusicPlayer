//
//  AudioPlayerDashboardCell1.swift
//  WorkAround3
//
//  Created by SeoGiwon on 06/06/2018.
//  Copyright © 2018 SeoGiwon. All rights reserved.
//


import UIKit
import AVFoundation
import MediaPlayer

class AudioPlayerDashboardCell1: UITableViewCell {

    @IBOutlet weak var volumeSliderView: MPVolumeView!
    @IBOutlet weak var audioRouteButton: MPVolumeView!
    
    @objc var audioPlayerController: AudioPlayerController! {
        didSet {
            configureView()
            registerObservers()
        }
    }
    
    @IBOutlet weak var playItemImageView: ImageShadeEffectView!
    @IBOutlet weak var playHeadSlider: UISlider!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var currentPlayTimeLabel: UILabel!
    @IBOutlet weak var playButton: GHeadTailButton!
    
    @IBOutlet weak var rateButton: UIButton!
//    @IBOutlet weak var volumeSlider: UISlider!
    
    var observationForIsPlaying: NSKeyValueObservation?
    var observationForCurrentTime: NSKeyValueObservation?
    var observationForRate: NSKeyValueObservation?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        volumeSliderView.showsRouteButton = false
        audioRouteButton.showsVolumeSlider = false
        
    }
 
    
    private func registerObservers() {
        
        self.observationForCurrentTime = observe(\.audioPlayerController.currentTime,
                                                 options: [.new], changeHandler:
            { object, change in
                // do something
                if let currentTime = change.newValue {
                    self.reflectCurrentTime(currentTime: currentTime)
                }
        })
        
        self.observationForIsPlaying =
            observe(\.audioPlayerController.isPlaying,
                                                 options: [.new], changeHandler:
                { object, change in
                    // do something
                    if let isPlaying = change.newValue {
                        self.reflectIsPlaying(isPlaying: isPlaying)
                    }
        })
        
        self.observationForRate = observe(\.audioPlayerController.rate,
                                                 options: [.new], changeHandler:
            { object, change in
                // do something
                if let rate = change.newValue {
                    self.reflectRate(rate: rate)
                }
        })
        
    }
    
    
    func configureView() {
        
        if let playItem = self.audioPlayerController.currentPlayItem {
            
            let isPlaying = self.audioPlayerController.isPlaying
            let volume = self.audioPlayerController.volume
            let rate = self.audioPlayerController.rate
            let currentTime = playItem.playHead
            let duration = playItem.duration
            let imageData = playItem.thumbnail
            
            // set playhead slider units
            playHeadSlider.minimumValue = 0
            playHeadSlider.maximumValue = Float(duration.rounded(.awayFromZero))
            playHeadSlider.value = 0
            
            // set playhead slide value
            playHeadSlider.value = Float(currentTime.rounded(.toNearestOrAwayFromZero))
            
            // set playhead label
            currentPlayTimeLabel.text = String(format:"%.0f", currentTime.rounded(.toNearestOrAwayFromZero))
            
            // set play button
            playButton.showIcon(isHead: !isPlaying)
            
            // set volume slide value
//            volumeSlider.minimumValue = 0
//            volumeSlider.maximumValue = 100
//            volumeSlider.value = volume * 100
            
            // set rate button title
            
            // set image
            if let imageData = imageData {
                playItemImageView.image = UIImage(data: imageData as Data)
            }
            
            playItemImageView.isScaledUp = isPlaying
            
            // set duration
            durationLabel.text = String(format:"%.0f", duration)
        }
        
    }
    
    
    @IBAction func playBtnTapped(_ sender: UIButton) {
        
        // TODO : - make sure that the audioPlayer is a class so that 'let' doesn't create a copy
        self.audioPlayerController.playOrPause(sender: self)
        
    }
    
    @IBAction func backwardBtnTapped(_ sender: UIButton) {
        
        self.audioPlayerController.movePlayHeadBackward(sender: self)
        
    }
    
    @IBAction func forwardBtnTapped(_ sender: UIButton) {
        
        self.audioPlayerController.movePlayHeadForward(sender: self)
        
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
        
        self.audioPlayerController.setCurrentTime(sender: self, currentTime: TimeInterval(sender.value))
    }
    
    @IBAction func volumeValueChanged(_ sender: UISlider) {
        
        self.audioPlayerController.setVolume(sender: self, volume: sender.value / 100.0)
    }    
    
    private func reflectCurrentTime(currentTime: TimeInterval) {
        
        // set play head slider value
        playHeadSlider.setValue(Float(currentTime.rounded(.toNearestOrAwayFromZero)), animated: false)
        
        // set play head label
        currentPlayTimeLabel.text = String(format:"%.0f", currentTime.rounded(.toNearestOrAwayFromZero))
    }
    
    private func reflectIsPlaying(isPlaying: Bool) {
        // set play button
        playButton.showIcon(isHead: !isPlaying)
        
        // set image
        playItemImageView.isScaledUp = isPlaying
    }
    
    private func reflectRate(rate: Float) {
        
    }
    
    private func metricTime(seconds: Int) -> String? {
        if seconds < 0 {
            return nil
        }
        
        let remainingSeconds = seconds % 60
        let minutes = seconds / 60
        let hours = minutes / 60
        
        var theStringResult = String.init(format: "%d:%02d", minutes, remainingSeconds)
        
        if hours > 0 {
            theStringResult = "\(hours):\(theStringResult)"
        }
        
        return theStringResult
    }
}
