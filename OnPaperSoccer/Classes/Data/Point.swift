import Foundation

struct Point: Hashable {
    let x: Int
    let y: Int

    func shifted(by vector: Vector) -> Point {
        return Point(x: x + vector.dx, y: y + vector.dy)
    }
}
