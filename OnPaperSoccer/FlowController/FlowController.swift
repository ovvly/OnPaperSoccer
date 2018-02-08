import UIKit

protocol FlowController {
    func buildMainWindow() -> UIWindow
}

final class MainFlowController: FlowController {

    func buildMainWindow() -> UIWindow {
        let window = UIWindow()
        window.rootViewController = MatchViewController()

        return window
    }
}
