import UIKit
import RxSwift

protocol MovesController: WithViewController {
    var moves: Observable<Vector> { get }
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

    var moves: Observable<Vector> {
       return movesSubject.asObservable()
    }

    private let movesSubject = PublishSubject<Vector>()

    // MARK: Init

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Actions
    
    @IBAction
    private func upButtonTapped(_ sender: UIButton) {
        movesSubject.onNext(Vector.up)
    }

    @IBAction
    func downButtonTapped(_ sender: UIButton) {
        movesSubject.onNext(Vector.down)
    }

    @IBAction
    func leftButtonTapped(_ sender: UIButton) {
        movesSubject.onNext(Vector.left)
    }

    @IBAction
    func rightButtonTapped(_ sender: UIButton) {
        movesSubject.onNext(Vector.right)
    }

    @IBAction
    private func upLeftButtonTapped(_ sender: UIButton) {
        movesSubject.onNext(Vector.upLeft)
    }

    @IBAction
    func upRightButtonTapped(_ sender: UIButton) {
        movesSubject.onNext(Vector.upRight)
    }

    @IBAction
    func downLeftButtonTapped(_ sender: UIButton) {
        movesSubject.onNext(Vector.downLeft)
    }

    @IBAction
    func downRightButtonTapped(_ sender: UIButton) {
        movesSubject.onNext(Vector.downRight)
    }
}
