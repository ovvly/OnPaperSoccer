import Foundation
import UIKit

enum Player {
    case player1
    case player2

    func nextPlayer() -> Player {
        switch self {
        case .player1: return .player2
        case .player2: return .player1
        }
    }
}

extension Player {
    var color: UIColor {
        switch self {
        case .player1: return .blue
        case .player2: return .green
        }
    }
}