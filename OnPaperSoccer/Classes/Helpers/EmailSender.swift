import Foundation
import UIKit
import MessageUI

protocol EmailSender {
    func sendMail(to emailAddress: String, presentedFrom viewController: UIViewController)
}

final class DefaultEmailSender: NSObject, EmailSender {
    private let mailComposerBuilder: () -> MailComposer
    private var presentingViewController: UIViewController?
    
    init(mailComposerBuilder: @escaping () -> MailComposer) {
        self.mailComposerBuilder = mailComposerBuilder
        super.init()
    }
    
    func sendMail(to emailAddress: String, presentedFrom viewController: UIViewController) {
        let mailComposer = mailComposerBuilder()
        mailComposer.mailComposeDelegate = self
        presentingViewController = viewController
        
        if mailComposer.canSendMail {
            mailComposer.set(recipients: [emailAddress])
            viewController.present(mailComposer.viewController, animated: true)
        } else {
            let alertViewController = UIAlertController(title: "Error", message: "Sending email is not configured or not possible from this device", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "OK", style: .default)
            alertViewController.addAction(confirmAction)
            
            viewController.present(alertViewController, animated: true)
        }
    }
}

extension DefaultEmailSender: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        presentingViewController?.dismiss(animated: true)
    }
}

typealias MailComposerDelegate = MFMailComposeViewControllerDelegate

protocol MailComposer: class, WithViewController {
    var canSendMail: Bool { get }
    var mailComposeDelegate: MFMailComposeViewControllerDelegate? { get set }
    func set(recipients: [String])
}

extension MFMailComposeViewController: MailComposer {
    var canSendMail: Bool {
        return MFMailComposeViewController.canSendMail()
    }
    
    func set(recipients: [String]) {
        setToRecipients(recipients)
    }
}
