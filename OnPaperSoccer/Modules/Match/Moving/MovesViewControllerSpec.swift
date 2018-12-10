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
                    ["vector": Vector(dx: 0, dy: 1),
                     "tapping": sut.upButton]
                }
            }

            describe("down button") {
                itBehavesLike("move") {
                    ["vector": Vector(dx: 0, dy: -1),
                     "tapping": sut.downButton]
                }
            }

            describe("left button") {
                itBehavesLike("move") {
                    ["vector": Vector(dx: -1, dy: 0),
                     "tapping": sut.leftButton]
                }
            }

            describe("right button") {
                itBehavesLike("move") {
                    ["vector": Vector(dx: 1, dy: 0),
                     "tapping": sut.rightButton]
                }
            }

            describe("up-left button") {
                itBehavesLike("move") {
                    ["vector": Vector(dx: -1, dy: 1),
                     "tapping": sut.upLeftButton]
                }
            }

            describe("up-right button") {
                itBehavesLike("move") {
                    ["vector": Vector(dx: 1, dy: 1),
                     "tapping": sut.upRightButton]
                }
            }

            describe("down-left button") {
                itBehavesLike("move") {
                    ["vector": Vector(dx: -1, dy: -1),
                     "tapping": sut.downLeftButton]
                }
            }

            describe("down-right button") {
                itBehavesLike("move") {
                    ["vector": Vector(dx: 1, dy: -1),
                     "tapping": sut.downRightButton]
                }
            }
        }
    }
}
