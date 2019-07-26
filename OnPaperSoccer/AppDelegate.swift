import UIKit

@UIApplicationMain
private class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    let flowController = FlowController()
    let appStyler = AppStyler()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        appStyler.applyStyle()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = flowController.rootViewController()
        window?.makeKeyAndVisible()

        return true
    }
}
