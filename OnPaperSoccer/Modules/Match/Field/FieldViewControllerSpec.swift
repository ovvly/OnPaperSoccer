import Foundation
import Quick
import Nimble
import Nimble_Snapshots

@testable import OnPaperSoccer

class FieldViewControllerSpec: QuickSpec {
    override func spec() {
        describe("FieldViewController") {
            var sut: FieldViewController!

            beforeEach {
                sut = FieldViewController()
            }

            describe("draw new field") {
                beforeEach {
                    sut.drawNewField()
                }

                it("should have valid snapshot") {
                    expect(sut.view).to(haveValidSnapshot())
                }
            }

            describe("draw line") {
                beforeEach {
                    sut.draw(line: Line.fixture)
                }

                it("should have valid snapshot") {
                    // expect fb snapshot
                }
            }
        }
    }
}

extension Line {
    static var fixture: Line {
        let fromPoint = Point(x: 10, y: 10)
        let toPoint = Point(x: 20, y: 20)
        return Line(from: fromPoint, to: toPoint)
    }
}
