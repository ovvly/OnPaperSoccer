//
//  MenuInteractor.swift
//  OnPaperSoccer
//
//  Created by Jakub Sowa on 10/07/2023.
//  Copyright © 2023 com.owlyapps.onPaperSoccer. All rights reserved.
//

import Foundation



protocol MenuInteracting {
    func singlePlayerTapped()
    func hotSeatsSelected()
    func aboutSelected()
}

public enum MenuRoute: Equatable {
    case singlePlayer
    case hotSeats
    case about
}

final class MenuInteractor: MenuInteracting {
    private let onRoute: (MenuRoute) -> Void

    init(onRoute: @escaping (MenuRoute) -> Void) {
        self.onRoute = onRoute
    }
    
    func singlePlayerTapped() {
        onRoute(.singlePlayer)
    }
    
    func hotSeatsSelected() {
        onRoute(.hotSeats)
    }
    
    func aboutSelected() {
        onRoute(.about)
    }
}
