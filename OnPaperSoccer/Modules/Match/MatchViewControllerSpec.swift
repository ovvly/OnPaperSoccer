import Foundation
import Quick
import Nimble

@testable import OnPaperSoccer

class MatchViewControllerSpec: QuickSpec {
    override func spec() {
        describe("MatchViewController") {
            var fieldDrawerSpy: FieldDrawerSpy!

            var sut: MatchViewController!

            beforeEach {
                fieldDrawerSpy = FieldDrawerSpy()

                sut = MatchViewController(fieldDrawer: fieldDrawerSpy)
                _ = sut.view
            }

            it("should add match view as subview") {
                expect(sut.childViewControllers).to(contain(fieldDrawerSpy.viewController))
            }

            it("should draw initial field") {
                expect(fieldDrawerSpy.didDrawNewField) == true
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

                itBehavesLike("move") { ["from": Point(x: 100, y: 100),
                                         "to": Point(x: 100, y: 101),
                                         "tapping": sut.upButton] }
            }

            describe("down button") {
                itBehavesLike("move") { ["from": Point(x: 0, y: 0),
                                         "to": Point(x: 0, y: -1),
                                          "tapping": sut.downButton] }

                itBehavesLike("move") { ["from": Point(x: 100, y: 100),
                                         "to": Point(x: 100, y: 99),
                                         "tapping": sut.downButton] }
            }

            describe("left button") {
                itBehavesLike("move") { ["from": Point(x: 0, y: 0),
                                         "to": Point(x: -1, y: 0),
                                         "tapping": sut.leftButton] }

                itBehavesLike("move") { ["from": Point(x: 100, y: 100),
                                         "to": Point(x: 99, y: 100),
                                         "tapping": sut.leftButton] }
            }

            describe("right button") {
                itBehavesLike("move") { ["from": Point(x: 0, y: 0),
                                         "to": Point(x: 1, y: 0),
                                         "tapping": sut.rightButton] }

                itBehavesLike("move") { ["from": Point(x: 100, y: 100),
                                         "to": Point(x: 101, y: 100),
                                         "tapping": sut.rightButton] }
            }

            describe("up-left button") {
                itBehavesLike("move") { ["from": Point(x: 0, y: 0),
                                         "to": Point(x: -1, y: 1),
                                         "tapping": sut.upLeftButton] }

                itBehavesLike("move") { ["from": Point(x: 100, y: 100),
                                         "to": Point(x: 99, y: 101),
                                         "tapping": sut.upLeftButton] }
            }

            describe("up-right button") {
                itBehavesLike("move") { ["from": Point(x: 0, y: 0),
                                         "to": Point(x: 1, y: 1),
                                         "tapping": sut.upRightButton] }

                itBehavesLike("move") { ["from": Point(x: 100, y: 100),
                                         "to": Point(x: 101, y: 101),
                                         "tapping": sut.upRightButton] }
            }

            describe("down-left button") {
                itBehavesLike("move") { ["from": Point(x: 0, y: 0),
                                         "to": Point(x: -1, y: -1),
                                         "tapping": sut.downLeftButton] }

                itBehavesLike("move") { ["from": Point(x: 100, y: 100),
                                         "to": Point(x: 99, y: 99),
                                         "tapping": sut.downLeftButton] }
            }

            describe("down-right button") {
                itBehavesLike("move") { ["from": Point(x: 0, y: 0),
                                         "to": Point(x: 1, y: -1),
                                         "tapping": sut.downRightButton] }

                itBehavesLike("move") { ["from": Point(x: 100, y: 100),
                                         "to": Point(x: 101, y: 99),
                                         "tapping": sut.downRightButton] }
            }

            describe("current position") {
                context("when current position changes") {
                    beforeEach {
                        sut.currentPosition = Point(x: 10, y: 10)

                        sut.currentPosition = Point(x: 20, y: 20)
                    }

                    it("should draw line from old to new position") {
                        expect(fieldDrawerSpy.capturedLine?.from) == Point(x: 10, y: 10)
                        expect(fieldDrawerSpy.capturedLine?.to) == Point(x: 20, y: 20)
                    }
                }
            }

            describe("start") {
                it("should have current position set to (4, 5)") {
                    expect(sut.currentPosition) == Point(x: 4, y: 5)
                }
            }
        }
    }
}

private class FieldDrawerSpy: FieldDrawer {
    var capturedLine: Line? = nil
    var didDrawNewField = false
    var viewController = UIViewController()

    func drawNewField() {
        didDrawNewField = true
    }

    func draw(line: Line) {
        capturedLine = line
    }
}
