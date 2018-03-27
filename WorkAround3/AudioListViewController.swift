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

    let mp3Urls = MyPlayItem.playList()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let label = cell.viewWithTag(10) as? UILabel {
            label.text = mp3Urls[indexPath.row].title
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mp3Urls.count
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

