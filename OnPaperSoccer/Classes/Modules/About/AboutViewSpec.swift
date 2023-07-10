//
// Created by Jakub Sowa on 10/07/2023.
// Copyright (c) 2023 com.owlyapps.onPaperSoccer. All rights reserved.
//

import Foundation
import Quick
import Nimble
import SnapshotTesting
import SwiftUI

@testable import OnPaperSoccer

class AboutViewSpec: QuickSpec {
    override func spec() {
        describe("AboutView") {
            var sut: AboutView!
            var viewController: UIViewController!

            beforeEach {
                sut = AboutView(interactor: AboutInteractorMock())
                viewController = UIHostingController(rootView: sut)
            }

            describe("snapshot") {
                it("should have valid snapshot") {
                    assertSnapshot(matching: viewController, as: .image(on: .iPhone12))
                }
            }
        }
    }
}

private final class AboutInteractorMock: AboutInteracting {
    func sourceCodeTapped() {}
    func contactUsTapped() {}
    func ideasTapped() {}
}
