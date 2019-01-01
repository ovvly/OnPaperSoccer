import Foundation

final class ControllersFactory {
    func createMatchViewController() -> MatchViewController {
        let fieldWidth = 9
        let fieldHeight = 11

        let movesViewController = MovesViewController()
        let fieldViewController = FieldViewController(fieldWidth: fieldWidth, fieldHeight: fieldHeight)
        let movesValidator = DefaultMovesValidator(fieldWidth: fieldWidth, fieldHeight: fieldHeight)
        return MatchViewController(fieldDrawer: fieldViewController, movesController: movesViewController,
            movesValidator: movesValidator, fieldWidth: fieldWidth, fieldHeight: fieldHeight)
    }
}