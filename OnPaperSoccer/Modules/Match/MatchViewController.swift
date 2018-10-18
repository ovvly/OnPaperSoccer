import UIKit

class MatchViewController: UIViewController {
    @IBOutlet weak var matchViewContainer: UIView!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!

    var currentPosition: Point = Point(x: 0, y: 0) {
        didSet {
            let line = Line(from: oldValue, to: currentPosition)
            fieldController.draw(line: line)
        }
    }

    private let fieldController: FieldController

    // MARK: Init

    init(fieldController: FieldController) {
        self.fieldController = fieldController

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildViewController(fieldController)
        matchViewContainer.addContentSubview(fieldController.view)
        fieldController.didMove(toParentViewController: self)

        fieldController.drawNewField()
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

extension UIView {
    func addContentSubview(_ view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
