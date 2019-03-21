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
            var turnControllerSpy: TurnControllerSpy!
            var movesValidatorSpy: MovesValidatorSpy!
            var sut: MatchViewController!

            beforeEach {
                fieldDrawerSpy = FieldDrawerSpy()
                movesControllerSpy = MovesControllerSpy()
                turnControllerSpy = TurnControllerSpy()
                movesValidatorSpy = MovesValidatorSpy()
                sut = MatchViewController(fieldDrawer: fieldDrawerSpy,
                    movesController: movesControllerSpy,
                    turnController: turnControllerSpy,
                    movesValidator: movesValidatorSpy,
                    fieldWidth: 42, fieldHeight: 43)
                _ = sut.view
            }
            
            describe("init") {
                it("should add field drawer view as subview") {
                    expect(sut.childViewControllers).to(contain(fieldDrawerSpy.viewController))
                }

                it("should draw initial field") {
                    expect(fieldDrawerSpy.didDrawNewField) == true
                }

                it("should have current position set to middle of field size") {
                    expect(sut.currentPosition) == Point(x: 21, y: 21)
                }
            }

            describe("move to") {
                describe("current position") {
                    beforeEach {
                        sut.move(to: Point(x: 10, y: 10))
                    }
                    it("should be set correctly") {
                        expect(sut.currentPosition) == Point(x: 10, y: 10)
                    }
                    it("should inform turn controller about move") {
                        expect(turnControllerSpy.capturedPoint) == Point(x: 10, y: 10)
                    }
                }
                describe("possible moves") {
                    beforeEach {
                        movesValidatorSpy.possibleMoves = [.up, .down, .left]
                        sut.move(to: Point(x: 10, y: 10))
                    }
                    it("should be updated") {
                        expect(movesControllerSpy.capturedPossibleMoves) == [.up, .down, .left]
                    }
                }

                describe("field drawer") {
                    context("when current position changes twice") {
                        beforeEach {
                            turnControllerSpy.currentPlayer = .player2

                            sut.move(to: Point(x: 10, y: 10))
                            sut.move(to: Point(x: 20, y: 20))
                        }
                        it("should draw line from old to new position") {
                            expect(fieldDrawerSpy.capturedLine?.from) == Point(x: 10, y: 10)
                            expect(fieldDrawerSpy.capturedLine?.to) == Point(x: 20, y: 20)
                        }
                        it("should draw line with current player color") {
                            expect(fieldDrawerSpy.capturedLineColor) == Player.player2.color
                        }
                    }
                }

                describe("line from current position to new position") {
                    beforeEach {
                        sut.move(to: Point(x: 10, y: 10))
                        sut.move(to: Point(x: 20, y: 20))
                    }
                    it("should be marked as used") {
                        expect(movesValidatorSpy.capturedUsedLine) == Line(from: Point(x: 10, y: 10), to: Point(x: 20, y: 20))
                    }
                }
            }

            describe("moves") {
                context("when moves controller emits move") {
                    beforeEach {
                        sut.move(to: Point(x: 0, y: 0))

                        movesControllerSpy.movesSubject.onNext(.downRight)
                    }

                    it("should move in emitted direction") {
                        expect(sut.currentPosition) == Point(x: 1, y: -1)
                    }
                }
            }
        }
    }
}

private class FieldDrawerSpy: FieldDrawer {
    var capturedLineColor: UIColor? = nil
    var capturedLine: Line? = nil
    var didDrawNewField = false
    var viewController = UIViewController()

    func drawNewField() {
        didDrawNewField = true
    }

    func draw(line: Line, color: UIColor) {
        capturedLine = line
        capturedLineColor = color
    }
}

private class MovesControllerSpy: MovesController {
    var capturedPossibleMoves = Set<Move>()
    var viewController = UIViewController()
    let movesSubject = PublishSubject<Move>()

    var moves: Observable<Move> { return movesSubject.asObservable() }
    func updateMovesPossibility(_ moves: Set<Move>) {
        capturedPossibleMoves = moves
    }
}

private class TurnControllerSpy: PlayerTurnController {
    var currentPlayer: Player = .player1
    var capturedPoint: Point? = nil

    func moved(to point: Point) {
        capturedPoint = point
    }
}

private class MovesValidatorSpy: MovesValidator {
    var possibleMoves = Set<Move>()
    var isMoveValid: Bool = false

    var capturedUsedLine: Line?

    func possibleMoves(from point: Point) -> Set<Move> {
        return possibleMoves
    }

    func setLineAsUsed(_ line: Line) {
        capturedUsedLine = line
    }
}
