import UIKit

final class AboutViewController: UIViewController, WithCustomView {
    typealias CustomView = AboutView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func loadView() {
        view = AboutView()
    }
    
    private func setupView() {
        customView.infoLabel.text = "Thank you for playing On Paper Soccer. \r\nSource code for this game is public and it can be accessed at: \r\nhttps://github.com/ovvly/OnPaperSoccer"
        customView.sourceCodeButton.text = "Source code"
        customView.contactUsButton.text = "Contact Us"
        customView.ideasButton.text = "Send Us your ideas"
        
        customView.sourceCodeButton.addTarget(self, action: #selector(sourceCodeButtonTapped), for: .primaryActionTriggered)
        customView.contactUsButton.addTarget(self, action: #selector(contactUsButtonTapped), for: .primaryActionTriggered)
        customView.ideasButton.addTarget(self, action: #selector(ideasButtonTapped), for: .primaryActionTriggered)
    }
    
    @objc private func sourceCodeButtonTapped() {
        print("source code button tapped")
    }
    
    @objc private func contactUsButtonTapped() {
        print("contact us button tapped")
    }
    
    @objc private func ideasButtonTapped() {
        print("ideas button tapped")
    }
}
