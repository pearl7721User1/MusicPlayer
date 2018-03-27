import UIKit

class DimmingPresentationController: UIPresentationController {
  override var shouldRemovePresentersView: Bool {
    return false
  }
  
  lazy var dimmingView = UIView(frame: CGRect.zero)
  
  override func presentationTransitionWillBegin() {
    dimmingView.frame = containerView!.bounds
    dimmingView.backgroundColor = UIColor.black
    containerView!.insertSubview(dimmingView, at: 0)
    
    dimmingView.alpha = 0
    if let coordinator = presentedViewController.transitionCoordinator {
      coordinator.animate(alongsideTransition: { _ in
        self.dimmingView.alpha = 0.5
      }, completion: nil)
    }
  }
  
  override func dismissalTransitionWillBegin()  {
    if let coordinator = presentedViewController.transitionCoordinator {
      coordinator.animate(alongsideTransition: { _ in
        self.dimmingView.alpha = 0
      }, completion: nil)
    }
  }
}
