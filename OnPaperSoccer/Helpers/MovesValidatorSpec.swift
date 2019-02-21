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

            context("when current position is on left sideline") {
                var possibleMoves: Set<Move>!

                beforeEach {
                    possibleMoves = sut.possibleMoves(from: Point(x: 0, y: 0))
                }

                it("should not be possible to move left") {
                    expect(possibleMoves).toNot(contain([Move.left, Move.upLeft, Move.downLeft]))
                }
            }

            context("when current position is on right sideline") {
                var possibleMoves: Set<Move>!

                beforeEach {
                    possibleMoves = sut.possibleMoves(from: Point(x: 41, y: 0))
                }

                it("should not be possible to move right") {
                    expect(possibleMoves).toNot(contain([Move.right, Move.upRight, Move.downRight]))
                }
            }

            context("when current position is on top sideline") {
                var possibleMoves: Set<Move>!

                beforeEach {
                    possibleMoves = sut.possibleMoves(from: Point(x: 0, y: 42))
                }

                it("should not be possible to move up") {
                    expect(possibleMoves).toNot(contain([Move.up, Move.upRight, Move.upLeft]))
                }
            }

            context("when current position is on bottom sideline") {
                var possibleMoves: Set<Move>!

                beforeEach {
                    possibleMoves = sut.possibleMoves(from: Point(x: 0, y: 0))
                }

                it("should not be possible to move down") {
                    expect(possibleMoves).toNot(contain([Move.down, Move.downLeft, Move.downRight]))
                }
            }

            pending("corners") {

            }

            pending("goal fields") {

            }
        }
    }
}