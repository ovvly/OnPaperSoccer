import Foundation
import Quick
import Nimble
import SnapshotTesting

@testable import OnPaperSoccer

class AboutViewControllerSpec: QuickSpec {
    override func spec() {
        describe("AboutViewController") {
            var sut: AboutViewController!
            
            var externalLinkHandlerSpy: ExternalLinkHandlerSpy!
            var emailSenderSpy: EmailSenderSpy!
            
            beforeEach {
                externalLinkHandlerSpy = ExternalLinkHandlerSpy()
                emailSenderSpy = EmailSenderSpy()
                
                sut = AboutViewController(externalLinkHandler: externalLinkHandlerSpy, emailSender: emailSenderSpy)
                
                _ = sut.view
            }
            
            describe("snapshot") {
                it("should have valid snapshot") {
                    assertSnapshot(matching: sut, as: .image(on: .iPhone8))
                }
            }
            
            context("when 'source code' button is tapped") {
                beforeEach {
                    sut.customView.sourceCodeButton.simulateTap()
                }
                it("should open link to github page") {
                    expect(externalLinkHandlerSpy.capturedURL) == URL(string: "https://github.com/ovvly/OnPaperSoccer")!
                }
            }
            
            context("when 'contact us' button is tapped") {
                beforeEach {
                    sut.customView.contactUsButton.simulateTap()
                }
                
                it("should open mail with predefined mail") {
                    expect(emailSenderSpy.capturedEmailAddress) == "help@onpapersoccer.com"
                }
                
                it("should present on correct view controller") {
                    expect(emailSenderSpy.capturedViewController) == sut
                }
            }
            
            context("when 'ideas' button is tapped") {
                beforeEach {
                    sut.customView.ideasButton.simulateTap()
                }
                
                it("should open mail with predefined mail") {
                    expect(emailSenderSpy.capturedEmailAddress) == "ideas@onpapersoccer.com"
                }
                
                it("should present on correct view controller") {
                    expect(emailSenderSpy.capturedViewController) == sut
                }
            }
        }
    }
}

private final class ExternalLinkHandlerSpy: ExternalLinkHandler {
    var capturedURL: URL?
    
    func open(url: URL) {
        capturedURL = url
    }
}

private final class EmailSenderSpy: EmailSender {
    var capturedEmailAddress: String?
    var capturedViewController: UIViewController?
    
    func sendMail(to emailAddress: String, presentedFrom viewController: UIViewController) {
        capturedEmailAddress = emailAddress
        capturedViewController = viewController
    }
}
