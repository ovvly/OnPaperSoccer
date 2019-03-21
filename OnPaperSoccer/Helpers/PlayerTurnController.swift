import Foundation
import UIKit

protocol PlayerTurnController {
    var currentPlayer: Player { get }
    func moved(to: Point)
    func set(startingPoint: Point)
}

final class DefaultPlayerTurnController: PlayerTurnController {
    var currentPlayer: Player = .player1
    var visitedPoints = Set<Point>()

    private let fieldWidth: Int
    private let fieldHeight: Int

    init(fieldWidth: Int, fieldHeight: Int) {
        self.fieldWidth = fieldWidth
        self.fieldHeight = fieldHeight
    }

    func moved(to point: Point) {
        guard !isEndingOnBorderLine(point: point) else { return }
        if !visitedPoints.contains(point) {
            currentPlayer = currentPlayer.nextPlayer()
        }
        visitedPoints.insert(point)
    }

    private func isEndingOnBorderLine(point: Point) -> Bool {
        return point.x == 0 || point.x == fieldWidth - 1 ||
            point.y == 0 || point.y == fieldHeight - 1
    }

    func set(startingPoint: Point) {
        visitedPoints.insert(startingPoint)
    }
}