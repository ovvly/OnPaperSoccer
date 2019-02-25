import Foundation

protocol MovesValidator {
    func possibleMoves(from point: Point) -> Set<Move>
    func setLineAsUsed(_ line: Line)
}

final class DefaultMovesValidator: MovesValidator {
    var usedLines = Set<Line>()

    private let fieldWidth: Int
    private let fieldHeight: Int

    init(fieldWidth: Int, fieldHeight: Int) {
        self.fieldWidth = fieldWidth
        self.fieldHeight = fieldHeight
    }

    func possibleMoves(from point: Point) -> Set<Move> {
        return Set(Move.allCases.filter { move in
            return isValidMove(from: point, moving: move)
        })
    }

    func setLineAsUsed(_ line: Line) {
        usedLines.insert(line)
    }

    private func isValidMove(from point: Point, moving move: Move) -> Bool {
        let endPoint = point.shifted(by: move.vector)

        let line = Line(from: point, to: endPoint)
        if isBorderLine(line) { return false }
        if !usedLines.intersection([line, line.lineInOppositeDirection()]).isEmpty { return false }

        return true
    }

    private func isBorderLine(_ line: Line) -> Bool {
        if line.from.x == 0 && line.to.x == 0 { return true }
        if line.from.x == fieldWidth - 1 && line.to.x == fieldWidth - 1 { return true }
        if line.from.y == 0 && line.to.y == 0 { return true }
        if line.from.y == fieldHeight - 1 && line.to.y == fieldHeight - 1 { return true }
        return false
    }
}
