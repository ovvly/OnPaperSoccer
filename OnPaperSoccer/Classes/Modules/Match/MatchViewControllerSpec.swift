import Foundation
import UIKit
import Quick
import Nimble

@testable import OnPaperSoccer

class MatchViewControllerSpec: QuickSpec {
    override func spec() {
        describe("MatchViewController") {
            var fieldDrawerSpy: FieldDrawerSpy!
            var movesControllerSpy: MovesControllerSpy!
            var turnControllerSpy: TurnControllerSpy!
            var movesValidatorSpy: MovesValidatorSpy!
            var delegate: MatchViewControllerDelegateSpy!
            var fieldSettings: FieldSettings!
            var player1WinningPoint: Point!
            var player2WinningPoint: Point!

            var sut: MatchViewController!

            beforeEach {
                fieldDrawerSpy = FieldDrawerSpy()
                movesControllerSpy = MovesControllerSpy()
                turnControllerSpy = TurnControllerSpy()
                movesValidatorSpy = MovesValidatorSpy()
                delegate = MatchViewControllerDelegateSpy()
                player1WinningPoint = Point(x: 44, y: 45)
                player2WinningPoint = Point(x: 46, y: 47)
                fieldSettings = FieldSettings.fixture(winningPoints: [player1WinningPoint: .player1, player2WinningPoint: .player2])
            }

            context("hot seats") {
                beforeEach {
                    sut = MatchViewController(fieldDrawer: fieldDrawerSpy,
                            movesController: movesControllerSpy,
                            playerTurnController: turnControllerSpy,
                            movesValidator: movesValidatorSpy,
                            settings: fieldSettings,
                            gameMode: .hotSeats)

                    sut.delegate = delegate
                    _ = sut.view
                }

                describe("init") {
                    it("should add field drawer view as subview") {
                        expect(sut.children).to(contain(fieldDrawerSpy.viewController))
                    }

                    it("should draw initial field") {
                        expect(fieldDrawerSpy.didDrawNewField) == true
                    }

                    it("should have current position set to middle of field size") {
                        expect(sut.currentPosition) == fieldSettings.startingPoint
                    }

                    it("should indicate player 1 turn") {
                        expect(sut.turnLabel.text) == "RED PLAYER TURN"
                        expect(sut.turnView.backgroundColor) == Player.player1.color
                    }
                }

                describe("view did layout subviews") {
                    beforeEach {
                        sut.viewDidLayoutSubviews()
                    }

                    it("should mark middle of field as current position") {
                        expect(fieldDrawerSpy.markedPoint) == fieldSettings.startingPoint
                        expect(fieldDrawerSpy.markingColor) == Player.player1.color
                    }
                }

                describe("move to") {
                    describe("current position") {
                        beforeEach {
                            turnControllerSpy.currentPlayer = .player2

                            sut.move(to: Point(x: 10, y: 10))
                        }

                        it("should be set correctly") {
                            expect(sut.currentPosition) == Point(x: 10, y: 10)
                        }

                        it("should inform turn controller about move") {
                            expect(turnControllerSpy.capturedPoint) == Point(x: 10, y: 10)
                        }

                        it("should mark current position on field drawer") {
                            expect(fieldDrawerSpy.markedPoint) == Point(x: 10, y: 10)
                        }

                        it("should mark current position with current player color") {
                            expect(fieldDrawerSpy.markingColor) == Player.player2.color
                        }

                        it("should set self as moves controller delegate") {
                            expect(movesControllerSpy.delegate) === sut
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
                            sut.move(to: player1WinningPoint)
                        }

                        it("should inform about player 1 win") {
                            expect(delegate.playerDidWin) == .player1
                        }

                        it("should block further moves") {
                            expect(movesControllerSpy.capturedPossibleMoves) == []
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

                        it("should block further moves") {
                            expect(movesControllerSpy.capturedPossibleMoves) == []
                        }
                    }

                    describe("turn updating") {
                        context("when moved to new point") {
                            context("when current player is now player 1") {
                                beforeEach {
                                    movesValidatorSpy.possibleMoves = [.left, .right, .up]
                                    turnControllerSpy.currentPlayer = .player1
                                    sut.didMove(.downRight)
                                }

                                it("should set correct text on turn label") {
                                    expect(sut.turnLabel.text) == "RED PLAYER TURN"
                                }

                                it("should set correct color on turn view") {
                                    expect(sut.turnView.backgroundColor) == Player.player1.color
                                }

                                it("should have moves NOT disabled") {
                                    expect(movesControllerSpy.capturedPossibleMoves) == [.left, .right, .up]
                                }
                            }

                            context("when current player is now player 2") {
                                beforeEach {
                                    movesValidatorSpy.possibleMoves = [.left, .right, .up]
                                    turnControllerSpy.currentPlayer = .player2
                                    sut.didMove(.downRight)
                                }

                                it("should set correct text on turn label") {
                                    expect(sut.turnLabel.text) == "BLUE PLAYER TURN"
                                }

                                it("should set correct color on turn view") {
                                    expect(sut.turnView.backgroundColor) == Player.player2.color
                                }

                                it("should have moves NOT disabled") {
                                    expect(movesControllerSpy.capturedPossibleMoves) == [.left, .right, .up]
                                }
                            }
                        }
                    }
                }

                describe("moves") {
                    context("when moves controller emits move") {
                        beforeEach {
                            sut.move(to: Point(x: 0, y: 0))

                            sut.didMove(.downRight)
                        }
                        it("should move in emitted direction") {
                            expect(sut.currentPosition) == Point(x: 1, y: -1)
                        }
                    }
                }

                describe("resetting") {
                    sharedExamples("reset") { (sharedExampleContext: @escaping SharedExampleContext) in
                        it("should set current position to starting position") {
                            expect(sut.currentPosition) == fieldSettings.startingPoint
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

                        it("should mark middle of field as current position") {
                            expect(fieldDrawerSpy.markedPoint) == fieldSettings.startingPoint
                            expect(fieldDrawerSpy.markingColor) == Player.player1.color
                        }

                        it("should reset turn view") {
                            expect(sut.turnLabel.text) == "RED PLAYER TURN"
                            expect(sut.turnView.backgroundColor) == Player.player1.color
                        }
                    }

                    describe("reset") {
                        beforeEach {
                            sut.move(to: Point(x: 0, y: 0))
                            fieldDrawerSpy.markingColor = nil
                            fieldDrawerSpy.markedPoint = nil

                            sut.reset()
                        }

                        itBehavesLike("reset")

                        context("when resetting during blue player turn") {
                            beforeEach {
                                sut.turnLabel.text = "BLUE PLAYER TURN"
                                sut.turnView.backgroundColor = Player.player2.color

                                sut.reset()
                            }

                            itBehavesLike("reset")
                        }
                    }

                    describe("reset button") {
                        beforeEach {
                            sut.navigationItem.rightBarButtonItem?.simulateTap()
                        }

                        it("should inform delegate about reset") {
                            expect(delegate.resetRequested) == true
                        }
                    }
                }
            }

            describe("single player") {
                beforeEach {
                    sut = MatchViewController(fieldDrawer: fieldDrawerSpy,
                            movesController: movesControllerSpy,
                            playerTurnController: turnControllerSpy,
                            movesValidator: movesValidatorSpy,
                            settings: fieldSettings,
                            gameMode: .singlePlayer)

                    sut.delegate = delegate
                    _ = sut.view
                }

                describe("after move when there are possible moves") {
                    beforeEach {
                        movesValidatorSpy.possibleMoves = [.up, .left, .right]
                    }

                    context("when its player 2 turn") {
                        beforeEach {
                            turnControllerSpy.currentPlayer = .player2

                            sut.didMove(.downLeft)
                        }

                        it("should disable moves") {
                            expect(movesControllerSpy.capturedPossibleMoves) == []
                        }
                    }

                    context("when its player 1 move") {
                        beforeEach {
                            turnControllerSpy.currentPlayer = .player1

                            sut.didMove(.downLeft)
                        }

                        it("should NOT disable moves") {
                            expect(movesControllerSpy.capturedPossibleMoves) == [.up, .left, .right]
                        }
                    }
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
    var markedPoint: Point? = nil
    var markingColor: UIColor? = nil

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

    func mark(currentPoint: Point, with color: UIColor) {
        markedPoint = currentPoint
        markingColor = color
    }
}

private class MovesControllerSpy: MovesController {
    var didReset = false
    var capturedPossibleMoves = Set<Move>()
    var viewController = UIViewController()
    var delegate: MovesControllerDelegate? = nil

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

    func moved(to point: Point) {
        capturedPoint = point
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
        possibleMoves
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
    var resetRequested = false

    func playerDidWin(_ player: Player) {
        playerDidWin = player
    }

    func showResetConfirmation() {
        resetRequested = true
    }
}

