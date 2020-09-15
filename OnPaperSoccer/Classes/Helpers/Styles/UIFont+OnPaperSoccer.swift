import Foundation
import UIKit

extension UIFont {
    struct App {
        static func dreamwalker(size: CGFloat) -> UIFont {
            UIFont(name: "Dreamwalker", size: size)!
        }

        static func system(size: CGFloat) -> UIFont {
            UIFont.systemFont(ofSize: size)
        }
    }
}
