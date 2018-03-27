//
//  LaunchViewController.swift
//  WorkAround3
//
//  Created by SeoGiwon on 23/02/2018.
//  Copyright © 2018 SeoGiwon. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController, MiniPlayViewDelegate {

    var presenter: MainWireFramePresenter!
    
    @IBOutlet weak var btn: UIButton!
    
    @IBOutlet weak var miniPlayView: MiniPlayView!
    
    @IBAction func btnTapped(_ sender: UIButton) {
        
        // create a snapshot
        if let snapshotView = miniPlayView.snapshotView(afterScreenUpdates: true) {
            
            snapshotView.center = miniPlayView.center;
            self.view.addSubview(snapshotView)
            
            
            UIView.animate(withDuration: 0.5, animations: {
                
                snapshotView.frame = self.view.bounds
                
            }, completion: { (finished) -> Void in
                snapshotView.removeFromSuperview()
            })
            
        }
        
        
        // transform
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        miniPlayView.delegate = self
        
        // Do any additional setup after loading the view.
    }

    func didTapped(miniPlayView: MiniPlayView) {
        
        presenter.presentAudioPlayViewController(from: self)
    }
    
}
