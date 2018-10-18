import Foundation
import Quick
import Nimble

@testable import OnPaperSoccer

class MatchViewControllerSpec: QuickSpec {
    override func spec() {
        describe("MatchViewController") {
            var matchViewSpy: MatchViewSpy!

            var sut: MatchViewController!

            beforeEach {
                matchViewSpy = MatchViewSpy()

                sut = MatchViewController(matchView: matchViewSpy)
                _ = sut.view
            }

            it("should add match view as subview") {
                expect(matchViewSpy.superview).toNot(beNil())
            }

            sharedExamples("move") { context in
                var newPosition: Point!

                beforeEach {
                    let currentPosition = context()["from"] as! Point
                    newPosition = context()["to"]  as? Point
                    let button = context()["tapping"] as! UIButton
                    sut.currentPosition = currentPosition

                    button.simulateTap()
                }

                it("should move to new position") {
                    expect(sut.currentPosition) == newPosition
                }
            }

            describe("up button") {
                itBehavesLike("move") { ["from": Point(x: 0, y: 0),
                                         "to": Point(x: 0, y: 1),
                                         "tapping": sut.upButton] }

                itBehavesLike("move") { ["from": Point(x: 10, y: 10),
                                         "to": Point(x: 10, y: 11),
                                         "tapping": sut.upButton] }
            }

            describe("down button") {
                itBehavesLike("move") { ["from": Point(x: 0, y: 0),
                                         "to": Point(x: 0, y: -1),
                                          "tapping": sut.downButton] }

                itBehavesLike("move") { ["from": Point(x: 10, y: 10),
                                         "to": Point(x: 10, y: 9),
                                         "tapping": sut.downButton] }
            }

            describe("left button") {
                itBehavesLike("move") { ["from": Point(x: 0, y: 0),
                                         "to": Point(x: -1, y: 0),
                                         "tapping": sut.leftButton] }

                itBehavesLike("move") { ["from": Point(x: 10, y: 10),
                                         "to": Point(x: 9, y: 10),
                                         "tapping": sut.leftButton] }
            }

            describe("right button") {
                itBehavesLike("move") { ["from": Point(x: 0, y: 0),
                                         "to": Point(x: 1, y: 0),
                                         "tapping": sut.rightButton] }

                itBehavesLike("move") { ["from": Point(x: 10, y: 10),
                                         "to": Point(x: 11, y: 10),
                                         "tapping": sut.rightButton] }
            }

            describe("current position") {
                context("when current position changes") {
                    beforeEach {
                        sut.currentPosition = Point(x: 10, y: 10)

                        sut.currentPosition = Point(x: 20, y: 20)
                    }

                    it("should draw line from old to new position") {
                        expect(matchViewSpy.capturedLine?.from) == Point(x: 10, y: 10)
                        expect(matchViewSpy.capturedLine?.to) == Point(x: 20, y: 20)
                    }
                }
            }
        }
    }
}

private class MatchViewSpy: MatchView {
    var capturedLine: Line? = nil

    override init() {
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(line: Line) {
        capturedLine = line
    }
}

extension Point: Equatable {
    public static func ==(lhs: Point, rhs: Point) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}
