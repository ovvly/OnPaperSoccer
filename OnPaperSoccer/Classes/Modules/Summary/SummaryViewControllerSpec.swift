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
        //FIXME: Fix this snapshots when rewrtiting SummaryViewController
        pending("SummaryViewController") {

            describe("snapshot") {
                context("when provided player 1") {
                    var sut: SummaryViewController!

                    beforeEach {
                        sut = SummaryViewController(player: .player1)
                        _ = sut.view
                    }

                    afterEach {
                        sut = nil
                    }

                    it("should have valid snapshot") {
                        assertSnapshot(matching: sut, as: .image(on: .iPhone12))
                    }
                }

                context("when provided player 2") {
                    var sut: SummaryViewController!

                    beforeEach {
                        sut = SummaryViewController(player: .player2)
                        _ = sut.view
                    }

                    afterEach {
                        sut = nil
                    }

                    it("should have valid snapshot") {
                        assertSnapshot(matching: sut, as: .image(on: .iPhone12))
                    }
                }
            }
        }
    }
}
