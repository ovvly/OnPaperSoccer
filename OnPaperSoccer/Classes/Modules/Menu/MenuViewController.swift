import UIKit

protocol MenuViewControllerDelegate: class {
    func didSelectedPlay()
    func didSelectedAbout()
}

final class MenuViewController: UIViewController {

    weak var delegate: MenuViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didSelectedPlayRow(_ sender: MenuRowButton) {
        delegate?.didSelectedPlay()
    }

    @IBAction func didSelectedAboutRow(_ sender: MenuRowButton) {
        delegate?.didSelectedAbout()
    }
}
