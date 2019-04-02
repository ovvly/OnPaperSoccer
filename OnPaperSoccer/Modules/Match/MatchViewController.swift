import UIKit
import RxSwift

protocol MatchViewControllerDelegate: class {
    func playerDidWin(_ player: Player)
}

class MatchViewController: UIViewController, Resetable {
    @IBOutlet weak var fieldView: UIView!

    weak var delegate: MatchViewControllerDelegate?
    private(set) var currentPosition: Point
    private let startingPosition: Point

    private var winingPoints: [Point: Player] = [:]
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
        self.startingPosition = Point(x: fieldWidth / 2, y: fieldHeight / 2)
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

    //MARK: Pubic

    func move(to point: Point) {
        let line = Line(from: currentPosition, to: point)
        currentPosition = point
        fieldDrawer.draw(line: line, color: turnController.currentPlayer.color)
        movesValidator.setLineAsUsed(line)
        updateMovesPossibility()
        checkWiningGameConditions(from: point)
        turnController.moved(to: point)
    }

    func set(winingPoint: Point, for player: Player) {
        winingPoints[winingPoint] = player
    }

    func reset() {
        self.currentPosition = startingPosition

        fieldDrawer.reset()
        turnController.reset()
        movesValidator.reset()
        movesController.reset()
    }

    //MARK: Helpers

    private func updateMovesPossibility() {
        let possibleMoves = movesValidator.possibleMoves(from: currentPosition)
        movesController.updateMovesPossibility(possibleMoves)
    }

    private func checkWiningGameConditions(from point: Point) {
        endGameIfNoMovesLeft(from: point)
        endGameIfInWiningPoint(from: point)
    }

    private func endGameIfNoMovesLeft(from point: Point) {
        if movesValidator.possibleMoves(from: point).isEmpty {
            delegate?.playerDidWin(turnController.currentPlayer.nextPlayer())
        }
    }

    private func endGameIfInWiningPoint(from point: Point) {
        if let player = winingPoints[point] {
            delegate?.playerDidWin(player)
        }
    }
}
