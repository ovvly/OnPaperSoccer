import Foundation
import Quick
import Nimble
import Nimble_Snapshots

@testable import OnPaperSoccer

class FieldViewControllerSpec: QuickSpec {
    override func spec() {
        describe("FieldViewController") {
            var settings: GameSettings!

            var sut: FieldViewController!

            beforeEach {
                settings = GameSettings(fieldWidth: 9, fieldHeight: 11)

                sut = FieldViewController(settings: settings)
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
                    sut.draw(line: Line.fixture, color: .yellow)
                }

                it("should have valid snapshot") {
                    expect(sut.view).to(haveValidSnapshot())
                }
            }

            describe("draw 2 line with different colors") {
                beforeEach {
                    sut.drawNewField()
                    sut.draw(line: Line.fixture, color: .brown)
                    sut.draw(line: Line.fixture2, color: .purple)
                }

                it("should have valid snapshot") {
                    expect(sut.view).to(haveValidSnapshot())
                }
            }
            
            describe("reset") {
                beforeEach {
                    sut.drawNewField()
                    sut.draw(line: Line.fixture, color: .brown)
                    sut.draw(line: Line.fixture2, color: .purple)

                    sut.reset()
                }

                it("should reset") {
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

    static var fixture2: Line {
        let fromPoint = Point(x: 2, y: 2)
        let toPoint = Point(x: 2, y: 3)
        return Line(from: fromPoint, to: toPoint)
    }
}
