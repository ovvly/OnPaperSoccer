import UIKit

class MatchViewController: UIViewController {

    private let viewModel: MatchViewModel = DefaultMatchViewModel()
    private lazy var drawer = DefaultMatchDrawer(rows: 11, columns: 9)

    // MARK: Init

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: ViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(drawer.view)
        drawer.view.frame = view.bounds

        drawer.drawMatch()
    }
}
