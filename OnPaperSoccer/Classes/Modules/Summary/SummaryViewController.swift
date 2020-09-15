import UIKit

protocol SummaryViewControllerDelegate: class {
    func viewControllerDidFinish(_ viewController: SummaryViewController)
}

final class SummaryViewController: UIViewController, WithCustomView {
    typealias CustomView = SummaryView

    weak var delegate: SummaryViewControllerDelegate?
    private let player: Player
    // MARK: Init

    init(player: Player) {
        self.player = player
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle

    override func loadView() {
        view = SummaryView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        customView.infoLabel.text = "\(player.name) wins the match"
        customView.infoLabel.textColor = player.color
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        delegate?.viewControllerDidFinish(self)
    }
}
