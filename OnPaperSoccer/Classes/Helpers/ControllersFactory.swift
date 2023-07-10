import Foundation
import UIKit
import MessageUI
import SwiftUI

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

    func createMenuViewController(onRoute: @escaping (MenuRoute) -> Void) -> UIViewController {
        let interactor = MenuInteractor(onRoute: onRoute)
        let view = MenuView(interactor: interactor)
        return UIHostingController(rootView: view)
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
    
    func createAboutViewController() -> UIViewController {
        let emailSender = DefaultEmailSender(mailComposerBuilder: {
            MFMailComposeViewController()
        })
        let interactor = AboutInteractor(externalLinkHandler: UIApplication.shared, emailSender: emailSender)
        let view = AboutView(interactor: interactor)
        let viewController = UIHostingController(rootView: view)
        emailSender.presentingViewController = viewController
        return viewController
    }
}
