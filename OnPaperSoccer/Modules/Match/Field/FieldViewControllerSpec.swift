import Foundation
import Quick
import Nimble

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

                it("should render 9 columns and 11 rows of nodes") {
                    //expect(sut.) ==
                }
            }

            describe("draw line") {
                beforeEach {
                    sut.draw(line: Line.fixture)
                }

                it("should draw line") {
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
