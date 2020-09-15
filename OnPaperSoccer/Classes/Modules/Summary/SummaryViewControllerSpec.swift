//
// Created by Jakub Sowa on 04/09/2020.
// Copyright (c) 2020 com.owlyapps.onPaperSoccer. All rights reserved.
//

import Foundation
import Quick
import Nimble
import SnapshotTesting

@testable import OnPaperSoccer

class SummaryViewControllerSpec: QuickSpec {
    override func spec() {
        describe("SummaryViewController") {
            var sut: SummaryViewController!

            describe("snapshot") {
                context("when provided player 1") {
                    beforeEach {
                        sut = SummaryViewController(player: .player1)
                        _ = sut.view
                    }

                    it("should have valid snapshot") {
                        assertSnapshot(matching: sut, as: .image(on: .iPhone8))
                    }
                }

                context("when provided player 2") {
                    beforeEach {
                        sut = SummaryViewController(player: .player2)
                        _ = sut.view
                    }

                    it("should have valid snapshot") {
                        assertSnapshot(matching: sut, as: .image(on: .iPhone8))
                    }
                }
            }
        }
    }
}
