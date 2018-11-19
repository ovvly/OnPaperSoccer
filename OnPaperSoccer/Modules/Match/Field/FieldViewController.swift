import UIKit
import CoreGraphics

protocol WithViewController {
    var viewController: UIViewController { get }
}

protocol FieldDrawer: WithViewController {
    func drawNewField()
    func draw(line: Line)
}

class FieldViewController: UIViewController, FieldDrawer {
    var viewController: UIViewController { return self }
    var castView: FieldView {
        return view as! FieldView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Actions

    func draw(line: Line) {
        castView.draw(line: line)
    }

    func drawNewField() {
        castView.drawNewField()
    }
}
