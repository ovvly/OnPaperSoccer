import UIKit
import SpriteKit

protocol WithViewController {
    var viewController: UIViewController { get }
}

protocol FieldDrawer: WithViewController {
    func drawNewField()
    func draw(line: Line)
}

class FieldViewController: UIViewController, FieldDrawer {
    var viewController: UIViewController {
        return self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
    }

    // MARK: Actions

    func draw(line: Line) {
        print(line)
    }

    func drawNewField() {
        
    }
}
