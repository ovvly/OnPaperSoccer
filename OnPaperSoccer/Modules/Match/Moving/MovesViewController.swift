import UIKit
import RxSwift

protocol MovesController: WithViewController {
    var moves: Observable<Move> { get }
    func updateMovesPossibility(_ moves: Set<Move>)
}

class MovesViewController: UIViewController, MovesController {
    var viewController: UIViewController { return self }

    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var upLeftButton: UIButton!
    @IBOutlet weak var upRightButton: UIButton!
    @IBOutlet weak var downLeftButton: UIButton!
    @IBOutlet weak var downRightButton: UIButton!

    var moves: Observable<Move> {
       return movesSubject.asObservable()
    }

    private let movesSubject = PublishSubject<Move>()

    // MARK: Init

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateMovesPossibility(_ moves: Set<Move>) {
        Move.allCases.forEach { move in
            let button = directionButton(for: move)
            button.isEnabled = moves.contains(move)
        }
    }

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

    // MARK: Actions
    
    @IBAction
    private func upButtonTapped(_ sender: UIButton) {
        movesSubject.onNext(Move.up)
    }

    @IBAction
    func downButtonTapped(_ sender: UIButton) {
        movesSubject.onNext(Move.down)
    }

    @IBAction
    func leftButtonTapped(_ sender: UIButton) {
        movesSubject.onNext(Move.left)
    }

    @IBAction
    func rightButtonTapped(_ sender: UIButton) {
        movesSubject.onNext(Move.right)
    }

    @IBAction
    private func upLeftButtonTapped(_ sender: UIButton) {
        movesSubject.onNext(Move.upLeft)
    }

    @IBAction
    func upRightButtonTapped(_ sender: UIButton) {
        movesSubject.onNext(Move.upRight)
    }

    @IBAction
    func downLeftButtonTapped(_ sender: UIButton) {
        movesSubject.onNext(Move.downLeft)
    }

    @IBAction
    func downRightButtonTapped(_ sender: UIButton) {
        movesSubject.onNext(Move.downRight)
    }
}
