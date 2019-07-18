import Foundation
import UIKit

class FlowController {
    private let controllersFactory = ControllersFactory()
    private let navigationController: UINavigationController
    private var matchViewController: MatchViewController?

    init() {
        let menuViewController = controllersFactory.createMenuViewController()
        navigationController = UINavigationController(rootViewController: menuViewController)
        menuViewController.delegate = self
    }

    func rootViewController() -> UIViewController {
        return navigationController
    }

    private func createMatchViewController() -> MatchViewController {
        let matchViewController = controllersFactory.createMatchViewController()
        matchViewController.delegate = self
        return matchViewController
    }
}

extension FlowController: MatchViewControllerDelegate {
    func playerDidWin(_ player: Player) {
        let alertController = controllersFactory.createAftermatchViewController(playerName: player.name) { [weak self] in
            self?.matchViewController?.reset()
        }
        matchViewController?.present(alertController, animated: true)
    }
}

extension FlowController: MenuViewControllerDelegate {
    func didSelectedPlay() {
        let matchViewController = self.matchViewController ?? createMatchViewController()
        navigationController.present(matchViewController, animated: true)
    }

    func didSelectedAbout() {
        print("not implemented yet")
    }
}