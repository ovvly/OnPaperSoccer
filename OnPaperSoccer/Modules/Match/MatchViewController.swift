import UIKit
import RxSwift

protocol MatchViewControllerDelegate: class {
    func playerDidWin(_ player: Player)
}

class MatchViewController: UIViewController, Resetable {
    @IBOutlet weak var fieldView: UIView!
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var turnView: UIView!
    @IBOutlet weak var turnLabel: UILabel!
    
    weak var delegate: MatchViewControllerDelegate?
    private(set) var currentPosition: Point
    private let settings: GameSettings

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
         settings: GameSettings) {
        self.fieldDrawer = fieldDrawer
        self.movesController = movesController
        self.turnController = playerTurnController
        self.movesValidator = movesValidator
        self.settings = settings
        self.currentPosition = settings.startingPoint

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(viewController: fieldDrawer.viewController, to: fieldView)
        addChild(viewController: movesController.viewController, to: mainContentView)
        fieldDrawer.drawNewField()
        updateTurnIndicator(with: turnController.currentPlayer)

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
        updateTurnIndicator(with: turnController.currentPlayer)
    }

    func reset() {
        currentPosition = settings.startingPoint

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
        if let player = settings.winingPoints[point] {
            delegate?.playerDidWin(player)
        }
    }

    private func updateTurnIndicator(with player: Player) {
        turnView.backgroundColor = player.color
        turnLabel.text = "\(player.name) PLAYER TURN"
    }
}
