import Foundation

@testable import OnPaperSoccer

extension GameSettings {
    static var fixture: GameSettings {
        return GameSettings.fixture(winningPoints: [:])
    }

    static func fixture(winningPoints: WinningPoints) -> GameSettings {
        return GameSettings(fieldWidth: 42, fieldHeight: 43, startingPoint: Point.fixture, winingPoints: winningPoints)
    }
}
