//
// Created by Jakub Sowa on 10/07/2023.
// Copyright (c) 2023 com.owlyapps.onPaperSoccer. All rights reserved.
//

import Foundation
import Foundation
import Quick
import Nimble

@testable import OnPaperSoccer

class AboutInteractorSpec: QuickSpec {
    override func spec() {
        describe("AboutInteractor") { 
            var sut: AboutInteractor!
            var emailSender: EmailSenderSpy!
            var externalLinkHandler: ExternalLinkHandlerSpy!
            
            beforeEach {
                emailSender = EmailSenderSpy()
                externalLinkHandler = ExternalLinkHandlerSpy()

                sut = AboutInteractor(externalLinkHandler: externalLinkHandler, emailSender: emailSender)
            }

            describe("source code tapped") {
                beforeEach {
                    sut.sourceCodeTapped()
                }

                it("should open github url") {
                    expect(externalLinkHandler.capturedUrl) == URL(string: "https://github.com/ovvly/OnPaperSoccer")
                }
            }

            describe("contact us tapped") {
                beforeEach {
                    sut.contactUsTapped()
                }

                it("should send email to correct address") {
                    expect(emailSender.capturedEmail) == "onpapersoccer+help@gmail.com"
                }
            }

            describe("ideas tapped") {
                beforeEach {
                    sut.ideasTapped()
                }

                it("should send email to correct address") {
                    expect(emailSender.capturedEmail) == "onpapersoccer+ideas@gmail.com"
                }
            }
        }
    }
}

private class EmailSenderSpy: EmailSender {
    var capturedEmail: String?

    func sendMail(to emailAddress: String) {
        capturedEmail = emailAddress
    }
}

private class ExternalLinkHandlerSpy: ExternalLinkHandler {
    var capturedUrl: URL?

    func open(url: URL) {
        capturedUrl = url
    }
}
