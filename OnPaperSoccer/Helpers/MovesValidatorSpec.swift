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

            sharedExamples("valid move") { context in
                var result: Bool!

                beforeEach {
                    let point = context()["point"] as! Point
                    let vector = context()["vector"] as! Vector

                    result = sut.isValidMove(from: point, by: vector)

                }
                it("should have result the same as expectation") {
                    expect(result) == true
                }
            }

            sharedExamples("invalid move") { context in
                var result: Bool!

                beforeEach {
                    let point = context()["point"] as! Point
                    let vector = context()["vector"] as! Vector

                    result = sut.isValidMove(from: point, by: vector)

                }
                it("should have result the same as expectation") {
                    expect(result) == false
                }
            }

            describe("left sideline") {
                context("when move will end on left sideline") {
                    itBehavesLike("valid move") {["point": Point(x: 1, y: 0), "vector": Vector.left]}
                }

                context("when move will cross left sideline") {
                    itBehavesLike("invalid move") {["point": Point(x: 0, y: 0), "vector": Vector.left]}
                }
            }

            describe("right sideline") {
                context("when move will end on right sideline") {
                    itBehavesLike("valid move") {["point": Point(x: 40, y: 0), "vector": Vector.right]}
                }

                context("when move will cross right sideline") {
                    itBehavesLike("invalid move") {["point": Point(x: 41, y: 0), "vector": Vector.right]}
                }
            }

            describe("top sideline") {
                context("when move will end on top sideline") {
                    itBehavesLike("valid move") {["point": Point(x: 0, y: 41), "vector": Vector.up]}
                }

                context("when move will cross top sideline") {
                    itBehavesLike("invalid move") {["point": Point(x: 0, y: 42), "vector": Vector.up]}
                }
            }

            describe("bottom sideline") {
                context("when move will end on bottom sideline") {
                    itBehavesLike("valid move") {["point": Point(x: 0, y: 1), "vector": Vector.down]}
                }

                context("when move will cross bottom sideline") {
                    itBehavesLike("invalid move") {["point": Point(x: 0, y: 0), "vector": Vector.down]}
                }
            }
        }
    }
}