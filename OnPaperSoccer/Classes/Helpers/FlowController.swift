import Foundation
import UIKit

class FlowController {
    private let controllersFactory = ControllersFactory()
    private let navigationController: UINavigationController
    weak var matchViewController: MatchViewController?

    init() {
        let menuViewController = controllersFactory.createMenuViewController()
        navigationController = UINavigationController(rootViewController: menuViewController)
        menuViewController.delegate = self
        setupNavigationController()
    }

    func rootViewController() -> UIViewController {
        navigationController
    }

    private func createMatchViewController(gameMode: GameMode) -> MatchViewController {
        let matchViewController = controllersFactory.createMatchViewController(gameMode: gameMode)
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
        let summaryViewController = controllersFactory.createSummaryViewController(player: player)
        summaryViewController.modalTransitionStyle = .crossDissolve
        summaryViewController.modalPresentationStyle = .overCurrentContext
        summaryViewController.delegate = self
        matchViewController?.present(summaryViewController, animated: true)
    }

    func showResetConfirmation() {
        let alertController = controllersFactory.createResetConfirmationViewController(confirm: { [weak self] in
            self?.matchViewController?.reset()
        })
        matchViewController?.present(alertController, animated: true)
    }
}

extension FlowController: MenuViewControllerDelegate {
    func didSelectedSinglePlayer() {
        let matchViewController = createMatchViewController(gameMode: .singlePlayer)
        self.matchViewController = matchViewController
        navigationController.pushViewController(matchViewController, animated: true)
    }

    func didSelectedHotSeats() {
        let matchViewController = createMatchViewController(gameMode: .hotSeats)
        self.matchViewController = matchViewController
        navigationController.pushViewController(matchViewController, animated: true)
    }

    func didSelectedAbout() {
        let aboutViewController = controllersFactory.createAboutViewController()
        navigationController.pushViewController(aboutViewController, animated: true)
    }
}

extension FlowController: SummaryViewControllerDelegate {
    func viewControllerDidRestart(_ viewController: SummaryViewController) {
        matchViewController?.reset()
        viewController.dismiss(animated: true)
    }

    func viewControllerDidClose(_ viewController: SummaryViewController) {
        viewController.dismiss(animated: true)
    }
}
