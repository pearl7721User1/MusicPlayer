//
//  MiniPlayView.swift
//  WorkAround3
//
//  Created by GIWON1 on 2018. 2. 28..
//  Copyright © 2018년 SeoGiwon. All rights reserved.
//

import UIKit

protocol MiniPlayViewDelegate {
    func didTapped(miniPlayView: MiniPlayView)
}

class MiniPlayView: UIView {

    @IBOutlet var contentView: UIView!
    var delegate:MiniPlayViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("MiniPlayView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }
    
    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
        
        print("tapped")
        delegate?.didTapped(miniPlayView: self)
        
    }
    
    
    
    
    /*
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 0.5
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 1.0
    }
 */
    
}
