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

            context("when selecting play row") {
                beforeEach {
                    sut.didSelectedPlayRow(MenuRowButton())
                }

                it("should inform delegate") {
                    expect(menuViewControllerDelegateSpy.playSelected) == true
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
    var playSelected = false
    var aboutSelected = false

    func didSelectedPlay() {
        playSelected = true
    }

    func didSelectedAbout() {
        aboutSelected = true
    }
}