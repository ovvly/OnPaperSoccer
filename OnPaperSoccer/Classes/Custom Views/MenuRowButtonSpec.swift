import Foundation
import Quick
import Nimble
import SnapshotTesting

@testable import OnPaperSoccer

class MenuRowButtonSpec: QuickSpec {
    override func spec() {
        describe("MenuRowButton") { 
            var sut: MenuRowButton!

            beforeEach {
                sut = MenuRowButton()
                sut.frame = CGRect(x: 0, y: 0, width: 500, height: 54)
            }

            context("when having color set and text set") {
                beforeEach {
                    sut.text = "fixture"
                    sut.color = UIColor.yellow
                }

                it("should have valid snapshot") {
                    assertSnapshot(matching: sut, as: .image)
                }
            }
        }
    }
}
