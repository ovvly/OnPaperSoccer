import UIKit

final class AppStyler {
    func applyStyle() {
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.App.dreamwalker(size: 24)], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.App.dreamwalker(size: 24)], for: .highlighted)
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: 2.0), for: .default)
        UINavigationBar.appearance().tintColor = UIColor.App.textColor
    }
}
