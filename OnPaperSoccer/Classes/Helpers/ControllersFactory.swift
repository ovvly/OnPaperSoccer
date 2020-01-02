import Foundation
import UIKit

final class ControllersFactory {
    func createMatchViewController() -> MatchViewController {
        let gameSettings = GameSettings.default
        let movesViewController = MovesViewController()
        let turnController = DefaultPlayerTurnController(settings: gameSettings)
        let fieldViewController = FieldViewController(settings: gameSettings)
        let movesValidator = DefaultMovesValidator(settings: gameSettings)
        let viewController = MatchViewController(fieldDrawer: fieldViewController,
            movesController: movesViewController,
            playerTurnController: turnController,
            movesValidator: movesValidator,
            settings: gameSettings)
        return viewController
    }

    func createMenuViewController() -> MenuViewController {
        return MenuViewController()
    }

    func createAftermatchViewController(playerName: String, confirm: @escaping () -> Void) -> UIAlertController {
        //TODO: this is temporary controller
        let alertController = UIAlertController(title: "Game Over", message: "\(playerName) WON!!!111one1one!", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Play Again!", style: .default) { _ in
            confirm()
        }
        alertController.addAction(confirmAction)
        return alertController
    }

    func createResetConfirmationViewController(confirm: @escaping () -> Void) -> UIAlertController {
        let alertController = UIAlertController(title: "Reset", message: "Are you sure? All game progress will be lost", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Reset", style: .destructive) { _ in
            confirm()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        return alertController
    }
    
    func createAboutViewController() -> AboutViewController {
        let emailSender = DefaultEmailSender()
        return AboutViewController(externalLinkHandler: UIApplication.shared, emailSender: emailSender)
    }
}
