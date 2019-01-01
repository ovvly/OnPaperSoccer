import Foundation

protocol MovesValidator {
    func isValidMove(from point: Point, by vector: Vector) -> Bool
}

final class DefaultMovesValidator: MovesValidator {
    private let fieldWidth: Int
    private let fieldHeight: Int

    init(fieldWidth: Int, fieldHeight: Int) {
        self.fieldWidth = fieldWidth
        self.fieldHeight = fieldHeight
    }

    func isValidMove(from point: Point, by vector: Vector) -> Bool {
        let endingMove = point.shifted(by: vector)
        guard endingMove.x < fieldWidth && endingMove.x >= 0 else { return false }
        guard endingMove.y < fieldHeight && endingMove.y >= 0 else { return false }
        return true
    }
}
