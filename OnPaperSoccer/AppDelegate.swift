import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let fieldViewController = FieldViewController()
        let matchViewController = MatchViewController(fieldDrawer: fieldViewController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = matchViewController
        window?.makeKeyAndVisible()

        return true
    }
}
