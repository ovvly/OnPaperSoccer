import UIKit
import RxSwift

class MatchViewController: UIViewController {
    @IBOutlet weak var fieldView: UIView!

    var currentPosition: Point = Point(x: 4, y: 5) {
        didSet {
            let line = Line(from: oldValue, to: currentPosition)
            fieldDrawer.draw(line: line)
        }
    }

    private let fieldDrawer: FieldDrawer
    private let movesController: MovesController
    private let movesValidator: MovesValidator
    private let disposeBag = DisposeBag()

    // MARK: Init

    init(fieldDrawer: FieldDrawer, movesController: MovesController, movesValidator: MovesValidator) {
        self.fieldDrawer = fieldDrawer
        self.movesController = movesController
        self.movesValidator = movesValidator

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(viewController: fieldDrawer.viewController, to: fieldView)
        addChild(viewController: movesController.viewController, to: view)
        fieldDrawer.drawNewField()

        movesController.moves
            .filter { self.movesValidator.isValidMove(from: self.currentPosition, by: $0)}
            .subscribe(onNext: { [unowned self] vector in
                self.currentPosition = self.currentPosition.shifted(by: vector)
            })
            .disposed(by: disposeBag)

    }
}
