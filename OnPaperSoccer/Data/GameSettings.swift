import Foundation

struct GameSettings {
    let fieldWidth: Int
    let fieldHeight: Int
    let startingPosition: Point
}

extension GameSettings {
    static let `default` = GameSettings(fieldWidth: 9, fieldHeight: 11, startingPosition: Point(x: 4, y: 5))
}
