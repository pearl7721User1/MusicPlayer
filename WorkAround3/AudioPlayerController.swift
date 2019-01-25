//
//  AudioPlayerController.swift
//  WorkAround3
//
//  Created by SeoGiwon on 25/01/2019.
//  Copyright © 2019 SeoGiwon. All rights reserved.
//

import UIKit
import AVFoundation

class AudioPlayerController {

    
    var audioPlayer = AVAudioPlayer()
    var currentPlayItem: PlayItem?
    private var timer = Timer()
    
    private var observerArray = [AudioPlayStatusObserver]()
    
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
}
