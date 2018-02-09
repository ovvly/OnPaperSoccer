import UIKit

protocol FlowController {
    func buildMainWindow() -> UIWindow
}

final class DefaultFlowController: FlowController {

    func buildMainWindow() -> UIWindow {
        let window = UIWindow()
        window.rootViewController = MatchViewController()

        return window
    }
}
