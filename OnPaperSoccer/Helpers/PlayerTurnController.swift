import Foundation
import UIKit

protocol PlayerTurnController {
    var currentPlayer: Player { get }
    func moved(to: Point)
}

final class DefaultPlayerTurnController: PlayerTurnController {
    var currentPlayer: Player = .player1
    //TODO: add starting point to used points
    var visitedPoints = Set<Point>()

    func moved(to point: Point) {
        if !visitedPoints.contains(point) {
            currentPlayer = currentPlayer.nextPlayer()
        }
        visitedPoints.insert(point)
    }
}