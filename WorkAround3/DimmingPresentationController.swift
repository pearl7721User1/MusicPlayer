import UIKit

class DimmingPresentationController: UIPresentationController {
  override var shouldRemovePresentersView: Bool {
    return false
  }
  
  lazy var dimmingView = UIView(frame: CGRect.zero)
    var tabBarCenter: CGPoint!
  
  override func presentationTransitionWillBegin() {
    dimmingView.frame = containerView!.bounds
    dimmingView.backgroundColor = UIColor.black
    containerView!.insertSubview(dimmingView, at: 0)
    
    dimmingView.alpha = 0
    
    
    
    if let coordinator = presentedViewController.transitionCoordinator {
      coordinator.animate(alongsideTransition: { _ in
        self.dimmingView.alpha = 0.5
        
        self.presentingViewController.view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        
      }, completion: nil)
    }

    if let launchViewController = presentingViewController as? LaunchViewController {
        launchViewController.style = .lightContent
        launchViewController.setNeedsStatusBarAppearanceUpdate()
    }
  }
  
  override func dismissalTransitionWillBegin()  {
    
    if let coordinator = presentedViewController.transitionCoordinator {
      coordinator.animate(alongsideTransition: { _ in
        self.dimmingView.alpha = 0
        
        self.presentingViewController.view.transform = CGAffineTransform.identity
      }, completion: nil)
        
    }

    if let launchViewController = presentingViewController as? LaunchViewController {
        launchViewController.style = .default
        launchViewController.setNeedsStatusBarAppearanceUpdate()
    }
  }
}
