import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let fieldViewController = FieldViewController()
        let movesViewController = MovesViewController()
        let movesValidator = DefaultMovesValidator()
        let matchViewController = MatchViewController(fieldDrawer: fieldViewController, movesController: movesViewController, movesValidator: movesValidator)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = matchViewController
        window?.makeKeyAndVisible()

        return true
    }
}
