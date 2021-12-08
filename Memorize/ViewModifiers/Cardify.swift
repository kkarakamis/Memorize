//
//  Cardify.swift
//  Memorize
//
//  Created by Kutay Karakamış on 7.12.2021.
//

import SwiftUI

// MARK: This "View Modifier" takes view and modify. Makes it a Card

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            let rectangleShape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if isFaceUp {
                rectangleShape.fill().foregroundColor(.white)
                rectangleShape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                content
            } else {
                rectangleShape.fill()
            }
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
