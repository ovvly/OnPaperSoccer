import Foundation

typealias WinningPoints = [Point: Player]

struct GameSettings {
    let fieldWidth: Int
    let fieldHeight: Int
    let startingPoint: Point
    let winingPoints: WinningPoints
}

extension GameSettings {
    static let `default` = GameSettings(fieldWidth: 9, fieldHeight: 11, startingPoint: Point(x: 4, y: 5),
        winingPoints: [Point(x: 4, y: 10): .player1, Point(x: 4, y: 0): .player2])
}
