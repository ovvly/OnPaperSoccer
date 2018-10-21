import UIKit

extension UIViewController {

    func addChild(viewController: UIViewController, to container: UIView) {
        addChildViewController(viewController)
        container.addContentSubview(viewController.view)
        viewController.didMove(toParentViewController: self)
    }
}
