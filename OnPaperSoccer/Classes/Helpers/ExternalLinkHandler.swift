import Foundation
import UIKit

protocol ExternalLinkHandler {
    func open(url: URL)
}

extension UIApplication: ExternalLinkHandler {
    func open(url: URL) {
        open(url)
    }
}
