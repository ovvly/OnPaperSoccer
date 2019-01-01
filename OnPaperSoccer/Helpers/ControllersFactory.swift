import Foundation

final class ControllersFactory {
    func createMatchViewController() -> MatchViewController {
        let fieldViewController = FieldViewController()
        let movesViewController = MovesViewController()
        let movesValidator = DefaultMovesValidator()
        return MatchViewController(fieldDrawer: fieldViewController, movesController: movesViewController, movesValidator: movesValidator)
    }
}