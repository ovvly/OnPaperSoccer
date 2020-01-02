import UIKit

extension UIControl {
    func simulateTap() {
        sendActions(for: .touchUpInside)
    }
}
