import UIKit

protocol MovesControllerDelegate: class {
    func didMove(_ move: Move)
}

protocol MovesController: class, WithViewController, Resetable {
    var delegate: MovesControllerDelegate? { get set }
    func updateMovesPossibility(_ moves: Set<Move>)
}

class MovesViewController: UIViewController, MovesController {
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var upLeftButton: UIButton!
    @IBOutlet weak var upRightButton: UIButton!
    @IBOutlet weak var downLeftButton: UIButton!
    @IBOutlet weak var downRightButton: UIButton!

    weak var delegate: MovesControllerDelegate?

    // MARK: Init

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Actions

    func updateMovesPossibility(_ moves: Set<Move>) {
        Move.allCases.forEach { move in
            let button = directionButton(for: move)
            button.isEnabled = moves.contains(move)
        }
    }

    func reset() {
        updateMovesPossibility(Set(Move.allCases))
    }

    @IBAction
    private func upButtonTapped(_ sender: UIButton) {
        delegate?.didMove(.up)
    }

    @IBAction
    func downButtonTapped(_ sender: UIButton) {
        delegate?.didMove(.down)
    }

    @IBAction
    func leftButtonTapped(_ sender: UIButton) {
        delegate?.didMove(.left)
    }

    @IBAction
    func rightButtonTapped(_ sender: UIButton) {
        delegate?.didMove(.right)
    }

    @IBAction
    private func upLeftButtonTapped(_ sender: UIButton) {
        delegate?.didMove(.upLeft)
    }

    @IBAction
    func upRightButtonTapped(_ sender: UIButton) {
        delegate?.didMove(.upRight)
    }

    @IBAction
    func downLeftButtonTapped(_ sender: UIButton) {
        delegate?.didMove(.downLeft)
    }

    @IBAction
    func downRightButtonTapped(_ sender: UIButton) {
        delegate?.didMove(.downRight)
    }

    // MARK: Helpers

    private func directionButton(for move: Move) -> UIButton {
        switch move {
        case .up: return upButton
        case .down: return downButton
        case .left: return leftButton
        case .right: return rightButton
        case .upLeft: return upLeftButton
        case .upRight: return upRightButton
        case .downLeft: return downLeftButton
        case .downRight: return downRightButton
        }
    }
}
