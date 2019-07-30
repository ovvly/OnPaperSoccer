import Foundation
import UIKit

class FlowController {
    private let controllersFactory = ControllersFactory()
    private let navigationController: UINavigationController
    private lazy var matchViewController: MatchViewController = {
        return createMatchViewController()
    }()

    init() {
        let menuViewController = controllersFactory.createMenuViewController()
        navigationController = UINavigationController(rootViewController: menuViewController)
        menuViewController.delegate = self
        setupNavigationController()
    }

    func rootViewController() -> UIViewController {
        return navigationController
    }

    private func createMatchViewController() -> MatchViewController {
        let matchViewController = controllersFactory.createMatchViewController()
        matchViewController.delegate = self
        return matchViewController
    }

    private func setupNavigationController() {
        self.navigationController.navigationBar.isTranslucent = true
        self.navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController.navigationBar.shadowImage = UIImage()
    }
}

extension FlowController: MatchViewControllerDelegate {
    func playerDidWin(_ player: Player) {
        let alertController = controllersFactory.createAftermatchViewController(playerName: player.name) { [weak self] in
            self?.matchViewController.reset()
        }
        matchViewController.present(alertController, animated: true)
    }

    func showResetConfirmation() {
        let alertController = controllersFactory.createResetConfirmationViewController(confirm: { [weak self] in
            self?.matchViewController.reset()
        })
        matchViewController.present(alertController, animated: true)
    }
}

extension FlowController: MenuViewControllerDelegate {
    func didSelectedPlay() {
        navigationController.pushViewController(matchViewController, animated: true)
    }

    func didSelectedAbout() {
        print("not implemented yet")
    }
}
