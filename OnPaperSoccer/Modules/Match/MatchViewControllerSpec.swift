import Foundation
import Quick
import Nimble
import RxSwift

@testable import OnPaperSoccer

class MatchViewControllerSpec: QuickSpec {
    override func spec() {
        describe("MatchViewController") {

            var fieldDrawerSpy: FieldDrawerSpy!
            var movesControllerSpy: MovesControllerSpy!
            var movesValidatorSpy: MovesValidatorSpy!
            var sut: MatchViewController!

            beforeEach {
                fieldDrawerSpy = FieldDrawerSpy()
                movesControllerSpy = MovesControllerSpy()
                movesValidatorSpy = MovesValidatorSpy()
                sut = MatchViewController(fieldDrawer: fieldDrawerSpy, movesController: movesControllerSpy, movesValidator: movesValidatorSpy)
                _ = sut.view
            }

            it("should add field drawer view as subview") {
                expect(sut.childViewControllers).to(contain(fieldDrawerSpy.viewController))
            }

            it("should draw initial field") {
                expect(fieldDrawerSpy.didDrawNewField) == true
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

            describe("moves") {
                context("when moves controller emits moves") {
                    beforeEach {
                        sut.currentPosition = Point(x: 0, y: 0)
                        movesValidatorSpy.isMoveValid = true
                        
                        movesControllerSpy.movesSubject.onNext(Vector(dx: 10, dy: 10))
                    }

                    it("should apply moves to current position") {
                        expect(sut.currentPosition) == Point(x: 10, y: 10)
                    }
                }
            }

            describe("start") {
                it("should have current position set to (4, 5)") {
                    expect(sut.currentPosition) == Point(x: 4, y: 5)
                }
            }

            describe("move validation") {

                context("when move is valid") {
                    beforeEach {
                        movesValidatorSpy.isMoveValid = true
                        sut.currentPosition = Point(x: 0, y: 0)

                        movesControllerSpy.movesSubject.onNext(Vector(dx: 42, dy: 42))
                    }

                    it("should change current position") {
                        expect(sut.currentPosition) == Point(x: 42, y: 42)
                    }
                }


                context("when move is invalid") {
                    beforeEach {
                        movesValidatorSpy.isMoveValid = false
                        sut.currentPosition = Point(x: 0, y: 0)

                        movesControllerSpy.movesSubject.onNext(Vector(dx: 42, dy: 42))
                    }

                    it("should not change current position") {
                        expect(sut.currentPosition) == Point(x: 0, y: 0)
                    }
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

private class MovesControllerSpy: MovesController {
    var viewController = UIViewController()
    var moves: Observable<Vector> { return movesSubject.asObservable() }
    let movesSubject = PublishSubject<Vector>()
}

private class MovesValidatorSpy: MovesValidator {
    var isMoveValid: Bool = false
    func isValidMove(from point: Point, by vector: Vector) -> Bool {
        return isMoveValid
    }
}
