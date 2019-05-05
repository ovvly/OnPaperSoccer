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
        visitedPoints = [settings.startingPosition]
    }

    //MARK: Actions

    func moved(to point: Point) {
        guard !isEndingOnBorderLine(point: point) else { return }
        if !visitedPoints.contains(point) {
            currentPlayer = currentPlayer.nextPlayer()
        }
        visitedPoints.insert(point)
    }

    func reset() {
        currentPlayer = .player1
        visitedPoints = [settings.startingPosition]
    }

    //MARK: Helpers

    private func isEndingOnBorderLine(point: Point) -> Bool {
        return point.x == 0 || point.x == settings.fieldWidth - 1 ||
            point.y == 0 || point.y == settings.fieldHeight - 1
    }
}
