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
            
            beforeEach {
                externalLinkHandlerSpy = ExternalLinkHandlerSpy()
                
                sut = AboutViewController(externalLinkHandler: externalLinkHandlerSpy)
                
                _ = sut.view
            }
            
            describe("snapshot") {
                it("should have valid snapshot") {
                    assertSnapshot(matching: sut, as: .image(on: .iPhone8))
                }
            }
            
            context("when source code button is tapped") {
                beforeEach {
                    sut.customView.sourceCodeButton.simulateTap()
                }
                it("should open link to github page") {
                    expect(externalLinkHandlerSpy.capturedURL) == URL(string: "https://github.com/ovvly/OnPaperSoccer")!
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
