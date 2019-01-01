import Foundation

struct Vector {
    let dx: Int
    let dy: Int
}

extension Vector {
    static var up: Vector {
        return Vector(dx: 0, dy: 1)
    }

    static var down: Vector {
        return Vector(dx: 0, dy: -1)
    }

    static var left: Vector {
        return Vector(dx: -1, dy: 0)
    }

    static var right: Vector {
        return Vector(dx: 1, dy: 0)
    }

    static var upLeft: Vector {
        return Vector(dx: -1, dy: 1)
    }

    static var upRight: Vector {
        return Vector(dx: 1, dy: 1)
    }

    static var downLeft: Vector {
        return Vector(dx: -1, dy: -1)
    }

    static var downRight: Vector {
        return Vector(dx: 1, dy: -1)
    }
}