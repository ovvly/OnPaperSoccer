import UIKit

extension UIViewController {

    func addChild(viewController: UIViewController, to container: UIView) {
        addChild(viewController)
        container.addContentSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
}
