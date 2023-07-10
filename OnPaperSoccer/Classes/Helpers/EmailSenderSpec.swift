import Foundation
import Quick
import Nimble
import MessageUI

@testable import OnPaperSoccer

class EmailSenderSpec: QuickSpec {
    override func spec() {
        describe("EmailSender") {
            var sut: DefaultEmailSender!
            var mailComposerSpy: MailComposerSpy!
            
            beforeEach {
                mailComposerSpy = MailComposerSpy()
                
                sut = DefaultEmailSender(mailComposerBuilder: {
                    mailComposerSpy
                })
            }
            
            describe("send mail to email address") {
                var viewController: ViewControllerSpy!
                
                beforeEach {
                    viewController = ViewControllerSpy()
                    sut.presentingViewController = viewController
                }
                
                context("when email can be send") {
                    beforeEach {
                        mailComposerSpy.canSendMail = true
                        
                        sut.sendMail(to: "fake@email.com")
                    }
                    
                    it("should present composers view controller from provided view controller") {
                        expect(viewController.capturedViewControllerToPresent) == mailComposerSpy.viewController
                    }
                    
                    it("should set recipients") {
                        expect(mailComposerSpy.capturedRecipients) == ["fake@email.com"]
                    }
                    
                    context("when email did finish") {
                        beforeEach {
                            mailComposerSpy.mailComposeDelegate?.mailComposeController?(MFMailComposeViewController(), didFinishWith: .sent, error: nil)
                        }
                        
                        it("should dismiss mail composer view controller") {
                            expect(viewController.dissmissCalled) == 1
                        }
                    }
                }
                
                context("when mail cannot be send") {
                    beforeEach {
                        mailComposerSpy.canSendMail = false
                        
                        sut.sendMail(to: "fake@email.com")
                    }
                    
                    it("should present alert controller") {
                        expect(viewController.capturedViewControllerToPresent).to(beAKindOf(UIAlertController.self))
                    }
                    
                    it("should have correct alert style") {
                        expect((viewController.capturedViewControllerToPresent as? UIAlertController)?.preferredStyle) == UIAlertController.Style.alert
                    }
                    
                    it("should have correct alert title") {
                        expect((viewController.capturedViewControllerToPresent as? UIAlertController)?.title) == "Error"
                    }
                    
                    it("should should have correct message") {
                        expect((viewController.capturedViewControllerToPresent as? UIAlertController)?.message) == "Sending email is not configured or not possible from this device"
                    }
                    
                    it("should have 'OK' action") {
                        expect((viewController.capturedViewControllerToPresent as? UIAlertController)?.actions).to(haveCount(1))
                        expect((viewController.capturedViewControllerToPresent as? UIAlertController)?.actions.first?.title) == "OK"
                        expect((viewController.capturedViewControllerToPresent as? UIAlertController)?.actions.first?.style) == UIAlertAction.Style.default
                    }
                }
            }
        }
    }
}

private final class MailComposerSpy: MailComposer {
    var mailComposeDelegate: MailComposerDelegate?
    
    let viewController = UIViewController()
    var capturedRecipients = [String]()
    var canSendMail = true
    
    func set(recipients: [String]) {
        capturedRecipients = recipients
    }
}

private final class ViewControllerSpy: UIViewController {
    var capturedViewControllerToPresent: UIViewController?
    var dissmissCalled = 0
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        capturedViewControllerToPresent = viewControllerToPresent
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        dissmissCalled += 1
    }
}
