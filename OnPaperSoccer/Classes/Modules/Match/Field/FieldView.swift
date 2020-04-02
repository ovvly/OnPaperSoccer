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

    lazy var spacing: CGFloat = {
        calculateSpacing()
    }()

    lazy var shiftVector: CGVector = {
        calculateShiftVector(spacing: spacing)
    }()

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
    
    override func layoutSubviews() {
        super.layoutSubviews()

        spacing = calculateSpacing()
        shiftVector = calculateShiftVector(spacing: spacing)
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
        currentPointView.center = cgPoint(from: (currentPoint.x, numberOfRows - currentPoint.y - 1))
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
        let path = UIBezierPath()
        path.lineWidth = 1

        for column in 0..<numberOfColumns {
            let start =  cgPoint(from: (column, 0))
            let end = cgPoint(from: (column, numberOfRows - 1))
            path.move(to: start)
            path.addLine(to: end)
        }

        for row in 0..<numberOfRows {
            let start = cgPoint(from: (0, row))
            let end = cgPoint(from: (numberOfColumns - 1, row))
            path.move(to: start)
            path.addLine(to: end)
        }

        path.close()
        UIColor.App.lines.setStroke()
        path.stroke()
    }

    private func drawBorderLines(in context: CGContext, using path: UIBezierPath) {
        let path = UIBezierPath()
        path.lineWidth = 1

        let leftSidePoints = [(0,0),
                              (0, numberOfRows-1),
                              (3, numberOfRows-1)]
            .map(cgPoint(from:))
        
        let rightSidePoints = [(numberOfColumns-1, numberOfRows-1),
                               (numberOfColumns-1, 0),
                               (5, 0)]
            .map(cgPoint(from:))

        path.move(to: cgPoint(from: (3, 0)))
        leftSidePoints.forEach { point in
            path.addLine(to: point)
        }
        
        path.move(to: cgPoint(from:(5, numberOfRows-1)))
        rightSidePoints.forEach { point in
            path.addLine(to: point)
        }

        UIColor.App.borderlines.setStroke()
        path.stroke()

        drawGoalPosts(spacing: spacing, shiftVector: shiftVector)
    }
    private func drawGoalPosts(spacing: CGFloat, shiftVector: CGVector) {
        UIColor.App.lineEnd.setFill()
        [(5, numberOfRows-1),
         (3, numberOfRows-1),
         (3, 0),
         (5, 0)]
            .map(cgPoint(from:))
            .forEach { drawPoint(in: $0) }
    }

    private func calculateBorderLine() -> UIBezierPath {
        let path = UIBezierPath()
        path.lineWidth = 1

        let upLeftCornerPoint = cgPoint(from: (0, 0))
        let upRightCornerPoint = cgPoint(from: (0, numberOfRows-1))
        let downRightCornerPoint = cgPoint(from: (numberOfColumns-1, numberOfRows-1))
        let downLeftCornerPoint = cgPoint(from: (numberOfColumns-1, 0))

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

        let startPoint = cgPoint(from: (start.x, (numberOfRows - start.y - 1)))
        let endPoint = cgPoint(from: (end.x, (numberOfRows - end.y - 1)))

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

    private func cgPoint(from point: (Int, Int)) -> CGPoint {
        CGPoint(x: point.0 * spacing, y: point.1 * spacing).apply(vector: shiftVector)
    }

    private struct Constants {
        static let lineEndSize: CGFloat = 6
    }
}
