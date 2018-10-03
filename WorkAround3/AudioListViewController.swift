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
    
    var playItems: [PlayItem] {
        return (UIApplication.shared.delegate as! AppDelegate).coreDataStack.playItems
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
        /*
        var newVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PlayViewController") as! PlayViewController
        
        newVC.modalPresentationStyle = .overFullScreen
        
        self.present(newVC, animated: true, completion: {
            self.dim()
        })
        */
    }
    
    func dim() {
        self.view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    }
    
    func undoDim() {
        self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
    }
}

