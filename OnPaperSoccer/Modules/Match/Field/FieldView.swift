import Foundation
import UIKit
import CoreGraphics

final class FieldView: UIView {
    private let margin: CGFloat = 10
    private var numberOfColumns = 0
    private var numberOfRows = 0

    private var isFieldDrawn = false
    private var lineToDraw: Line?
    private var colorToDraw: UIColor = .black
    private var drawImage: CGImage?

    //MARK: Lifecycle

    private let currentPointView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        view.layer.cornerRadius = 5.0
        return view
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
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

    //MARK: Actions

    func drawNewField(width: Int, height: Int) {
        numberOfColumns = width
        numberOfRows = height

        isFieldDrawn = false
        setNeedsDisplay()
    }

    func draw(line: Line, color: UIColor) {
        lineToDraw = line
        colorToDraw = color
        setNeedsDisplay()
    }

    func mark(currentPoint: Point, with color: UIColor) {
        currentPointView.backgroundColor = color
        let spacing = calculateSpacing()
        let shiftVector = calculateShiftVector(spacing: spacing)
        let currentPointCenter = CGPoint(x: currentPoint.x * spacing, y: (numberOfRows - currentPoint.y - 1) * spacing).apply(vector: shiftVector)
        currentPointView.center = currentPointCenter
    }

    func reset() {
        drawNewField(width: numberOfColumns, height: numberOfRows)
        lineToDraw = nil
        drawImage = nil
    }

    //MARK: Helpers

    private func setup() {
        addSubview(currentPointView)
    }

    private func drawField() {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        let borderPath = calculateBorderLine()
        drawBackgroundField(in: context, using: borderPath)
        drawLines(in: context)
        drawBorderLines(in: context, using: borderPath)
        drawImage = context.makeImage()
    }

    private func drawBackgroundField(in context: CGContext, using path: UIBezierPath) {
        UIColor.App.field.setFill()
        path.fill()
    }

    private func drawLines(in context: CGContext) {
        let spacing = calculateSpacing()
        let shiftVector = calculateShiftVector(spacing: spacing)

        let path = UIBezierPath()
        path.lineWidth = 1

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
        UIColor.App.lines.setStroke()
        path.stroke()
    }

    private func drawBorderLines(in context: CGContext, using path: UIBezierPath) {
        UIColor.App.borderlines.setStroke()
        path.stroke()
    }

    private func calculateBorderLine() -> UIBezierPath {
        let spacing = calculateSpacing()
        let shiftVector = calculateShiftVector(spacing: spacing)

        let path = UIBezierPath()
        path.lineWidth = 1

        let upLeftCornerPoint = CGPoint(x: 0, y: 0).apply(vector: shiftVector)
        let upRightCornerPoint = CGPoint(x: 0, y: CGFloat(numberOfRows - 1) * spacing).apply(vector: shiftVector)
        let downRightCornerPoint = CGPoint(x: spacing * CGFloat(numberOfColumns - 1), y: CGFloat(numberOfRows - 1) * spacing).apply(vector: shiftVector)
        let downLeftCornerPoint = CGPoint(x: spacing * CGFloat(numberOfColumns - 1), y: 0).apply(vector: shiftVector)

        path.move(to: upLeftCornerPoint)
        path.addLine(to: upRightCornerPoint)
        path.addLine(to: downRightCornerPoint)
        path.addLine(to: downLeftCornerPoint)
        path.addLine(to: upLeftCornerPoint)
        path.close()

        return path
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
        colorToDraw.setStroke()

        let spacing = calculateSpacing()
        let shiftVector = calculateShiftVector(spacing: spacing)
        let startPoint = CGPoint(x: start.x * spacing, y: (numberOfRows - start.y - 1) * spacing).apply(vector: shiftVector)
        let endPoint = CGPoint(x: end.x * spacing, y: (numberOfRows - end.y - 1) * spacing).apply(vector: shiftVector)

        path.move(to: startPoint)
        path.addLine(to: endPoint)

        path.close()
        path.stroke()

        UIColor.App.lineEnd.setFill()
        drawPoint(in: startPoint)
        drawPoint(in: endPoint)
    }

    private func drawPoint(in point: CGPoint) {
        let context = UIGraphicsGetCurrentContext()
        let pointShift = Constants.lineEndSize / 2

        context?.fillEllipse(in: CGRect(x: point.x - pointShift, y: point.y - pointShift, width: Constants.lineEndSize, height: Constants.lineEndSize))
    }

    private struct Constants {
        static let lineEndSize: CGFloat = 6
    }
}
