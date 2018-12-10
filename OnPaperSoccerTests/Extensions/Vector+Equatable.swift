import Foundation

@testable import OnPaperSoccer

extension Vector: Equatable {
    public static func ==(lhs: Vector, rhs: Vector) -> Bool {
        return lhs.dx == rhs.dx && lhs.dy == rhs.dy
    }
}