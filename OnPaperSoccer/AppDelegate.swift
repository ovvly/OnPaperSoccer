import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var flowController: FlowController = {
        return MainFlowController()
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = flowController.buildMainWindow()
        window?.makeKeyAndVisible()

        return true
    }
}

