import Foundation
import UIKit

protocol PlayerTurnController: Resetable {
    var currentPlayer: Player { get }
    func moved(to: Point)
    func set(startingPoint: Point)
}

final class DefaultPlayerTurnController: PlayerTurnController {
    var currentPlayer: Player = .player1
    var visitedPoints = Set<Point>()

    private let fieldWidth: Int
    private let fieldHeight: Int

    //MARK: Lifecycle

    init(settings: GameSettings) {
        self.fieldWidth = settings.fieldWidth
        self.fieldHeight = settings.fieldHeight
    }

    //MARK: Actions

    func moved(to point: Point) {
        guard !isEndingOnBorderLine(point: point) else { return }
        if !visitedPoints.contains(point) {
            currentPlayer = currentPlayer.nextPlayer()
        }
        visitedPoints.insert(point)
    }

    func set(startingPoint: Point) {
        visitedPoints.insert(startingPoint)
    }

    func reset() {
        currentPlayer = .player1
        visitedPoints = []
    }

    //MARK: Helpers

    private func isEndingOnBorderLine(point: Point) -> Bool {
        return point.x == 0 || point.x == fieldWidth - 1 ||
            point.y == 0 || point.y == fieldHeight - 1
    }
}