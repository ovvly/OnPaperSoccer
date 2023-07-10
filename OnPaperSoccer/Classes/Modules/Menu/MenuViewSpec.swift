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

class MenuViewSpec: QuickSpec {
    override func spec() {
        describe("MenuView") {
            var sut: MenuView!
            var viewController: UIViewController!

            beforeEach {
                sut = MenuView(interactor: MenuInteractorMock())
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

private final class MenuInteractorMock: MenuInteracting {
    func singlePlayerTapped() {}
    func hotSeatsSelected() {}
    func aboutSelected() {}
}
