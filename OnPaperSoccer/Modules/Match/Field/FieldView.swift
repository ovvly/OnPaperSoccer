import Foundation
import UIKit
import CoreGraphics

final class FieldView: UIView {
    private let margin: CGFloat = 10
    private let numberOfColumns = 9
    private let numberOfRows = 11

    private var isFieldDrawn = false
    private var lineToDraw: Line?
    private var drawImage: CGImage?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func draw(_ rect: CGRect) {
        if !isFieldDrawn {
            drawField()
            isFieldDrawn = true
        }
        if let line = lineToDraw {
            guard let image = drawImage else { return }
            let context = UIGraphicsGetCurrentContext()
            UIImage(cgImage: image).draw(in: rect)
            drawLine(from: line.from, to: line.to)
            drawImage = context?.makeImage()

            lineToDraw = nil
        }
    }

    func drawNewField() {
        isFieldDrawn = false
        setNeedsDisplay()
    }

    func draw(line: Line) {
        lineToDraw = line
        setNeedsDisplay()
    }

    private func drawField() {
        let spacing = calculateSpacing()
        let shiftVector = calculateShiftVector(spacing: spacing)

        let context = UIGraphicsGetCurrentContext()
        let path = UIBezierPath()
        path.lineWidth = 2

        for column in 0..<numberOfColumns {
            let start = CGPoint(x: CGFloat(column) * spacing, y: 0).apply(vector: shiftVector)
            let end = CGPoint(x: CGFloat(column) * spacing, y: CGFloat(numberOfRows - 1) * spacing).apply(vector: shiftVector)
            path.move(to: start)
            path.addLine(to: end)
        }

        for row in 0..<numberOfRows {
            let start = CGPoint(x: 0, y: CGFloat(row) * spacing).apply(vector: shiftVector)
            let end = CGPoint(x: spacing * CGFloat(numberOfColumns - 1), y: CGFloat(row) * spacing).apply(vector: shiftVector)
            path.move(to: start)
            path.addLine(to: end)
        }

        path.close()
        UIColor.red.setStroke()
        path.stroke()

        drawImage = context?.makeImage()
    }

    private func calculateShiftVector(spacing: CGFloat) -> CGVector {
        let fieldCenterX = ((numberOfColumns - 1) * spacing + margin * 2) / 2
        let fieldCenterY = ((numberOfRows - 1) * spacing + margin * 2) / 2
        let centeringVector = CGVector(dx: center.x - fieldCenterX, dy: center.y - fieldCenterY)
        let marginVector = CGVector(dx: margin, dy: margin)
        let shiftVector = marginVector + centeringVector
        return shiftVector
    }

    private func calculateSpacing() -> CGFloat {
        let drawingSize = CGSize(width: bounds.size.width - 2 * margin, height: bounds.size.height - 2 * margin)
        let horizontalSpacing = drawingSize.width / (numberOfColumns - 1)
        let verticalSpacing = drawingSize.height / (numberOfRows - 1)
        let spacing = min(horizontalSpacing, verticalSpacing)
        return spacing
    }

    private func drawLine(from start: Point, to end: Point) {
        let path = UIBezierPath()
        path.lineWidth = 3

        let spacing = calculateSpacing()
        let shiftVector = calculateShiftVector(spacing: spacing)
        let startPoint = CGPoint(x: start.x * spacing, y: (numberOfRows - start.y - 1) * spacing).apply(vector: shiftVector)
        let endPoint = CGPoint(x: end.x * spacing, y: (numberOfRows - end.y - 1) * spacing).apply(vector: shiftVector)

        path.move(to: startPoint)
        path.addLine(to: endPoint)

        path.close()
        UIColor.blue.setStroke()
        path.stroke()
    }
}
