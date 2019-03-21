import UIKit
import RxSwift

class MatchViewController: UIViewController {
    @IBOutlet weak var fieldView: UIView!

    private(set) var currentPosition: Point

    private let fieldDrawer: FieldDrawer
    private let movesController: MovesController
    private let turnController: PlayerTurnController
    private var movesValidator: MovesValidator
    private let disposeBag = DisposeBag()

    // MARK: Init

    init(fieldDrawer: FieldDrawer,
         movesController: MovesController,
         playerTurnController: PlayerTurnController,
         movesValidator: MovesValidator,
         fieldWidth: Int, fieldHeight: Int) {
        self.fieldDrawer = fieldDrawer
        self.movesController = movesController
        self.turnController = playerTurnController
        self.movesValidator = movesValidator
        self.currentPosition = Point(x: fieldWidth / 2, y: fieldHeight / 2)

        super.init(nibName: nil, bundle: nil)

        playerTurnController.set(startingPoint: currentPosition)
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
                self.move(to: self.currentPosition.shifted(by: move.vector))
            })
            .disposed(by: disposeBag)
    }

    //MARK: Actions

    func move(to point: Point) {
        let line = Line(from: currentPosition, to: point)
        currentPosition = point
        fieldDrawer.draw(line: line, color: turnController.currentPlayer.color)
        movesValidator.setLineAsUsed(line)
        updateMovesPossibility()
        turnController.moved(to: point)
    }

    //MARK: Helpers

    private func updateMovesPossibility() {
        let possibleMoves = movesValidator.possibleMoves(from: currentPosition)
        movesController.updateMovesPossibility(possibleMoves)
    }
}
