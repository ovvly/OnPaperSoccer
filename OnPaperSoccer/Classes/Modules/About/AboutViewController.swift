import UIKit

final class AboutViewController: UIViewController, WithCustomView {
    typealias CustomView = AboutView
 
    private let externalLinkHandler: ExternalLinkHandler
    private let emailSender: EmailSender
    
    init(externalLinkHandler: ExternalLinkHandler, emailSender: EmailSender) {
        self.externalLinkHandler = externalLinkHandler
        self.emailSender = emailSender
        
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
        emailSender.sendMail(to: "onpapersoccer+help@gmail.com", presentedFrom: self)
    }
    
    @objc private func ideasButtonTapped() {
        emailSender.sendMail(to: "onpapersoccer+ideas@gmail.com", presentedFrom: self)
    }
}
