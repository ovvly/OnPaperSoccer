import UIKit

protocol WithViewController {
    var viewController: UIViewController { get }
}

extension WithViewController where Self: UIViewController {
    var viewController: UIViewController { return self }
}
