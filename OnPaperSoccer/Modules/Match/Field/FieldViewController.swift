import UIKit
import CoreGraphics

protocol FieldDrawer: WithViewController, Resetable {
    func drawNewField()
    func draw(line: Line, color: UIColor)
}

class FieldViewController: UIViewController, FieldDrawer {
    var viewController: UIViewController { return self }
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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Actions

    func draw(line: Line, color: UIColor) {
        fieldView.draw(line: line, color: color)
    }

    func drawNewField() {
        fieldView.drawNewField(width: settings.fieldWidth, height: settings.fieldHeight)
    }

    func reset() {
        fieldView.reset()
    }
}
