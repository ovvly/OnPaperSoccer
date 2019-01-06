import Foundation

enum Move: Hashable, CaseIterable {
    case up
    case down
    case left
    case right
    case upLeft
    case upRight
    case downLeft
    case downRight
}

extension Move {
    var isUp: Bool {
        return Set([.up, .upLeft, .upRight]).contains(self)
    }

    var isDown: Bool {
        return Set([.down, .downLeft, .downRight]).contains(self)
    }

    var isLeft: Bool {
        return Set([.left, .upLeft, .downLeft]).contains(self)
    }

    var isRight: Bool {
        return Set([.right, .upRight, .downRight]).contains(self)
    }
}

extension Move {
    var vector: Vector {
        switch self {
            case .up: return Vector(dx: 0, dy: 1)
            case .down: return Vector(dx: 0, dy: -1)
            case .left: return Vector(dx: -1, dy: 0)
            case .right: return Vector(dx: 1, dy: 0)
            case .upLeft: return Vector(dx: -1, dy: 1)
            case .upRight: return Vector(dx: 1, dy: 1)
            case .downLeft: return Vector(dx: -1, dy: -1)
            case .downRight: return Vector(dx: 1, dy: -1)
        }
    }
}