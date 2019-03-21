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
        let alert = UIAlertController(title: "Game Over", message: "\(player.name) WON!!!", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(confirmAction)

        matchViewController.present(alert, animated: true)
    }
}