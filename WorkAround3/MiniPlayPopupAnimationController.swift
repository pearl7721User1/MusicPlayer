//
//  MiniPlayPopupAnimationController.swift
//  WorkAround3
//
//  Created by SeoGiwon on 26/03/2018.
//  Copyright © 2018 SeoGiwon. All rights reserved.
//

import UIKit

class MiniPlayPopupAnimationController: NSObject, UIViewControllerAnimatedTransitioning {

    private var playerViewSnapshot: UIView
    private var miniPlayBarSnapshot: UIView
    private var miniPlayBarStartingFrame: CGRect
    
    init(playerViewSnapshot: UIView, miniPlayBarSnapshot: UIView, miniPlayBarSnapshotStartingFrame: CGRect) {
        self.playerViewSnapshot = playerViewSnapshot
        self.miniPlayBarSnapshot = miniPlayBarSnapshot
        self.miniPlayBarStartingFrame = miniPlayBarSnapshotStartingFrame
    }
 
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
            
            fatalError()
        }
        
        let containerView = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for: toViewController)
        
        containerView.addSubview(playerViewSnapshot)
        containerView.addSubview(miniPlayBarSnapshot)
        
        playerViewSnapshot.frame = CGRect(x: miniPlayBarStartingFrame.origin.x, y: miniPlayBarStartingFrame.origin.y, width: finalFrame.width, height: finalFrame.height)
        miniPlayBarSnapshot.frame = miniPlayBarStartingFrame
        miniPlayBarSnapshot.alpha = 1.0
        
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: [], animations: {
            
            self.playerViewSnapshot.frame = finalFrame
            self.miniPlayBarSnapshot.frame = CGRect(x: finalFrame.origin.x, y: finalFrame.origin.y, width: self.miniPlayBarSnapshot.frame.width, height: self.miniPlayBarSnapshot.frame.height)
            self.miniPlayBarSnapshot.alpha = 0.0
            
        }, completion: { (finished) in
            
            self.playerViewSnapshot.removeFromSuperview()
            self.miniPlayBarSnapshot.removeFromSuperview()
            
            toViewController.view.frame = finalFrame
            containerView.addSubview(toViewController.view)
            transitionContext.completeTransition(finished)
            
        })
        
        /*
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
            
            transitionContext.completeTransition(finished)
            
            // do post procedures for animation
            self.presentingDelegate.springUpPostAnimationClosure()
        })
        */
        
    }
}
