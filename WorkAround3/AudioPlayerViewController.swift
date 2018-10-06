//
//  PlayViewController.swift
//  WorkAround3
//
//  Created by SeoGiwon on 21/02/2018.
//  Copyright © 2018 SeoGiwon. All rights reserved.
//

import UIKit
import AVFoundation

protocol AudioPlayerAccessDelegate {
    
    var audioPlayer: AVAudioPlayer {get}
    func update(playHead value: Float)
}

class AudioPlayerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AudioPlayStatusObserver {
    
    @IBOutlet var dashboardCell1: AudioPlayerDashboardCell1!
    @IBOutlet var dashboardCell2: AudioPlayerDashboardCell2!
    @IBOutlet var dashboardCell3: AudioPlayerDashboardCell3!
    @IBOutlet weak var tableView: TopCornersRoundedTableView!
    
    var audioPlayDelegate: AudioPlayDelegate? {
        didSet {
            self.dashboardCell1.audioPlayDelegate = audioPlayDelegate
        }
    }
    
    @IBOutlet var tableHeaderView: UIView!
    let heightOfCell2: CGFloat = 60
    let heightOfCell3: CGFloat = 50
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableHeaderView = tableHeaderView
    }
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func configureView(playItem: PlayItem, isPlaying: Bool, volume: Float, rate: Float) {
        
        var image: UIImage?
        if let imageData = playItem.thumbnail {
            image = UIImage(data: imageData as Data)
        }
        
        dashboardCell1.configureView(isPlaying: isPlaying, volume: volume, rate: rate, currentTime: playItem.playHead, duration: playItem.duration, image:image)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.row {
        case 0:
            return dashboardCell1
        case 1:
            return dashboardCell2
        case 2:
            return dashboardCell3
        default:
            fatalError()
        }
        
        return dashboardCell1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            // TODO: 32 : magic number
            return self.view.bounds.height - 52//self.topLayoutGuide.length-10
        case 1:
            return heightOfCell2
        case 2:
            return heightOfCell3
        default:
            fatalError()
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tableView.updateTopCornersRounding(scrollView)
    }
    
    func update(currentTime: TimeInterval, isPlaying: Bool) {
        dashboardCell1.update(currentTime: currentTime, isPlaying: isPlaying)
    }
}


