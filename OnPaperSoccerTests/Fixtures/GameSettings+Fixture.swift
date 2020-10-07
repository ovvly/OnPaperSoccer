import Foundation

@testable import OnPaperSoccer

extension FieldSettings {
    static var fixture: FieldSettings {
        return FieldSettings.fixture(winningPoints: [:])
    }

    static func fixture(winningPoints: WinningPoints) -> FieldSettings {
        return FieldSettings(fieldWidth: 42, fieldHeight: 43, startingPoint: Point.fixture, winingPoints: winningPoints)
    }
}
