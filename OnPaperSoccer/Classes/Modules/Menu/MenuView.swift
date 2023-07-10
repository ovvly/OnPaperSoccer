//
//  MenuView.swift
//  OnPaperSoccer
//
//  Created by Jakub Sowa on 10/07/2023.
//  Copyright © 2023 com.owlyapps.onPaperSoccer. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    let interactor: MenuInteracting

    var body: some View {
        VStack {
            Spacer().frame(height: 80)
            
            Text("Grid Soccer")
                .font(.system(size: 36))
            Image("ball_icon")
                .resizable()
                .frame(width: 180, height: 180)
            
            Spacer()
            
            MenuButton(text: "Single Player", color: Color.App.green) {
                interactor.singlePlayerTapped()
            }
        
            MenuButton(text: "Hot Seats", color: Color.App.red) {
                interactor.hotSeatsSelected()
            }
        
            MenuButton(text: "About", color: Color.App.blue) {
                interactor.aboutSelected()
            }
            
            Spacer().frame(height: 80)
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(interactor: MenuInteractorMock())
    }
}

private final class MenuInteractorMock: MenuInteracting {
    func singlePlayerTapped() {}
    func hotSeatsSelected() {}
    func aboutSelected() {}
}
