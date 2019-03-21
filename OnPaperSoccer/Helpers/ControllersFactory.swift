import Foundation

final class ControllersFactory {
    func createMatchViewController() -> MatchViewController {
        let fieldWidth = 9
        let fieldHeight = 11

        let movesViewController = MovesViewController()
        let turnController = DefaultPlayerTurnController(fieldWidth: fieldWidth, fieldHeight: fieldHeight)
        let fieldViewController = FieldViewController(fieldWidth: fieldWidth, fieldHeight: fieldHeight)
        let movesValidator = DefaultMovesValidator(fieldWidth: fieldWidth, fieldHeight: fieldHeight)
        let viewController = MatchViewController(fieldDrawer: fieldViewController,
            movesController: movesViewController,
            playerTurnController: turnController,
            movesValidator: movesValidator,
            fieldWidth: fieldWidth, fieldHeight: fieldHeight)
        viewController.set(winingPoint: Point(x: 4, y: 10), for: .player1)
        viewController.set(winingPoint: Point(x: 4, y: 0), for: .player2)
        return viewController
    }
}