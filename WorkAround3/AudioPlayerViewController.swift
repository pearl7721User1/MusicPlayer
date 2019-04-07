//
//  PlayViewController.swift
//  WorkAround3
//
//  Created by SeoGiwon on 21/02/2018.
//  Copyright © 2018 SeoGiwon. All rights reserved.
//

import UIKit
import AVFoundation

class AudioPlayerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var dashboardCell1: AudioPlayerDashboardCell1!
    @IBOutlet var dashboardCell2: AudioPlayerDashboardCell2!
    @IBOutlet var dashboardCell3: AudioPlayerDashboardCell3!
    @IBOutlet weak var tableView: TopCornersRoundedTableView!
    
    var audioPlayerController: AudioPlayerController! {
        didSet {
            self.dashboardCell1.audioPlayerController = self.audioPlayerController
        }
    }
    
    @IBOutlet var tableHeaderView: UIView!
    let heightOfCell2: CGFloat = 60
    let heightOfCell3: CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(statusBarTapped), name: NSNotification.Name(rawValue: "statusBarTapped"), object: nil)
        
        tableView.tableHeaderView = tableHeaderView
    }
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func statusBarTapped() {
        
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
        tableView.updateTopCornersRounding(scrollView)
    }
    
}

extension AudioPlayerViewController {
    static func newAudioPlayerController() -> AudioPlayerViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AudioPlayerViewController") as! AudioPlayerViewController
        
        viewController.modalPresentationStyle = .custom
        return viewController
    }
}
