//
//  TopCornersRoundedTableView.swift
//  WorkAround3
//
//  Created by SeoGiwon on 03/10/2018.
//  Copyright © 2018 SeoGiwon. All rights reserved.
//

import UIKit

class TopCornersRoundedTableView: UITableView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateTopCornersRounding(self)
    }
    
    func updateTopCornersRounding(_ scrollView: UIScrollView) {
        
        let maskLayer = CAShapeLayer()
        let path = UIBezierPath(roundedRect:
            CGRect(origin: scrollView.contentOffset.y < 0 ? CGPoint.zero : scrollView.contentOffset, size: CGSize(width: self.bounds.width, height: self.bounds.height)),
                                byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 15.0, height: 15.0))
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
        
    }
    
}
