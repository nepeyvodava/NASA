import UIKit

class TransitionManager: NSObject, UIViewControllerTransitioningDelegate {
    
    // MARK: - UIViewControllerTransitioningDelegate
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return InfoPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
}
