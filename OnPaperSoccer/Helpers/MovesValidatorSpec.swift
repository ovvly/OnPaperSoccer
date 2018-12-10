import Foundation
import Quick
import Nimble

@testable import OnPaperSoccer

class MovesValidatorSpec: QuickSpec {
    override func spec() {
        describe("MovesValidator") {
            var sut: DefaultMovesValidator!
            
            beforeEach {
                sut = DefaultMovesValidator()
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
                    itBehavesLike("valid move") {["point": Point(x: 1, y: 0), "vector": Vector(dx: -1, dy: 0)]}
                }

                context("when move will cross left sideline") {
                    itBehavesLike("invalid move") {["point": Point(x: 0, y: 0), "vector": Vector(dx: -1, dy: 0)]}
                }
            }
        }
    }
}