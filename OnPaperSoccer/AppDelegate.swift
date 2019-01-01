import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let controllersFactory = ControllersFactory()
        let matchViewController = controllersFactory.createMatchViewController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = matchViewController
        window?.makeKeyAndVisible()

        return true
    }
}
