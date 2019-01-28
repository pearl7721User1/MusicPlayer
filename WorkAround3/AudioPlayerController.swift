//
//  AudioPlayerController.swift
//  WorkAround3
//
//  Created by SeoGiwon on 25/01/2019.
//  Copyright © 2019 SeoGiwon. All rights reserved.
//

import UIKit
import AVFoundation

class AudioPlayerController: NSObject {
    
    private var audioPlayer: AVAudioPlayer?
    var currentPlayItem: PlayItem?
    private var timer = Timer()
    
    // updateAudioPlayerObservableProperties
    @objc dynamic var currentTime: Double = 0.0
    @objc dynamic var isPlaying: Bool = false
    @objc dynamic var volume: Float = 0.0
    @objc dynamic var rate: Float = 0.0    
    
    func playOrPause(sender: AnyObject) {
        
        if let audioPlayer = audioPlayer,
            let currentPlayItem = currentPlayItem {
            
            if (audioPlayer.isPlaying) {
                audioPlayer.pause()
                
                timer.invalidate()
                
                /*
                let currentTime = audioPlayer.currentTime
                let isPlaying = audioPlayer.isPlaying
                
                for observer in self.observerArray {
                    observer.update(currentTime: currentTime, isPlaying: isPlaying)
                }
                */
                if let audioPlayer = self.audioPlayer {
                    self.updateAudioPlayerProperties(from: audioPlayer)
                }
                
                self.updateCurrentItemPlayHead()
                
                print(currentPlayItem.playHead)
                
            } else {
                audioPlayer.play()
                timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) {[unowned self] (timer: Timer) in
                    
                    // update list:
                    // currentTime, isPlaying, volume, rate
                    if let audioPlayer = self.audioPlayer {
                        self.updateAudioPlayerProperties(from: audioPlayer)
                    }
                    
                    self.updateCurrentItemPlayHead()
                    
                    /*
                    let currentTime = audioPlayer.currentTime
                    let isPlaying = audioPlayer.isPlaying
                    
                    for observer in self.observerArray {
                        observer.update(currentTime: currentTime, isPlaying: isPlaying)
                    }
                    */
                    
                }
                
                timer.fire()
            }
        }
        
    }
    
    func movePlayHeadBackward(sender: AnyObject) {
        
        if let audioPlayer = self.audioPlayer {
            audioPlayer.currentTime = audioPlayer.currentTime - 1
        }
        
    }
    
    func movePlayHeadForward(sender: AnyObject) {
        if let audioPlayer = self.audioPlayer {
            audioPlayer.currentTime = audioPlayer.currentTime + 1
        }
    }
    
    func setCurrentTime(sender: AnyObject, currentTime: TimeInterval) {
        audioPlayer?.currentTime = currentTime
        currentPlayItem?.playHead = currentTime

    }
    
    func setVolume(sender: AnyObject, volume: Float) {
        audioPlayer?.volume = volume
    }
    
    func setPlayRate(sender: AnyObject, playRate: Float) {
        audioPlayer?.rate = playRate
    }
    
    func setPlayItem(sender: AnyObject, playItem: PlayItem) {
        
        timer.invalidate()
        
        // init audio player
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
        
        audioPlayer?.currentTime = playItem.playHead
        currentPlayItem = playItem
        
        // update audio player properties of this class
        if let audioPlayer = self.audioPlayer {
            self.updateAudioPlayerProperties(from: audioPlayer)
        }
        
        self.playOrPause(sender: self)

        // TODO:
        // save what's been newly selected to play in nsuserdefault
        UserDefaults.standard.set(playItem.id, forKey: "CurrentPlayItem")
    }
    
    func updateCurrentItemPlayHead() {
        if let playItem = self.currentPlayItem {
            playItem.playHead = self.currentTime
        }
    }
    
    private func updateAudioPlayerProperties(from audioPlayer: AVAudioPlayer) {
        self.currentTime = audioPlayer.currentTime
        self.isPlaying = audioPlayer.isPlaying
        self.volume = audioPlayer.volume
        self.rate = audioPlayer.rate
        
    }
 
}
