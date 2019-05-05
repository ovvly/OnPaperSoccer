import Foundation

struct GameSettings {
    let fieldWidth: Int
    let fieldHeight: Int
}

extension GameSettings {
    static let `default` = GameSettings(fieldWidth: 9, fieldHeight: 11)
}
