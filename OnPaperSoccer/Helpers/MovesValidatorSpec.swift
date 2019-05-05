import Foundation
import Quick
import Nimble

@testable import OnPaperSoccer

class MovesValidatorSpec: QuickSpec {
    override func spec() {
        describe("MovesValidator") {
            var sut: DefaultMovesValidator!
            var settings: GameSettings!

            beforeEach {
                settings = GameSettings.fixture
                sut = DefaultMovesValidator(settings: settings)
            }

            describe("sidelines") {
                context("when current position is on left sideline") {
                    var possibleMoves: Set<Move>!

                    beforeEach {
                        possibleMoves = sut.possibleMoves(from: Point(x: 0, y: 20))
                    }

                    it("should not be possible to move left") {
                        expect(possibleMoves).toNot(contain(Move.left))
                        expect(possibleMoves).toNot(contain(Move.upLeft))
                        expect(possibleMoves).toNot(contain(Move.downLeft))
                    }


                    it("should not be possible to move along sideline") {
                        expect(possibleMoves).toNot(contain(Move.up))
                        expect(possibleMoves).toNot(contain(Move.down))
                    }
                }

                context("when current position is on right sideline") {
                    var possibleMoves: Set<Move>!

                    beforeEach {
                        possibleMoves = sut.possibleMoves(from: Point(x: 41, y: 20))
                    }

                    it("should not be possible to move right") {
                        expect(possibleMoves).toNot(contain(Move.right))
                        expect(possibleMoves).toNot(contain(Move.upRight))
                        expect(possibleMoves).toNot(contain(Move.downRight))
                    }


                    it("should not be possible to move along sideline") {
                        expect(possibleMoves).toNot(contain(Move.up))
                        expect(possibleMoves).toNot(contain(Move.down))
                    }
                }

                context("when current position is on top sideline") {
                    var possibleMoves: Set<Move>!

                    beforeEach {
                        possibleMoves = sut.possibleMoves(from: Point(x: 20, y: 42))
                    }

                    it("should not be possible to move up") {
                        expect(possibleMoves).toNot(contain(Move.up))
                        expect(possibleMoves).toNot(contain(Move.upRight))
                        expect(possibleMoves).toNot(contain(Move.upLeft))
                    }


                    it("should not be possible to move along sideline") {
                        expect(possibleMoves).toNot(contain(Move.left))
                        expect(possibleMoves).toNot(contain(Move.right))
                    }
                }

                context("when current position is on bottom sideline") {
                    var possibleMoves: Set<Move>!

                    beforeEach {
                        possibleMoves = sut.possibleMoves(from: Point(x: 20, y: 0))
                    }

                    it("should not be possible to move down") {
                        expect(possibleMoves).toNot(contain(Move.down))
                        expect(possibleMoves).toNot(contain(Move.downRight))
                        expect(possibleMoves).toNot(contain(Move.downLeft))
                    }

                    it("should not be possible to move along sideline") {
                        expect(possibleMoves).toNot(contain(Move.left))
                        expect(possibleMoves).toNot(contain(Move.right))
                    }
                }
            }

            context("when line from starting point towards some direction was used") {
                var possibleMoves: Set<Move>!

                beforeEach {
                    let startingPoint = Point(x: 5, y: 5)
                    let endingPoint = startingPoint.shifted(by: Move.up.vector)
                    let line = Line(from: startingPoint, to: endingPoint)
                    sut.setLineAsUsed(line)

                    possibleMoves = sut.possibleMoves(from: startingPoint)
                }

                it("should return possible moves without that direction") {
                    expect(possibleMoves).toNot(contain([Move.up]))
                }
            }

            context("when line ending in starting point is used") {
                var possibleMoves: Set<Move>!

                beforeEach {
                    let startingPoint = Point(x: 5, y: 5)
                    let endingPoint = startingPoint.shifted(by: Move.up.vector)
                    let oppositeDirectionLine = Line(from: endingPoint, to: startingPoint)
                    sut.setLineAsUsed(oppositeDirectionLine)

                    possibleMoves = sut.possibleMoves(from: startingPoint)
                }

                it("should return possible moves without direction pointing used line") {
                    expect(possibleMoves).toNot(contain([Move.up]))
                }
            }

            describe("reset") {
                beforeEach {
                    sut.usedLines = [Line.fixture, Line.fixture2]

                    sut.reset()
                }

                it("should reset") {
                    expect(sut.usedLines).to(beEmpty())
                }
            }
        }
    }
}