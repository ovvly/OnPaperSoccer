import Foundation
import UIKit

final class MoveButton: UIButton {
    override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.3
        }
    }
}
