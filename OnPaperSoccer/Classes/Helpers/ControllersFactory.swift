import Foundation
import UIKit
import MessageUI

final class ControllersFactory {
    func createMatchViewController(gameMode: GameMode) -> MatchViewController {
        let gameSettings = FieldSettings.default
        let movesViewController = MovesViewController()
        let turnController = DefaultPlayerTurnController(settings: gameSettings)
        let fieldViewController = FieldViewController(settings: gameSettings)
        let movesValidator = DefaultMovesValidator(settings: gameSettings)
        let viewController = MatchViewController(fieldDrawer: fieldViewController,
            movesController: movesViewController,
            playerTurnController: turnController,
            movesValidator: movesValidator,
            settings: gameSettings,
            gameMode: gameMode)
        return viewController
    }

    func createMenuViewController() -> MenuViewController {
        MenuViewController()
    }

    func createSummaryViewController(player: Player) -> SummaryViewController {
        let summaryViewController = SummaryViewController(player: player)
        return summaryViewController
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
        let emailSender = DefaultEmailSender(mailComposerBuilder: {
            MFMailComposeViewController()
        })
        return AboutViewController(externalLinkHandler: UIApplication.shared, emailSender: emailSender)
    }
}
