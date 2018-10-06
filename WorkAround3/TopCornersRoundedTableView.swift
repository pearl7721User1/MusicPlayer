//
//  TopCornersRoundedTableView.swift
//  WorkAround3
//
//  Created by SeoGiwon on 03/10/2018.
//  Copyright © 2018 SeoGiwon. All rights reserved.
//

import UIKit

class TopCornersRoundedTableView: UITableView {

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        updateTopCornersRounding(self)
        /*
        let maskLayer = CAShapeLayer()
        let path = UIBezierPath(roundedRect:
            CGRect(origin: CGPoint.zero, size: CGSize(width: self.bounds.width, height: self.bounds.height)),
                                byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 40.0, height: 40.0))
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
        */
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
