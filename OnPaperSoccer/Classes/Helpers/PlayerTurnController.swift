import Foundation
import UIKit

protocol PlayerTurnController: Resetable {
    var currentPlayer: Player { get }
    func moved(to: Point)
}

final class DefaultPlayerTurnController: PlayerTurnController {
    var currentPlayer: Player = .player1
    var visitedPoints: Set<Point>

    private let settings: GameSettings

    //MARK: Lifecycle

    init(settings: GameSettings) {
        self.settings = settings
        visitedPoints = [settings.startingPoint]
    }

    //MARK: Actions

    func moved(to point: Point) {
        if canContinueAfterMoving(to: point) { return }
        currentPlayer = currentPlayer.nextPlayer()
        visitedPoints.insert(point)
    }

    func reset() {
        currentPlayer = .player1
        visitedPoints = [settings.startingPoint]
    }

    //MARK: Helpers

    private func canContinueAfterMoving(to point: Point) -> Bool {
        isOnBorderLine(point: point) || visitedPoints.contains(point)
    }

    private func isOnBorderLine(point: Point) -> Bool {
        point.x == 0 || point.x == settings.fieldWidth - 1 ||
                point.y == 0 || point.y == settings.fieldHeight - 1
    }
}
