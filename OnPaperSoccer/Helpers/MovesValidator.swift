import Foundation

protocol MovesValidator {
    func isValidMove(from point: Point, by vector: Vector) -> Bool
}

final class DefaultMovesValidator: MovesValidator {
    func isValidMove(from point: Point, by vector: Vector) -> Bool {
        let endingMove = point.shifted(by: vector)
        return endingMove.x >= 0 && endingMove.x <= 8
    }
}
