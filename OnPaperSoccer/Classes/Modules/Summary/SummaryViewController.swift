import UIKit

protocol SummaryViewControllerDelegate: class {
    func viewControllerDidFinish(_ viewController: SummaryViewController)
}

final class SummaryViewController: UIViewController {

    weak var delegate: SummaryViewControllerDelegate?
    
    // MARK: Init

    init(player: Player) {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        delegate?.viewControllerDidFinish(self)
    }
}
