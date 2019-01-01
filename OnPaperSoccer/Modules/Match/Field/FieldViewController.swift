import UIKit
import CoreGraphics

protocol FieldDrawer: WithViewController {
    func drawNewField(width: Int, height: Int)
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

    func drawNewField(width: Int, height: Int) {
        castView.drawNewField(width: width, height: height)
    }
}
