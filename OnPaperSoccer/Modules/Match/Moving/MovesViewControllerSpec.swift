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

            sharedExamples("move") { context in
                var capturedVector: Vector!
                var expectedVector: Vector!

                beforeEach {
                    sut.moves
                        .subscribe(onNext: { move in
                            capturedVector = move
                        })
                        .disposed(by: disposeBag)

                    expectedVector = context()["vector"] as? Vector
                    let button = context()["tapping"] as! UIButton

                    button.simulateTap()
                }
                it("should emit vector in correct direction") {
                    expect(expectedVector) == capturedVector
                }
            }

            describe("up button") {
                itBehavesLike("move") {
                    ["vector": Vector.up,
                     "tapping": sut.upButton]
                }
            }

            describe("down button") {
                itBehavesLike("move") {
                    ["vector": Vector.down,
                     "tapping": sut.downButton]
                }
            }

            describe("left button") {
                itBehavesLike("move") {
                    ["vector": Vector.left,
                     "tapping": sut.leftButton]
                }
            }

            describe("right button") {
                itBehavesLike("move") {
                    ["vector": Vector.right,
                     "tapping": sut.rightButton]
                }
            }

            describe("up-left button") {
                itBehavesLike("move") {
                    ["vector": Vector.upLeft,
                     "tapping": sut.upLeftButton]
                }
            }

            describe("up-right button") {
                itBehavesLike("move") {
                    ["vector": Vector.upRight,
                     "tapping": sut.upRightButton]
                }
            }

            describe("down-left button") {
                itBehavesLike("move") {
                    ["vector": Vector.downLeft,
                     "tapping": sut.downLeftButton]
                }
            }

            describe("down-right button") {
                itBehavesLike("move") {
                    ["vector": Vector.downRight,
                     "tapping": sut.downRightButton]
                }
            }
        }
    }
}
