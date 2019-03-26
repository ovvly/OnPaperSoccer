import Foundation
import UIKit

class FlowController {
    private let controllersFactory = ControllersFactory()

    private lazy var matchViewController: MatchViewController = {
        let viewController = controllersFactory.createMatchViewController()
        viewController.delegate = self
        return viewController
    }()

    func rootViewController() -> UIViewController {
        return matchViewController
    }
}

extension FlowController: MatchViewControllerDelegate {
    func playerDidWin(_ player: Player) {
        let alertController = controllersFactory.createAftermatchViewController(playerName: player.name) { [weak self] in
            self?.matchViewController.reset()
        }
        matchViewController.present(alertController, animated: true)
    }
}