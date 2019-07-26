import UIKit

extension UIBarButtonItem {
    func simulateTap() {
       _ = self.target?.perform(self.action)
    }
}
