import UIKit

protocol LineDrawer {
    func drawNewField()
    func draw(line: Line)
}

typealias FieldController = UIViewController & LineDrawer

class FieldViewController: UIViewController, LineDrawer {

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
