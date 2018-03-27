//
//  MiniPlayPopupAnimationController.swift
//  WorkAround3
//
//  Created by SeoGiwon on 26/03/2018.
//  Copyright © 2018 SeoGiwon. All rights reserved.
//

import UIKit

class MiniPlayPopupAnimationController: NSObject, UIViewControllerAnimatedTransitioning {

    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        /*
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
            
            fatalError("UITransitionContextViewKey.to for springUpAnimator is unavailable")
        }
        
        let containerView = transitionContext.containerView
        
        toView.frame = containerView.frame
        toView.alpha = 0.0 // toView starts from alpha 0.0, and increases its opacity for fromView's dissolving effect
        containerView.addSubview(toView)
        
        // get a copycat image view for animation
        let snapShotView = presentingDelegate.springUpSnapShotImgView
        let oldSnapShotViewFrame = snapShotView.frame
        containerView.addSubview(snapShotView)
        
        // do preliminary procedures for animation
        presentingDelegate.springUpPreAnimationClosure()
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: -0.4, options: [], animations: {
            
            toView.alpha = 1.0
            snapShotView.frame = self.presentingDelegate.springUpToFrame
            
        }, completion: { (finished) in
            
            snapShotView.removeFromSuperview()
            snapShotView.frame = oldSnapShotViewFrame
            transitionContext.completeTransition(finished)
            
            // do post procedures for animation
            self.presentingDelegate.springUpPostAnimationClosure()
        })
        */
        
    }
}
