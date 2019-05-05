import Foundation

@testable import OnPaperSoccer

extension GameSettings {
    static var fixture: GameSettings {
        return GameSettings(fieldWidth: 42, fieldHeight: 43, startingPosition: Point.fixture)
    }
}
