import UIKit

final class AboutViewController: UIViewController, WithCustomView {
    typealias CustomView = AboutView
 
    private let externalLinkHandler: ExternalLinkHandler
    
    init(externalLinkHandler: ExternalLinkHandler) {
        self.externalLinkHandler = externalLinkHandler
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        customView.sourceCodeButton.addTarget(self, action: #selector(sourceCodeButtonTapped), for: .touchUpInside)
        customView.contactUsButton.addTarget(self, action: #selector(contactUsButtonTapped), for: .touchUpInside)
        customView.ideasButton.addTarget(self, action: #selector(ideasButtonTapped), for: .touchUpInside)
    }
    
    @objc private func sourceCodeButtonTapped() {
        let url = URL(string: "https://github.com/ovvly/OnPaperSoccer")!
        externalLinkHandler.open(url: url)
    }
    
    @objc private func contactUsButtonTapped() {
        print("contact us button tapped")
    }
    
    @objc private func ideasButtonTapped() {
        print("ideas button tapped")
    }
}
