//
//  MenuButton.swift
//  OnPaperSoccer
//
//  Created by Jakub Sowa on 10/07/2023.
//  Copyright © 2023 com.owlyapps.onPaperSoccer. All rights reserved.
//

import SwiftUI

struct MenuButton: View {
    let text: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                MenuArrow()
                    .fill(color)
                    .frame(width: 80)
                Spacer()
                Text(text)
                    .font(Font.dreamwalker(size: 24))
                    .foregroundColor(Color.App.borderlines)
                Spacer()
                MenuArrow()
                    .fill(color)
                    .rotationEffect(.radians(.pi))
                    .frame(width: 80)
            }
            .frame(height: 54)
        }
    }
}

enum ArrowDirection {
    case left
    case right
}

struct MenuArrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width - rect.height/2, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height/2))
        path.addLine(to: CGPoint(x: rect.width - rect.height/2, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: 0))
        return path
    }
}

struct MenuButton_Previews: PreviewProvider {
    static var previews: some View {
        MenuButton(text: "Fixture", color: .yellow, action: { })
    }
}
