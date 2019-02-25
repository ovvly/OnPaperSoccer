import UIKit
import RxSwift

class MatchViewController: UIViewController {
    @IBOutlet weak var fieldView: UIView!

    var currentPosition: Point {
        didSet {
            let line = Line(from: oldValue, to: currentPosition)
            fieldDrawer.draw(line: line)
            movesValidator.setLineAsUsed(line)
            updateMovesPossibility()
        }
    }

    private let fieldDrawer: FieldDrawer
    private let movesController: MovesController
    private var movesValidator: MovesValidator
    private let disposeBag = DisposeBag()

    // MARK: Init

    init(fieldDrawer: FieldDrawer, movesController: MovesController, movesValidator: MovesValidator, fieldWidth: Int, fieldHeight: Int) {
        self.fieldDrawer = fieldDrawer
        self.movesController = movesController
        self.movesValidator = movesValidator
        self.currentPosition = Point(x: fieldWidth / 2, y: fieldHeight / 2)

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
            .subscribe(onNext: { [unowned self] move in
                self.currentPosition = self.currentPosition.shifted(by: move.vector)
            })
            .disposed(by: disposeBag)

    }

    //MARK: Helpers

    private func updateMovesPossibility() {
        let possibleMoves = movesValidator.possibleMoves(from: currentPosition)
        movesController.updateMovesPossibility(possibleMoves)
    }
}
