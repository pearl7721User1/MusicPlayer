//
//  CustomView.swift
//  CoreGraphicsDrawingSample
//
//  Created by SeoGiwon on 4/23/17.
//  Copyright © 2017 SeoGiwon. All rights reserved.
//

import UIKit

class HasbeenPausedView: FlickerButtonView {
    
    
    override func drawContents(_ context: CGContext, rect: CGRect, color:UIColor) {
        
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: 0, y: 0))
        trianglePath.addLine(to: CGPoint(x: 0, y: 40))
        trianglePath.addLine(to: CGPoint(x: 40, y: 20))
        trianglePath.close()

        if let context = UIGraphicsGetCurrentContext() {
            
            context.addPath(trianglePath.cgPath)
            context.setFillColor(color.cgColor)
            context.fillPath()
        }
        
        
    }

    override func image(in color:UIColor) -> UIImage? {
        
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
