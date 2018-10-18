import UIKit

extension UIButton {
    func simulateTap() {
        sendActions(for: .touchUpInside)
    }
}