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

    var settingAudioPlayerDelegate: SettingAudioPlayerDelegate?
    var fetchRequest: NSFetchRequest<PlayItem>?
    var context: NSManagedObjectContext?
    var playItems = [PlayItem]()
    
    var tableViewBottomInset: CGFloat = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let fetchRequest = fetchRequest,
            let context = context {
            do {
                playItems = try context.fetch(fetchRequest)
            } catch {
                print("playItems couldn't be fetched")
            }
        } else {
            print("fetchRequest or context isn't initiated")
        }
        
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, tableViewBottomInset, 0)

    }
    
    @IBAction func btnTapped(_ sender: UIBarButtonItem) {
        
        for (i, v) in playItems.enumerated() {
            
            print("playItem\(i):\(v.playHead)")

        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let label = cell.viewWithTag(10) as? UILabel {
            
            label.text = playItems[indexPath.row].title
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playItems.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let delegate = settingAudioPlayerDelegate else {
            return
        }

        delegate.setPlayItem(sender: self, playItem: playItems[indexPath.row])
        delegate.triggerMiniPlayBar(sender: self, playItem: playItems[indexPath.row])

    }
    
}

