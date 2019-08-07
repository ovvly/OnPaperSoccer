import Foundation
import UIKit

protocol WithCustomView {
    associatedtype CustomView: UIView
    
    var customView: CustomView { get }
}

extension WithCustomView where Self: UIViewController {
    var customView: CustomView {
        guard let view = self.view as? CustomView else {
            fatalError("Couldn't find proper view")
        }
        return view
    }
}
