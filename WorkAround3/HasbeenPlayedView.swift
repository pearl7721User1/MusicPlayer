//
//  DownloadOngoingView.swift
//  CoreGraphicsDrawingSample
//
//  Created by SeoGiwon on 4/23/17.
//  Copyright © 2017 SeoGiwon. All rights reserved.
//

import UIKit


class HasbeenPlayedView: FlickerButtonView {
    
    override func drawContents(_ context: CGContext, rect: CGRect, color:UIColor) {
        
        let rect1 = CGRect(x: 5, y: 5, width: 12, height: 30)
        let rect2 = CGRect(x: 25, y: 5, width: 12, height: 30)
        
        if let context = UIGraphicsGetCurrentContext() {
            
            context.setFillColor(color.cgColor)
            context.fill([rect1, rect2])
        }
        
        
    }
    
    override func image(in color:UIColor) -> UIImage {
        
        let size = CGSize(width: 40, height: 40)
        
        let rect = CGRect(origin: CGPoint.zero, size: size)
        
        var newImage = UIImage()
        
        UIGraphicsBeginImageContextWithOptions(size, false, 2.0)
        
        if let context = UIGraphicsGetCurrentContext() {
            
            drawContents(context, rect: rect, color: color)
            
            newImage = UIGraphicsGetImageFromCurrentImageContext()!
            
            UIGraphicsEndImageContext()
            
            return newImage
            
        } else {
            fatalError()
        }
        
        
    }
}
