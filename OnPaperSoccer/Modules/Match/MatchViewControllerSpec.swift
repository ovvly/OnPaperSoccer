import Foundation
import Quick
import Nimble

@testable import OnPaperSoccer

class MatchViewControllerSpec: QuickSpec {
    override func spec() {
        describe("MatchViewController") {
            var fieldControllerSpy: FieldControllerSpy!

            var sut: MatchViewController!

            beforeEach {
                fieldControllerSpy = FieldControllerSpy()

                sut = MatchViewController(fieldController: fieldControllerSpy)
                _ = sut.view
            }

            it("should add match view as subview") {
                expect(fieldControllerSpy.view.superview).toNot(beNil())
            }

            it("should draw initial field") {
                expect(fieldControllerSpy.didDrawNewField) == true
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
                        expect(fieldControllerSpy.capturedLine?.from) == Point(x: 10, y: 10)
                        expect(fieldControllerSpy.capturedLine?.to) == Point(x: 20, y: 20)
                    }
                }
            }
        }
    }
}

private class FieldControllerSpy: UIViewController & LineDrawer {
    var capturedLine: Line? = nil
    var didDrawNewField = false

    func drawNewField() {
        didDrawNewField = true
    }

    func draw(line: Line) {
        capturedLine = line
    }
}
