//
// Created by Jakub Sowa on 10/07/2023.
// Copyright (c) 2023 com.owlyapps.onPaperSoccer. All rights reserved.
//

import Foundation
import SwiftUI

struct AboutView: View {
    let interactor: AboutInteracting

    var body: some View {
        VStack {
            Text("Thank you for playing On Paper Soccer. \r\nSource code for this game is public and it can be accessed at: \r\nhttps://github.com/ovvly/OnPaperSoccer")
                .padding()
            Spacer()

            MenuButton(text: "Source code", color: Color.App.green) {
                interactor.sourceCodeTapped()
            }
            MenuButton(text: "Contact us", color: Color.App.red) {
                interactor.contactUsTapped()
            }
            MenuButton(text: "Send us your ideas", color: Color.App.blue) {
                interactor.contactUsTapped()
            }
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView(interactor: AboutInteractorMock())
    }
}

private final class AboutInteractorMock: AboutInteracting {
    func sourceCodeTapped() {}
    func contactUsTapped() {}
    func ideasTapped() {}
}
