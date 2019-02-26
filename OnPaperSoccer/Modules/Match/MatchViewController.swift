import UIKit
import RxSwift

enum Player {
    case player1
    case player2

    func nextPlayer() -> Player {
        switch self {
            case .player1: return .player2
            case .player2: return .player1
        }
    }
}

class MatchViewController: UIViewController {
    @IBOutlet weak var fieldView: UIView!

    private(set) var currentPlayer: Player = .player1
    private(set) var currentPosition: Point

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
                self.move(to: self.currentPosition.shifted(by: move.vector))
            })
            .disposed(by: disposeBag)

    }

    //MARK: Actions

    func move(to point: Point) {
        let line = Line(from: currentPosition, to: point)
        currentPosition = point
        fieldDrawer.draw(line: line)
        movesValidator.setLineAsUsed(line)
        updateMovesPossibility()

        changePlayer(to: currentPlayer.nextPlayer())
    }

    func changePlayer(to player: Player) {
        currentPlayer = player
        switch currentPlayer {
            case .player1: fieldDrawer.changeLineColor(to: .blue)
            case .player2: fieldDrawer.changeLineColor(to: .green)
        }
    }

    //MARK: Helpers

    private func updateMovesPossibility() {
        let possibleMoves = movesValidator.possibleMoves(from: currentPosition)
        movesController.updateMovesPossibility(possibleMoves)
    }
}
