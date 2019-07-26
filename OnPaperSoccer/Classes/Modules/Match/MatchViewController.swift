import UIKit

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
        addChildrenViewControllers()
        setupNavigationBar()
        fieldDrawer.drawNewField()
        updateTurnIndicator(with: turnController.currentPlayer)
        movesController.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        fieldDrawer.mark(currentPoint: currentPosition, with: turnController.currentPlayer.color)
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
        fieldDrawer.mark(currentPoint: currentPosition, with: turnController.currentPlayer.color)
        updateTurnIndicator(with: turnController.currentPlayer)
    }

    func reset() {
        currentPosition = settings.startingPoint

        fieldDrawer.reset()
        turnController.reset()
        movesValidator.reset()
        movesController.reset()
        fieldDrawer.mark(currentPoint: currentPosition, with: turnController.currentPlayer.color)
    }

    //MARK: Helpers

    private func addChildrenViewControllers() {
        addChild(viewController: fieldDrawer.viewController, to: fieldView)
        addChild(viewController: movesController.viewController, to: mainContentView)
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reset", style: .done, target: self, action: #selector(resetTapped))
        navigationController?.navigationBar.tintColor = UIColor.App.textColor
    }

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

    @objc
    private func resetTapped() {
        reset()
    }
}

extension MatchViewController: MovesControllerDelegate {
    func didMove(_ move: Move) {
        self.move(to: self.currentPosition.shifted(by: move.vector))
    }
}
