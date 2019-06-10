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
                settings = GameSettings.default

                sut = FieldViewController(settings: settings)
            }

            describe("draw new field and mark current position") {
                beforeEach {
                    sut.drawNewField()
                    sut.mark(currentPoint: Point(x: 4, y: 5), with: Player.player1.color)
                }

                it("should have valid snapshot") {
                    expect(sut.view).to(haveValidSnapshot())
                }
            }

            describe("draw line") {
                beforeEach {
                    sut.drawNewField()
                    sut.draw(line: Line.fixture, color: Player.player1.color)
                    sut.mark(currentPoint: Line.fixture.to, with: Player.player2.color)
                }

                it("should have valid snapshot") {
                    expect(sut.view).to(haveValidSnapshot())
                }
            }

            describe("draw 2 line with different colors") {
                beforeEach {
                    sut.drawNewField()
                    sut.draw(line: Line.fixture, color: Player.player1.color)
                    sut.draw(line: Line.fixture2, color: Player.player2.color)
                    sut.mark(currentPoint: Line.fixture2.to, with: Player.player1.color)
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
        let fromPoint = Point(x: 4, y: 5)
        let toPoint = Point(x: 5, y: 6)
        return Line(from: fromPoint, to: toPoint)
    }

    static var fixture2: Line {
        let fromPoint = Point(x: 5, y: 6)
        let toPoint = Point(x: 4, y: 7)
        return Line(from: fromPoint, to: toPoint)
    }
}
