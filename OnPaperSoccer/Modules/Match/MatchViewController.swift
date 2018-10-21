import UIKit

class MatchViewController: UIViewController {
    @IBOutlet weak var fieldView: UIView!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!

    var currentPosition: Point = Point(x: 0, y: 0) {
        didSet {
            let line = Line(from: oldValue, to: currentPosition)
            fieldDrawer.draw(line: line)
        }
    }

    private let fieldDrawer: FieldDrawer

    // MARK: Init

    init(fieldDrawer: FieldDrawer) {
        self.fieldDrawer = fieldDrawer

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(viewController: fieldDrawer.viewController, to: fieldView)
        fieldDrawer.drawNewField()
    }

    // MARK: Actions
    
    @IBAction
    private func upButtonTapped(_ sender: UIButton) {
        currentPosition = Point(x: currentPosition.x, y: currentPosition.y + 1)
    }

    @IBAction
    func downButtonTapped(_ sender: UIButton) {
        currentPosition = Point(x: currentPosition.x, y: currentPosition.y - 1)
    }

    @IBAction
    func leftButtonTapped(_ sender: UIButton) {
        currentPosition = Point(x: currentPosition.x - 1, y: currentPosition.y)
    }

    @IBAction
    func rightButtonTapped(_ sender: UIButton) {
        currentPosition = Point(x: currentPosition.x + 1, y: currentPosition.y)
    }
}
