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
            var delegate: MatchViewControllerDelegateSpy!
            var startingPoint: Point!
            var sut: MatchViewController!

            beforeEach {
                fieldDrawerSpy = FieldDrawerSpy()
                movesControllerSpy = MovesControllerSpy()
                turnControllerSpy = TurnControllerSpy()
                movesValidatorSpy = MovesValidatorSpy()
                delegate = MatchViewControllerDelegateSpy()
                startingPoint = Point.fixture

                sut = MatchViewController(fieldDrawer: fieldDrawerSpy,
                    movesController: movesControllerSpy,
                    playerTurnController: turnControllerSpy,
                    movesValidator: movesValidatorSpy,
                    startingPoint: startingPoint)

                sut.delegate = delegate
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
                    expect(sut.currentPosition) == startingPoint
                }

                it("should set starting point in player turn controller") {
                    expect(turnControllerSpy.capturedStartingPoint) == startingPoint
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

                context("when moving to player 1 wining point") {
                    beforeEach {
                        sut.set(winingPoint: Point(x: 10, y: 10), for: .player1)

                        sut.move(to: Point(x: 10, y: 10))
                    }

                    it("should inform about player 1 win") {
                        expect(delegate.playerDidWin) == .player1
                    }
                }

                context("when player 1 does not have any moves") {
                    beforeEach {
                        movesValidatorSpy.possibleMoves = Set()
                        sut.move(to: Point(x: 10, y: 10))
                    }
                    
                    it("should inform about player 2 win") {
                        expect(delegate.playerDidWin) == .player2
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

            describe("reset") {
                beforeEach {
                    sut.move(to: Point(x: 0, y: 0))

                    sut.reset()
                }

                it("should set current position to starting position") {
                    expect(sut.currentPosition) == startingPoint
                }

                it("should reset field drawer") {
                    expect(fieldDrawerSpy.didReset) == true
                }

                it("should reset moves validator controller") {
                    expect(movesValidatorSpy.didReset) == true
                }

                it("should reset player turn controller") {
                    expect(turnControllerSpy.didReset) == true
                }
                
                it("should reset moves controller") {
                    expect(movesControllerSpy.didReset) == true
                }
            }
        }
    }
}

private class FieldDrawerSpy: FieldDrawer {
    var didReset = false
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

    func reset() {
        didReset = true
    }
}

private class MovesControllerSpy: MovesController {
    var didReset = false
    var capturedPossibleMoves = Set<Move>()
    var viewController = UIViewController()
    let movesSubject = PublishSubject<Move>()
    var moves: Observable<Move> { return movesSubject.asObservable() }

    func updateMovesPossibility(_ moves: Set<Move>) {
        capturedPossibleMoves = moves
    }

    func reset() {
        didReset = true
    }
}

private class TurnControllerSpy: PlayerTurnController {
    var didReset = false
    var currentPlayer: Player = .player1
    var capturedPoint: Point? = nil
    var capturedStartingPoint: Point? = nil

    func moved(to point: Point) {
        capturedPoint = point
    }

    func set(startingPoint: Point) {
        capturedStartingPoint = startingPoint
    }

    func reset() {
        didReset = true
    }
}

private class MovesValidatorSpy: MovesValidator {
    var didReset = false
    var possibleMoves = Set<Move>()
    var isMoveValid: Bool = false

    var capturedUsedLine: Line?

    func possibleMoves(from point: Point) -> Set<Move> {
        return possibleMoves
    }

    func setLineAsUsed(_ line: Line) {
        capturedUsedLine = line
    }

    func reset() {
        didReset = true
    }
}

class MatchViewControllerDelegateSpy: MatchViewControllerDelegate {
    var playerDidWin: Player? = nil

    func playerDidWin(_ player: Player) {
        playerDidWin = player
    }
}

