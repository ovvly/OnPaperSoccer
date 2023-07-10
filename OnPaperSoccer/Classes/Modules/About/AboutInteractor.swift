//
// Created by Jakub Sowa on 10/07/2023.
// Copyright (c) 2023 com.owlyapps.onPaperSoccer. All rights reserved.
//

import Foundation

protocol AboutInteracting {
    func sourceCodeTapped()
    func contactUsTapped()
    func ideasTapped()
}

final class AboutInteractor: AboutInteracting {
    private let externalLinkHandler: ExternalLinkHandler
    private let emailSender: EmailSender

    init(externalLinkHandler: ExternalLinkHandler, emailSender: EmailSender) {
        self.externalLinkHandler = externalLinkHandler
        self.emailSender = emailSender
    }

    func sourceCodeTapped() {
        let url = URL(string: "https://github.com/ovvly/OnPaperSoccer")!
        externalLinkHandler.open(url: url)
    }

    func contactUsTapped() {
        emailSender.sendMail(to: "onpapersoccer+help@gmail.com")
    }

    func ideasTapped() {
        emailSender.sendMail(to: "onpapersoccer+ideas@gmail.com")
    }
}
