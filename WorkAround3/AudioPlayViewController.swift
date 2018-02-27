//
//  AudioPlayViewController.swift
//  WorkAround3
//
//  Created by SeoGiwon on 24/08/2017.
//  Copyright © 2017 SeoGiwon. All rights reserved.
//

import UIKit
import AVFoundation

class AudioPlayViewController: UIViewController {

    var playButton = GiwonPlayButton()
    
    lazy var avPlayer: AVPlayer? = {
       
        let string = "http://traffic.libsyn.com/allearsenglish/AEE_785_Efficient_or_Effective_How_to_Use_Both_Words_in_English.mp3"
        
        if let url = URL(string: string) {
            let avPlayer = AVPlayer(url: url)
            return avPlayer
        }
        else {
            return nil
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(playButton)
        

        // Do any additional setup after loading the view.
        playButton.playAction = {
            self.avPlayer?.play()
        }
        
        playButton.pauseAction = {
            self.avPlayer?.pause()
        }
        
        avPlayer?.currentItem?.duration
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        playButton.center = CGPoint(x: self.view.bounds.midX, y: 100)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
