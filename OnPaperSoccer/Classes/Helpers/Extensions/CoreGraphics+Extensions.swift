import Foundation
import CoreGraphics

extension CGPoint {
    func apply(vector: CGVector) -> CGPoint {
        return CGPoint(x: x + vector.dx, y: y + vector.dy)
    }
}

extension CGVector {
    static func +(lhs: CGVector, rhs: CGVector) -> CGVector {
        return CGVector(dx: lhs.dx + rhs.dx, dy: lhs.dy + rhs.dy)
    }
}

extension CGFloat {
    static func *(lhs: CGFloat, rhs: Int) -> CGFloat {
        return lhs * CGFloat(rhs)
    }

    static func *(lhs: Int, rhs: CGFloat) -> CGFloat {
        return rhs * lhs
    }

    static func /(lhs: CGFloat, rhs: Int) -> CGFloat {
        return lhs / CGFloat(rhs)
    }

    static func /(lhs: Int, rhs: CGFloat) -> CGFloat {
        return CGFloat(lhs) / rhs
    }
}