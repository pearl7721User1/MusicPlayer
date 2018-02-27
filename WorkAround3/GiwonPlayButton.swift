//
//  DownloadProgressView.swift
//  CoreGraphicsDrawingSample
//
//  Created by SeoGiwon on 4/28/17.
//  Copyright © 2017 SeoGiwon. All rights reserved.
//

import UIKit

@IBDesignable
class GiwonPlayButton: UIView {
    
    var playAction: (() -> ())?
    var pauseAction: (() -> ())?

    fileprivate var playing = false {
        didSet {
            if playing == true {
                
                if let playAction = playAction {
                    playAction()
                }
                
                self.addSubview(playView)
                playView.alpha = 0.0
                
                UIView.animate(withDuration: 0.05, animations: {
                    self.pauseView.alpha = 0.0
                    self.playView.alpha = 1.0
                }, completion: { (finished) in
                    self.pauseView.removeFromSuperview()
                    self.pauseView.alpha = 1.0
                })
            } else {
                
                if let pauseAction = pauseAction {
                    pauseAction()
                }

                
                self.addSubview(pauseView)
                pauseView.alpha = 0.0
                
                UIView.animate(withDuration: 0.05, animations: {
                    self.playView.alpha = 0.0
                    self.pauseView.alpha = 1.0
                }, completion: { (finished) in
                    self.playView.removeFromSuperview()
                    self.playView.alpha = 1.0
                })
            }
        }
    }
    
    fileprivate lazy var playView: HasbeenPlayedView = {
        
        let playView = HasbeenPlayedView()
        return playView
    }()
    
    fileprivate lazy var pauseView: HasbeenPausedView = {
        
        let pauseView = HasbeenPausedView()
        return pauseView
    }()
    
    
    convenience init() {
        
        let rect = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.init(frame:rect)
        
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = UIColor.clear
        
        // add this view's tap gesture recognizer
        let gr = UITapGestureRecognizer(target: self, action: #selector(tapRecognizer(_:)))
        self.addGestureRecognizer(gr)
        self.addSubview(pauseView)
    }
    
    func tapRecognizer(_ gr: UITapGestureRecognizer) {
        
        playing = !playing
    }

}
