import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var flowController: FlowController = {
        return DefaultFlowController()
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = flowController.buildMainWindow()
        window?.makeKeyAndVisible()

        return true
    }
}

