//
//  ImageShadeEffectView.swift
//  TestOnMultiColorShadow
//
//  Created by GIWON1 on 2018. 11. 15..
//  Copyright © 2018년 SeoGiwon. All rights reserved.
//

import UIKit

@IBDesignable
class ImageShadeEffectView: UIView {

    private var imgBackgroundLayer = CALayer()
    private var imgLayer = CALayer()
    private var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    @IBInspectable var image: UIImage? {
        didSet {
            imgLayer.contents = image?.cgImage
            imgBackgroundLayer.contents = image?.cgImage
        }
    }
    @IBInspectable var scaleAnimationFactor: CGFloat = 0.8 {
        didSet {
            reflectViewStatus()
        }
    }
    var isScaledUp = false {
        didSet {
            reflectViewStatus()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imgBackgroundLayer.frame = self.bounds
        imgLayer.frame = self.bounds.insetBy(dx: 0.5, dy: 0.5)
        
        visualEffectView.frame = self.bounds.insetBy(dx: -100, dy: -100)

    }
    
    private func commonInit() {

        // add layers
        self.layer.addSublayer(imgBackgroundLayer)
        self.addSubview(visualEffectView)
        self.layer.addSublayer(imgLayer)
        
    }
    
    private func scaledDown() {
        imgLayer.transform = CATransform3DScale(CATransform3DIdentity, scaleAnimationFactor, scaleAnimationFactor, scaleAnimationFactor)
        imgBackgroundLayer.transform = CATransform3DScale(CATransform3DIdentity, scaleAnimationFactor, scaleAnimationFactor, scaleAnimationFactor)
        visualEffectView.isHidden = true
    }

    private func scaledUp() {
        imgLayer.transform = CATransform3DIdentity
        imgBackgroundLayer.transform = CATransform3DIdentity
        visualEffectView.isHidden = false

    }
    
    private func reflectViewStatus() {
        isScaledUp ? scaledUp() : scaledDown()
    }
}
