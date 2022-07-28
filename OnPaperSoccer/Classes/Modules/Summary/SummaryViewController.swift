import UIKit

protocol SummaryViewControllerDelegate: AnyObject {
    func viewControllerDidRestart(_ viewController: SummaryViewController)
    func viewControllerDidClose(_ viewController: SummaryViewController)
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

        setupView()
        addActionsToButtons()
    }

    private func setupView() {
        customView.infoLabel.text = "\(player.name) wins the match"
        customView.infoLabel.textColor = player.color
    }

    private func addActionsToButtons() {
        customView.okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        customView.restartButton.addTarget(self, action: #selector(restartButtonTapped), for: .touchUpInside)
    }

    @objc
    private func okButtonTapped() {
        delegate?.viewControllerDidClose(self)
    }

    @objc
    private func restartButtonTapped() {
        delegate?.viewControllerDidRestart(self)
    }
}
