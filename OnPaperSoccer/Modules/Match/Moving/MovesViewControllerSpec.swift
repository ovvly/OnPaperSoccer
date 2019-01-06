import Foundation
import Quick
import Nimble
import RxSwift

@testable import OnPaperSoccer

class MovesViewControllerSpec: QuickSpec {
    override func spec() {

        describe("MatchViewController") {
            var sut: MovesViewController!
            var disposeBag: DisposeBag!

            beforeEach {
                disposeBag = DisposeBag()
                sut = MovesViewController()
                _ = sut.view
            }

            describe("actions") {
                sharedExamples("move") { context in
                    var capturedMove: Move!
                    var expectedMove: Move!

                    beforeEach {
                        sut.moves
                            .subscribe(onNext: { move in
                                capturedMove = move
                            })
                            .disposed(by: disposeBag)

                        expectedMove = context()["direction"] as? Move
                        let button = context()["tapping"] as! UIButton

                        button.simulateTap()
                    }
                    it("should emit move in correct direction") {
                        expect(expectedMove) == capturedMove
                    }
                }

                describe("up button") {
                    itBehavesLike("move") {
                        ["direction": Move.up,
                         "tapping": sut.upButton]
                    }
                }

                describe("down button") {
                    itBehavesLike("move") {
                        ["direction": Move.down,
                         "tapping": sut.downButton]
                    }
                }

                describe("left button") {
                    itBehavesLike("move") {
                        ["direction": Move.left,
                         "tapping": sut.leftButton]
                    }
                }

                describe("right button") {
                    itBehavesLike("move") {
                        ["direction": Move.right,
                         "tapping": sut.rightButton]
                    }
                }

                describe("up-left button") {
                    itBehavesLike("move") {
                        ["direction": Move.upLeft,
                         "tapping": sut.upLeftButton]
                    }
                }

                describe("up-right button") {
                    itBehavesLike("move") {
                        ["direction": Move.upRight,
                         "tapping": sut.upRightButton]
                    }
                }

                describe("down-left button") {
                    itBehavesLike("move") {
                        ["direction": Move.downLeft,
                         "tapping": sut.downLeftButton]
                    }
                }

                describe("down-right button") {
                    itBehavesLike("move") {
                        ["direction": Move.downRight,
                         "tapping": sut.downRightButton]
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
        }
    }
}
