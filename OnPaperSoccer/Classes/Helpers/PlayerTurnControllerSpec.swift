import Foundation
import Quick
import Nimble

@testable import OnPaperSoccer

class TurnControllerSpec: QuickSpec {
    override func spec() {
        describe("DefaultPlayerTurnController") {
            var gameSettings: FieldSettings!
            var sut: DefaultPlayerTurnController!

            beforeEach {
                gameSettings = FieldSettings.fixture

                sut = DefaultPlayerTurnController(settings: gameSettings)
            }

            describe("init") {
                it("should visited points should have contain starting point") {
                    expect(sut.visitedPoints) == [gameSettings.startingPoint]
                }
            }

            describe("moved to point") {
                context("when is player 1") {
                    beforeEach {
                        sut.currentPlayer = .player1
                    }

                    context("when moving to not visited point") {
                        beforeEach {
                            sut.moved(to: Point(x: 10, y: 10))
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
                            sut.moved(to: Point(x: 10, y: 10))
                        }

                        it("should change current player to player 1") {
                            expect(sut.currentPlayer) == Player.player1
                        }
                    }

                    context("when moving to visited point") {
                        beforeEach {
                            sut.visitedPoints = [Point(x: 10, y: 10)]

                            sut.moved(to: Point(x: 10, y: 10))
                        }

                        it("should have player 2 as current player") {
                            expect(sut.currentPlayer) == Player.player2
                        }
                    }
                }

                context("when moving to starting point") {
                    beforeEach {
                        sut.currentPlayer = .player2

                        sut.moved(to: gameSettings.startingPoint)
                    }

                    it("should NOT change current player") {
                        expect(sut.currentPlayer) == .player2
                    }
                }

                context("when moving to left border point") {
                    beforeEach {
                        sut.moved(to: Point(x: 0, y: 42))
                    }

                    it("should NOT change current player") {
                        expect(sut.currentPlayer) == .player1
                    }
                }

                context("when moving to right border point") {
                    beforeEach {
                        sut.moved(to: Point(x: 41, y: 21))
                    }

                    it("should NOT change current player") {
                        expect(sut.currentPlayer) == .player1
                    }
                }

                context("when moving to top border point") {
                    beforeEach {
                        sut.moved(to: Point(x: 21, y: 42))
                    }

                    it("should NOT change current player") {
                        expect(sut.currentPlayer) == .player1
                    }
                }

                context("when moving to bottom border point") {
                    beforeEach {
                        sut.moved(to: Point(x: 21, y: 0))
                    }

                    it("should NOT change current player") {
                        expect(sut.currentPlayer) == .player1
                    }
                }
            }

            describe("reset") {
                beforeEach {
                    sut.currentPlayer = .player2
                    sut.visitedPoints = [Point.fixture, Point(x: 42, y: 42)]

                    sut.reset()
                }

                it("should reset") {
                    expect(sut.currentPlayer) == Player.player1
                    expect(sut.visitedPoints) == [gameSettings.startingPoint]
                }
            }
        }
    }
}