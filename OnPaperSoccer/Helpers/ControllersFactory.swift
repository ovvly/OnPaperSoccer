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
            gameSettings: gameSettings)
        viewController.set(winingPoint: Point(x: 4, y: 10), for: .player1)
        viewController.set(winingPoint: Point(x: 4, y: 0), for: .player2)
        return viewController
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
}