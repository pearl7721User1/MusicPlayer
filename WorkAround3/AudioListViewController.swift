//
//  ViewController.swift
//  WorkAround3
//
//  Created by SeoGiwon on 20/08/2017.
//  Copyright © 2017 SeoGiwon. All rights reserved.
//

import UIKit
import CoreData

class AudioListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var viewPresentationDelegate: AudioPlayAssociatedViewsPresentationDelegate?
    var playItems: [PlayItem]!
    var audioPlayerController: AudioPlayerController!
    
    var tableViewBottomInset: CGFloat = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, tableViewBottomInset, 0)
    }
    
    @IBAction func btnTapped(_ sender: UIBarButtonItem) {
        
        for (i, v) in playItems.enumerated() {
            
            print("playItem\(i):\(v.playHead)")

        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let playItem = playItems[indexPath.row]
        
        // thumbnail
        if let imageView = cell.viewWithTag(10) as? UIImageView,
            let imageData = playItem.thumbnail {
            
            let image = UIImage(data: imageData as Data)
            imageView.image = image
        }

        // published date
        if let publishedDateLabel = cell.viewWithTag(11) as? UILabel,
            let publishedDate = playItem.publishedDate {
            
            publishedDateLabel.text = (publishedDate as Date).string(capitalized: true, withinAWeekFormat: "EEEE", otherDatesFormat: "d MMM yyyy")
        }
        
        // title
        if let titleLabel = cell.viewWithTag(12) as? UILabel,
            let title = playItem.title {
            
            titleLabel.text = title
        }
        
        // description
        if let descriptionLabel = cell.viewWithTag(13) as? UILabel,
            let description = playItem.desc {
            
            descriptionLabel.text = description
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playItems.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let delegate = viewPresentationDelegate else {
            return
        }

        audioPlayerController.setPlayItem(sender: self, playItem: playItems[indexPath.row])
        delegate.triggerMiniPlayBar(sender: self)

    }
    
}

