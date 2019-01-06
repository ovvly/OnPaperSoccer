import Foundation
import Quick
import Nimble

@testable import OnPaperSoccer

class MovesValidatorSpec: QuickSpec {
    override func spec() {
        describe("MovesValidator") {
            var sut: DefaultMovesValidator!
            
            beforeEach {
                sut = DefaultMovesValidator(fieldWidth: 42, fieldHeight: 43)
            }

            sharedExamples("possible moves") { context in
                var result: Set<Move>!
                var moves: Set<Move>!

                beforeEach {
                    let point = context()["point"] as! Point
                    moves = context()["moves"] as? Set<Move>

                    result = sut.possibleMoves(from: point)

                }

                it("should have result the same as expectation") {
                    expect(result) == moves
                }
            }

            context("when current position is on left sideline") {
                itBehavesLike("possible moves") {["point": Point(x: 0, y: 20), "moves": Set([Move.right, Move.upRight, Move.downRight])]}
            }

            context("when current position is on right sideline") {
                itBehavesLike("possible moves") {["point": Point(x: 41, y: 20), "moves": Set([Move.left, Move.upLeft, Move.downLeft])]}
            }

            context("when current position is on top sideline") {
                itBehavesLike("possible moves") {["point": Point(x: 20, y: 42), "moves": Set([Move.down, Move.downLeft, Move.downRight])]}
            }

            context("when current position is on bottom sideline") {
                itBehavesLike("possible moves") {["point": Point(x: 20, y: 0), "moves": Set([Move.up, Move.upLeft, Move.upRight])]}
            }

            pending("corners") {

            }

            pending("goal fields") {

            }
        }
    }
}