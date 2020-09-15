import UIKit
import CoreGraphics

protocol FieldDrawer: WithViewController, Resetable {
    func drawNewField()
    func draw(line: Line, color: UIColor)
    func mark(currentPoint: Point, with color: UIColor)
}

final class FieldViewController: UIViewController, FieldDrawer, WithCustomView {
    typealias CustomView = FieldView

    private let settings: GameSettings

    // MARK: Init

    init(settings: GameSettings) {
        self.settings = settings
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
       view = FieldView()
    }

    // MARK: Actions

    func draw(line: Line, color: UIColor) {
        customView.draw(line: line, color: color)
    }

    func mark(currentPoint: Point, with color: UIColor) {
        customView.mark(currentPoint: currentPoint, with: color)
    }

    func drawNewField() {
        customView.drawNewField(width: settings.fieldWidth, height: settings.fieldHeight)
    }

    func reset() {
        customView.reset()
    }
}
