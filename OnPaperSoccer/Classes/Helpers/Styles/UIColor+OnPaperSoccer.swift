import Foundation
import UIKit

extension UIColor {
    struct App {
        static let borderlines = UIColor(red: 79/255, green: 79/255, blue: 79/255)
        static let lines = UIColor(red: 201/255, green: 201/255, blue: 201/255)
        static let field = UIColor(red: 244/255, green: 244/255, blue: 244/255)
        static let player1 = UIColor(red: 255/255, green: 64/255, blue: 78/255)
        static let player2 = UIColor(red: 0/255, green: 191/255, blue: 243/255)
        static let lineEnd = UIColor.black
        static let textColor = UIColor(red: 82/255, green: 82/255, blue: 82/255)
    }

    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
