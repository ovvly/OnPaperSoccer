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
                    sut.drawNewField()
                    sut.draw(line: Line.fixture)
                }

                it("should have valid snapshot") {
                    expect(sut.view).to(haveValidSnapshot())
                }
            }
        }
    }
}

extension Line {
    static var fixture: Line {
        let fromPoint = Point(x: 1, y: 1)
        let toPoint = Point(x: 2, y: 2)
        return Line(from: fromPoint, to: toPoint)
    }
}
