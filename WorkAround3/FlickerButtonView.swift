//
//  ButtonLikeView.swift
//  ActualDownloadTask
//
//  Created by SeoGiwon on 04/05/2017.
//  Copyright © 2017 SeoGiwon. All rights reserved.
//

import UIKit

class FlickerButtonView: UIView {

    
    convenience init() {
        
        let boundRect = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.init(frame:boundRect)
        commonInit()
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
        self.layer.contents = image(in: UIColor.black)?.cgImage
        
    }

    
    
    func drawContents(_ context: CGContext, rect: CGRect, color:UIColor) {
        
    }
    
    func image(in color:UIColor) -> UIImage? {
        return nil
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 0.5
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 1.0
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 1.0
    }
}
