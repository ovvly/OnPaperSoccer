import UIKit

protocol MenuViewControllerDelegate: class {
    func didSelectedHotSeats()
    func didSelectedSinglePlayer()
    func didSelectedAbout()
}

final class MenuViewController: UIViewController {

    weak var delegate: MenuViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didSelectedSinglePlayerRow(_ sender: MenuRowButton) {
        delegate?.didSelectedSinglePlayer()
    }
    
    @IBAction func didSelectedHotSeatsRow(_ sender: MenuRowButton) {
        delegate?.didSelectedHotSeats()
    }
    
    @IBAction func didSelectedAboutRow(_ sender: MenuRowButton) {
        delegate?.didSelectedAbout()
    }
}
