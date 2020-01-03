import UIKit
import CoreGraphics

protocol FieldDrawer: WithViewController, Resetable {
    func drawNewField()
    func draw(line: Line, color: UIColor)
    func mark(currentPoint: Point, with color: UIColor)
}

class FieldViewController: UIViewController, FieldDrawer {
    var fieldView: FieldView {
        return view as! FieldView
    }

    private let settings: GameSettings

    // MARK: Init

    init(settings: GameSettings) {
        self.settings = settings

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Actions

    func draw(line: Line, color: UIColor) {
        fieldView.draw(line: line, color: color)
    }

    func mark(currentPoint: Point, with color: UIColor) {
        fieldView.mark(currentPoint: currentPoint, with: color)
    }

    func drawNewField() {
        fieldView.drawNewField(width: settings.fieldWidth, height: settings.fieldHeight)
    }

    func reset() {
        fieldView.reset()
    }
}
