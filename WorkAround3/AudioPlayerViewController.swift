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

class AudioPlayerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var dashboardCell1: AudioPlayerDashboardCell1!
    @IBOutlet var dashboardCell2: AudioPlayerDashboardCell2!
    @IBOutlet var dashboardCell3: AudioPlayerDashboardCell3!
    @IBOutlet weak var tableView: UITableView!
    
    var audioPlayDelegate: AudioPlayDelegate?
    
    @IBOutlet var tableHeaderView: UIView!
    let heightOfCell2: CGFloat = 60
    let heightOfCell3: CGFloat = 50
    
    var timer = Timer()
    var audioPlayer: AVAudioPlayer!
    var playItem: PlayItem!
    
    let filePath = Bundle.main.path(forResource: "salamander", ofType: "mp3")
    //Bundle.main.path(forResource: "Hooded", ofType: "mp3")
    var isPlaying = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init audio player
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: filePath!))
        } catch {
            print("Could not load file")
        }
        
        dashboardCell1.audioPlayer = audioPlayer
        dashboardCell1.initUI()
        
        
        let maskLayer = CAShapeLayer()
        let path = UIBezierPath(roundedRect:
            CGRect(origin: CGPoint.zero, size: CGSize(width: tableView.bounds.width, height: tableView.bounds.height)),
                                byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 40.0, height: 40.0))
        maskLayer.path = path.cgPath
        tableView.layer.mask = maskLayer
        tableView.tableHeaderView = tableHeaderView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (timer: Timer) in
            self.dashboardCell1.updateUI()
        }
        
        timer.fire()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        
        dismiss(animated: true, completion: nil)
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
        
        print("scrollViewDidScrol l")
        
        let maskLayer = CAShapeLayer()
        let path = UIBezierPath(roundedRect:
            CGRect(origin: scrollView.contentOffset.y < 0 ? CGPoint.zero : scrollView.contentOffset, size: CGSize(width: tableView.bounds.width, height: tableView.bounds.height)),
                                byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 15.0, height: 15.0))
        maskLayer.path = path.cgPath
        tableView.layer.mask = maskLayer
    }
    
}


