import Foundation
import Quick
import Nimble

@testable import OnPaperSoccer

class TurnControllerSpec: QuickSpec {
    override func spec() {
        describe("DefaultPlayerTurnController") {
            var sut: DefaultPlayerTurnController!
            beforeEach {
                sut = DefaultPlayerTurnController()
            }

            describe("moved to point") {
                context("when is player 1") {
                    beforeEach {
                        sut.currentPlayer = .player1
                    }

                    context("when moving to not visited point") {
                        beforeEach {
                            sut.moved(to: Point.fixture)
                        }

                        it("should change current player to player 2") {
                            expect(sut.currentPlayer) == Player.player2
                        }
                    }

                    context("when moving to visited point") {
                        beforeEach {
                            sut.visitedPoints = [Point.fixture]

                            sut.moved(to: Point.fixture)
                        }

                        it("should have player 1 as current player") {
                            expect(sut.currentPlayer) == Player.player1
                        }
                    }
                }

                context("when is player 2") {
                    beforeEach {
                        sut.currentPlayer = .player2
                    }

                    context("when moving to not visited point") {
                        beforeEach {
                            sut.moved(to: Point.fixture)
                        }

                        it("should change current player to player 1") {
                            expect(sut.currentPlayer) == Player.player1
                        }
                    }

                    context("when moving to visited point") {
                        beforeEach {
                            sut.visitedPoints = [Point.fixture]

                            sut.moved(to: Point.fixture)
                        }

                        it("should have player 2 as current player") {
                            expect(sut.currentPlayer) == Player.player2
                        }
                    }
                }

                context("when moving to starting point") {
                    beforeEach {
                        sut.set(startingPoint: Point.fixture)
                        sut.currentPlayer = .player2

                        sut.moved(to: Point.fixture)
                    }

                    it("should NOT change current player") {
                        expect(sut.currentPlayer) == .player2
                    }
                }
            }
        }
    }
}