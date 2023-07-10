import Foundation
import SwiftUI
import Quick
import Nimble
import SnapshotTesting

@testable import OnPaperSoccer

class MenuButtonSpec: QuickSpec {
    override func spec() {
        describe("MenuButton") {
            var sut: MenuButton!
            var viewController: UIViewController!
            
            beforeEach {
                sut = MenuButton(text: "Fixture", color: Color.App.red, action: {})
                viewController = UIHostingController(rootView: sut)
            }

            describe("snapshot") {
                it("should have valid snapshot") {
                    assertSnapshot(matching: viewController, as: .image(on: .iPhone12))
                }
            }
        }
    }
}
