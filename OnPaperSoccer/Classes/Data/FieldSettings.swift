import Foundation

typealias WinningPoints = [Point: Player]

struct FieldSettings {
    let fieldWidth: Int
    let fieldHeight: Int
    let startingPoint: Point
    let winingPoints: WinningPoints
}

extension FieldSettings {
    static let `default` = FieldSettings(fieldWidth: 9, fieldHeight: 11, startingPoint: Point(x: 4, y: 5),
        winingPoints: [Point(x: 4, y: 10): .player1, Point(x: 4, y: 0): .player2])
}
