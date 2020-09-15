import Foundation
import Quick
import Nimble

@testable import OnPaperSoccer

class MovesViewControllerSpec: QuickSpec {
    override func spec() {

        describe("MatchViewController") {
            var sut: MovesViewController!
            var delegate: MovesViewControllerDelegateSpy!

            beforeEach {
                sut = MovesViewController()
                delegate = MovesViewControllerDelegateSpy()
                sut.delegate = delegate

                _ = sut.view
            }

            describe("actions") {
                sharedExamples("move") { context in
                    var expectedMove: Move!

                    beforeEach {
                        expectedMove = context()["direction"] as? Move
                        let button = context()["tapping"] as! UIButton

                        button.simulateTap()
                    }
                    it("should inform delegate about moving in correct direction") {
                        expect(delegate.capturedMove) == expectedMove
                    }
                }

                describe("up button") {
                    itBehavesLike("move") {
                        ["direction": Move.up,
                         "tapping": sut.upButton!]
                    }
                }

                describe("down button") {
                    itBehavesLike("move") {
                        ["direction": Move.down,
                         "tapping": sut.downButton!]
                    }
                }

                describe("left button") {
                    itBehavesLike("move") {
                        ["direction": Move.left,
                         "tapping": sut.leftButton!]
                    }
                }

                describe("right button") {
                    itBehavesLike("move") {
                        ["direction": Move.right,
                         "tapping": sut.rightButton!]
                    }
                }

                describe("up-left button") {
                    itBehavesLike("move") {
                        ["direction": Move.upLeft,
                         "tapping": sut.upLeftButton!]
                    }
                }

                describe("up-right button") {
                    itBehavesLike("move") {
                        ["direction": Move.upRight,
                         "tapping": sut.upRightButton!]
                    }
                }

                describe("down-left button") {
                    itBehavesLike("move") {
                        ["direction": Move.downLeft,
                         "tapping": sut.downLeftButton!]
                    }
                }

                describe("down-right button") {
                    itBehavesLike("move") {
                        ["direction": Move.downRight,
                         "tapping": sut.downRightButton!]
                    }
                }
            }

            describe("update moves possibility") {
                beforeEach {
                    sut.updateMovesPossibility([.up, .left, .downRight])
                }

                it("should have correct buttons enabled") {
                    expect(sut.upButton.isEnabled) == true
                    expect(sut.downButton.isEnabled) == false
                    expect(sut.leftButton.isEnabled) == true
                    expect(sut.rightButton.isEnabled) == false
                    expect(sut.upLeftButton.isEnabled) == false
                    expect(sut.upRightButton.isEnabled) == false
                    expect(sut.downLeftButton.isEnabled) == false
                    expect(sut.downRightButton.isEnabled) == true
                }
            }
            
            describe("reset") {
                beforeEach {
                    sut.updateMovesPossibility(Set([]))

                    sut.reset()
                }    
                
                it("should make all moves possible") {
                    expect(sut.upButton.isEnabled) == true
                    expect(sut.downButton.isEnabled) == true
                    expect(sut.leftButton.isEnabled) == true
                    expect(sut.rightButton.isEnabled) == true
                    expect(sut.upLeftButton.isEnabled) == true
                    expect(sut.upRightButton.isEnabled) == true
                    expect(sut.downLeftButton.isEnabled) == true
                    expect(sut.downRightButton.isEnabled) == true
                }
            }

            describe("disable moves") {
                beforeEach {
                    sut.updateMovesPossibility([.up, .down, .left, .right, .upLeft, .upRight, .downLeft, .downRight])

                    sut.disableMoves()
                }
                
                it("should disable all buttons") {
                    expect(sut.upButton.isEnabled) == false
                    expect(sut.downButton.isEnabled) == false
                    expect(sut.leftButton.isEnabled) == false
                    expect(sut.rightButton.isEnabled) == false
                    expect(sut.upLeftButton.isEnabled) == false
                    expect(sut.upRightButton.isEnabled) == false
                    expect(sut.downLeftButton.isEnabled) == false
                    expect(sut.downRightButton.isEnabled) == false
                }
            }
        }
    }
}

private class MovesViewControllerDelegateSpy: MovesControllerDelegate {
    var capturedMove: Move?

    func didMove(_ move: Move) {
        capturedMove = move
    }
}
