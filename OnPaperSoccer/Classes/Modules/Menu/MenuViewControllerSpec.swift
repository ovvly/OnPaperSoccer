import Foundation
import Quick
import Nimble
import SnapshotTesting

@testable import OnPaperSoccer

class MenuViewControllerSpec: QuickSpec {
    override func spec() {
        describe("MenuViewController") { 
            var sut: MenuViewController!
            var menuViewControllerDelegateSpy: MenuViewControllerDelegateSpy!

            beforeEach {
                menuViewControllerDelegateSpy = MenuViewControllerDelegateSpy()
                sut = MenuViewController()
                sut.delegate = menuViewControllerDelegateSpy
                _ = sut.view
            }
            
            describe("snapshot") {
                it("should have valid snapshot") {
                    assertSnapshot(matching: sut, as: .image(on: .iPhone8))
                }
            }

            context("when selecting single player row") {
                beforeEach {
                    sut.didSelectedSinglePlayerRow(MenuRowButton())
                }

                it("should inform delegate") {
                    expect(menuViewControllerDelegateSpy.singlePlayerSelected) == true
                }
            }

            context("when selecting about row") {
                beforeEach {
                    sut.didSelectedAboutRow(MenuRowButton())
                }

                it("should inform delegate") {
                    expect(menuViewControllerDelegateSpy.aboutSelected) == true
                }
            }

        }
    }
}

private final class MenuViewControllerDelegateSpy: MenuViewControllerDelegate {
    var hotSeatsSelected = false
    var singlePlayerSelected = false
    var aboutSelected = false

    func didSelectedHotSeats() {
        hotSeatsSelected = true
    }

    func didSelectedSinglePlayer() {
        singlePlayerSelected = true
    }

    func didSelectedAbout() {
        aboutSelected = true
    }
}
