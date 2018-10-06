//
//  ViewController.swift
//  WorkAround3
//
//  Created by SeoGiwon on 20/08/2017.
//  Copyright © 2017 SeoGiwon. All rights reserved.
//

import UIKit
import MediaPlayer

class AudioListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var settingAudioPlayerDelegate: SettingAudioPlayerDelegate?
    var dataSourceDelegate: AudioListDataSourceDelegate?
    
    @IBAction func btnTapped(_ sender: UIBarButtonItem) {
        
        let items = playItems()
        
        for (i, v) in items!.enumerated() {
            
            print("playItem\(i):\(v.playHead)")

        }
    }
    
    
    func playItems() -> [PlayItem]? {
        if dataSourceDelegate != nil {
            return dataSourceDelegate!.playItems(sender: self)
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let label = cell.viewWithTag(10) as? UILabel {
            
            if let playItems = playItems() {
                label.text = playItems[indexPath.row].title
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let playItems = playItems() {
            return playItems.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let playItems = playItems(),
            let delegate = settingAudioPlayerDelegate else {
                return
        }

        delegate.setPlayItem(sender: self, playItem: playItems[indexPath.row])
        delegate.triggerMiniPlayBar(sender: self, playItem: playItems[indexPath.row])

    }
    
}

