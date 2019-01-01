import UIKit
import CoreGraphics

protocol FieldDrawer: WithViewController {
    func drawNewField()
    func draw(line: Line)
}

class FieldViewController: UIViewController, FieldDrawer {
    var viewController: UIViewController { return self }
    var castView: FieldView {
        return view as! FieldView
    }

    private var fieldWidth: Int
    private var fieldHeight: Int

    // MARK: Init

    init(fieldWidth: Int, fieldHeight: Int) {
        self.fieldWidth = fieldWidth
        self.fieldHeight = fieldHeight

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Actions

    func draw(line: Line) {
        castView.draw(line: line)
    }

    func drawNewField() {
        castView.drawNewField(width: fieldWidth, height: fieldHeight)
    }
}
