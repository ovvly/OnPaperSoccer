import Foundation

struct Line: Hashable {
    let from: Point
    let to: Point

    func lineInOppositeDirection() -> Line {
        return Line(from: to, to: from)
    }
}
