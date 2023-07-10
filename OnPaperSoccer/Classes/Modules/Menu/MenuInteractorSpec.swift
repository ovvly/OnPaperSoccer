//
//  MenuInteractorSpec.swift
//  OnPaperSoccerTests
//
//  Created by Jakub Sowa on 10/07/2023.
//  Copyright © 2023 com.owlyapps.onPaperSoccer. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import OnPaperSoccer

class MenuInteractorSpec: QuickSpec {
    override func spec() {
        describe("MenuInteractor") {
            var sut: MenuInteractor!
            var capturedRoute: MenuRoute!

            beforeEach {
                sut = MenuInteractor(onRoute: { route in
                    capturedRoute = route
                })
            }

            context("when selecting single player row") {
                beforeEach {
                    sut.singlePlayerTapped()
                }

                it("should call single player routing") {
                    expect(capturedRoute) == .singlePlayer
                }
            }

            context("when selecting hot seats row") {
                beforeEach {
                    sut.hotSeatsSelected()
                }

                it("should call hot seats routing") {
                    expect(capturedRoute) == .hotSeats
                }
            }
            
            context("when selecting about row") {
                beforeEach {
                    sut.aboutSelected()
                }

                it("should call about routing") {
                    expect(capturedRoute) == .about
                }
            }
        }
    }
}
