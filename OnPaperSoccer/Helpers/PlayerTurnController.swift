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

    func moved(to point: Point) {
        if !visitedPoints.contains(point) {
            currentPlayer = currentPlayer.nextPlayer()
        }
        visitedPoints.insert(point)
    }

    func set(startingPoint: Point) {
        visitedPoints.insert(startingPoint)
    }
}