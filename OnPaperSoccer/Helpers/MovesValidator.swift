import Foundation

protocol MovesValidator {
    var fieldWidth: Int { get set}
    var fieldHeight: Int { get set}
    func isValidMove(from point: Point, by vector: Vector) -> Bool
}

final class DefaultMovesValidator: MovesValidator {
    var fieldWidth: Int = 0
    var fieldHeight: Int = 0

    func isValidMove(from point: Point, by vector: Vector) -> Bool {
        let endingMove = point.shifted(by: vector)
        guard endingMove.x < fieldWidth && endingMove.x >= 0 else { return false }
        guard endingMove.y < fieldHeight && endingMove.y >= 0 else { return false }
        return true
    }
}
