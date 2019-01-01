import UIKit
import RxSwift

class MatchViewController: UIViewController {
    @IBOutlet weak var fieldView: UIView!

    var currentPosition: Point {
        didSet {
            let line = Line(from: oldValue, to: currentPosition)
            fieldDrawer.draw(line: line)
        }
    }

    private let fieldDrawer: FieldDrawer
    private let movesController: MovesController
    private var movesValidator: MovesValidator
    private let fieldWidth: Int
    private let fieldHeight: Int
    private let disposeBag = DisposeBag()

    // MARK: Init

    init(fieldDrawer: FieldDrawer, movesController: MovesController, movesValidator: MovesValidator, fieldWidth: Int = 9, fieldHeight: Int = 11) {
        self.fieldDrawer = fieldDrawer
        self.movesController = movesController
        self.movesValidator = movesValidator
        self.fieldWidth = fieldWidth
        self.fieldHeight = fieldHeight
        self.currentPosition = Point(x: fieldWidth / 2, y: fieldHeight / 2)

        super.init(nibName: nil, bundle: nil)

        self.movesValidator.fieldWidth = fieldWidth
        self.movesValidator.fieldHeight = fieldHeight
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(viewController: fieldDrawer.viewController, to: fieldView)
        addChild(viewController: movesController.viewController, to: view)
        fieldDrawer.drawNewField(width: fieldWidth, height: fieldHeight)

        movesController.moves
            .filter { self.movesValidator.isValidMove(from: self.currentPosition, by: $0)}
            .subscribe(onNext: { [unowned self] vector in
                self.currentPosition = self.currentPosition.shifted(by: vector)
            })
            .disposed(by: disposeBag)

    }
}
